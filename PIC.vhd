library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all; 

entity PIC is
	Port ( 
		LOGIC_CLOCK					: in 	STD_LOGIC;
		
		PIC_OE_IN					: in	STD_LOGIC;
		PIC_WE_IN					: in	STD_LOGIC;
		PIC_CS_IN					: in	STD_LOGIC;
		PIC_ADDR_IN					: in 	STD_LOGIC_VECTOR(18 downto 0);
		PIC_DATA_IN					: inout STD_LOGIC_VECTOR(15 downto 0);
		PIC_READY					: out 	std_logic;
		
		BUS_DATA_OUT				: out 	STD_LOGIC_VECTOR(15 downto 0);
		BUS_DATA_IN					: in 	STD_LOGIC_VECTOR(15 downto 0);
		BUS_ADDR_OUT				: out 	STD_LOGIC_VECTOR(31 downto 0);
		BUS_ADDR_IN					: in 	STD_LOGIC_VECTOR(31 downto 0);
		
		BUS_REQ						: out 	std_logic;
		BUS_GRANT					: in 	std_logic;
		
		BUS_DIRECTION_OUT			: out 	std_logic;
		BUS_DIRECTION_IN			: in 	std_logic;
		BUS_DONE_OUT				: out 	std_logic;
		BUS_VALID					: out 	std_logic;
		BUS_DONE_IN					: in 	std_logic
	);
end PIC;

architecture Behavioral of PIC is

signal OUT_ENABLE					:	STD_LOGIC;
signal ADDRESS_VALID				:	STD_LOGIC;

signal BUS_DIRECTION_INTERNAL		:	STD_LOGIC;		-- 0 write, 1 read
signal BUS_DATA_INTERNAL			:	STD_LOGIC_VECTOR(15 downto 0);
signal BUS_ADDR_INTERNAL			:	STD_LOGIC_VECTOR(31 downto 0) := "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU";
signal lastAddress					:	STD_LOGIC_VECTOR(18 downto 0);

signal WRITE_DONE					:	std_logic;
signal data							:	STD_LOGIC_VECTOR(15 downto 0);
signal readData						:	STD_LOGIC_VECTOR(15 downto 0);
signal writeData					:	STD_LOGIC_VECTOR(15 downto 0);

signal state						:	std_logic_vector(7 downto 0);

signal transferMode					:	STD_LOGIC_VECTOR(3 downto 0) := x"0";
signal transferMode16				:	STD_LOGIC_VECTOR(15 downto 0);

signal rModDataRead					:	STD_LOGIC_VECTOR(7 downto 0);
signal rModDataWrite				:	STD_LOGIC_VECTOR(16 downto 0);
signal rModDataWriteShift			:	STD_LOGIC_VECTOR(15 downto 0);
signal rModDataTrans				:	STD_LOGIC_VECTOR(7 downto 0);

begin

--BUS Logic:

	OUT_ENABLE <= '1' when ((BUS_GRANT = '1') and (BUS_DIRECTION_IN = '0')) or ((ADDRESS_VALID = '1') and (BUS_DIRECTION_IN = '1')) else '0';
	ADDRESS_VALID <= '1' when (BUS_ADDR_IN >= x"00040500") and (BUS_ADDR_IN < x"00040501") else '0';
	BUS_VALID <= ADDRESS_VALID;

	BUS_DATA_OUT <= BUS_DATA_INTERNAL when OUT_ENABLE = '1' else x"0000"; 
	BUS_ADDR_OUT <= BUS_ADDR_INTERNAL when BUS_GRANT = '1' else x"00000000"; 
	BUS_DATA_INTERNAL <= writeData when ((BUS_GRANT = '1') and (BUS_DIRECTION_INTERNAL = '0')) else readData;

	BUS_DIRECTION_OUT <= BUS_DIRECTION_INTERNAL when (BUS_GRANT = '1') else '0'; 

	--Transfer is done when: The address is valid and the operation is a read ; The write has completed
	BUS_DONE_OUT <= '1' when (ADDRESS_VALID = '1') and (BUS_DIRECTION_IN = '1') else WRITE_DONE;

	transferMode16(3 downto 0) <= transferMode(3 downto 0);transferMode16(15 downto 4) <= (others => '0');
	with BUS_ADDR_IN select readData <=	transferMode16 when x"00040500",
											x"0000" when others;

	process(LOGIC_CLOCK) begin
		if (ADDRESS_VALID = '0') or (BUS_DIRECTION_IN = '1') then
			WRITE_DONE <= '0';
		elsif rising_edge(LOGIC_CLOCK) then
			WRITE_DONE <= '1';
			if BUS_ADDR_IN = x"00040500" then
				transferMode(3 downto 0) <= BUS_DATA_IN(3 downto 0);
			end if;
		end if;
	end process;
	
	
	
--PIC Logic:

	rModDataWrite <= std_logic_vector((unsigned(rModDataRead) * (to_unsigned(256, 9) - unsigned(rModDataTrans))) + (unsigned(data(7 downto 0)) * unsigned(rModDataTrans)));
	rModDataWriteShift(7 downto 0) <= rModDataWrite(15 downto 8); rModDataWriteShift(15 downto 8) <= (others => '0');

	PIC_DATA_IN <= BUS_DATA_IN when PIC_OE_IN = '0' else "ZZZZZZZZZZZZZZZZ";
	data <= PIC_DATA_IN when PIC_WE_IN = '0' else x"0000";

	process(LOGIC_CLOCK, PIC_ADDR_IN, PIC_OE_IN, PIC_WE_IN) begin
		if ((PIC_OE_IN = '1') and (PIC_WE_IN = '1')) or (not (lastAddress = PIC_ADDR_IN)) then
			BUS_REQ <= '0';
			lastAddress <= PIC_ADDR_IN;
			PIC_READY <= '0';
			state <= x"00";
			 
		elsif rising_edge(LOGIC_CLOCK) then
			if state = x"00" then
				state <= x"01";
				
			elsif state = x"01" then
				BUS_ADDR_INTERNAL(31 downto 19) <= (others => '0');
				BUS_ADDR_INTERNAL(18 downto 0) <= PIC_ADDR_IN(18 downto 0);
				writeData <= data;
				rModDataTrans(7 downto 0) <= data(15 downto 8);
				
				if ((transferMode = x"1") and (PIC_WE_IN = '0')) and (not (data(15 downto 8) = x"ff")) then
					state <= x"10";
					BUS_DIRECTION_INTERNAL <= '1'; 
				else
					state <= x"02";
					BUS_DIRECTION_INTERNAL <= PIC_WE_IN; 
				end if;
				
			elsif state = x"02" then
				state <= x"ff";
				BUS_REQ <= '1';
				
				
--read modify write				
			elsif state = x"10" then
				state <= x"11";
				BUS_REQ <= '1';
				
			elsif state = x"11" then
				if (BUS_GRANT = '1') and (BUS_DONE_IN = '1') then
					state <= x"12";
					rModDataRead <= BUS_DATA_IN(7 downto 0);
					BUS_REQ <= '0';
					BUS_DIRECTION_INTERNAL <= '0'; 
				end if;
				
			elsif state = x"12" then
				writeData <= rModDataWriteShift;
				BUS_REQ <= '1';
				state <= x"ff";
				
			elsif state = x"ff" then
				--BUS_REQ <= '1';
				if (BUS_GRANT = '1') and (BUS_DONE_IN = '1') then
					PIC_READY <= '1';
				end if;
				
			end if;
			
		end if;
	end process;

end Behavioral;