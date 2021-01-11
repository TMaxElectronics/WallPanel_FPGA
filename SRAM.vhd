library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all; 

entity SRAM is
	Port ( 
		LOGIC_CLOCK					: in 	STD_LOGIC;
		
		SRAM_OE						: out 	STD_LOGIC;
		SRAM_WE						: out 	STD_LOGIC;
		SRAM_CE						: out 	STD_LOGIC;
		SRAM_DATA					: inout STD_LOGIC_VECTOR(15 downto 0);
		SRAM_ADDR					: out 	STD_LOGIC_VECTOR(17 downto 0);
		
		BUS_DATA_OUT				: out 	STD_LOGIC_VECTOR(15 downto 0);
		BUS_DATA_IN					: in 	STD_LOGIC_VECTOR(15 downto 0);
		BUS_ADDR_IN					: in 	STD_LOGIC_VECTOR(31 downto 0);
		
		BUS_DIRECTION_IN			: in 	std_logic;		-- 0 write, 1 read
		BUS_RESET					: in 	std_logic;
		BUS_VALID					: out 	std_logic;
		BUS_DONE_OUT				: out 	std_logic
	);
end SRAM;

architecture Behavioral of SRAM is

signal lastAddress			:	STD_LOGIC_VECTOR(31 downto 0);
signal BUS_DATA_INTERNAL	:	STD_LOGIC_VECTOR(15 downto 0);
signal BUS_DONE_INTERNAL	:	STD_LOGIC;
signal OUT_ENABLE			:	STD_LOGIC;
signal ADDRESS_VALID		:	STD_LOGIC;
signal state 				:	STD_LOGIC_VECTOR(7 downto 0);
signal SRAM_OE_INT			:	STD_LOGIC;
signal SRAM_WE_INT			:	STD_LOGIC;
signal SRAM_DOUT			:	STD_LOGIC_VECTOR(15 downto 0);

begin

	OUT_ENABLE <= '1' when (ADDRESS_VALID = '1') else '0';
	ADDRESS_VALID <= '1' when (BUS_ADDR_IN >= x"00000000") and (BUS_ADDR_IN < x"00040000") else '0';
	BUS_VALID <= ADDRESS_VALID;

	BUS_DATA_OUT <= BUS_DATA_INTERNAL when (OUT_ENABLE = '1') and (BUS_DIRECTION_IN = '1') else x"0000"; 

	--Transfer is done when: The address is valid and the operation is a read ; The write has completed
	BUS_DONE_OUT <= BUS_DONE_INTERNAL when OUT_ENABLE = '1' else '0';
	
	SRAM_CE <= '0';
	
	SRAM_DATA <= BUS_DATA_IN when SRAM_WE_INT = '0' else "ZZZZZZZZZZZZZZZZ";
	SRAM_OE <= SRAM_OE_INT;
	SRAM_WE <= SRAM_WE_INT; 
 
	process(LOGIC_CLOCK, ADDRESS_VALID) begin
		if (ADDRESS_VALID = '0') or (BUS_RESET = '1') then
			BUS_DONE_INTERNAL <= '0';
			state <= x"00";
			lastAddress <= BUS_ADDR_IN;
			SRAM_WE_INT <= '1';
			SRAM_OE_INT <= '1';
			BUS_DATA_INTERNAL <= x"0000";

		elsif rising_edge(LOGIC_CLOCK) then
			if not (lastAddress = BUS_ADDR_IN) then
				lastAddress <= BUS_ADDR_IN;
				BUS_DONE_INTERNAL <= '0';
				if BUS_DIRECTION_IN = '1' then	--read
					SRAM_OE_INT <= '0';
					state <= x"0f";
				else
					SRAM_WE_INT <= '0';
					state <= x"1e";
				end if;
				SRAM_ADDR(17 downto 0) <= BUS_ADDR_IN(17 downto 0);
				
			elsif state = x"00" then
				if BUS_DIRECTION_IN = '1' then	--read
					SRAM_OE_INT <= '0';
					state <= x"0f";
				else
					SRAM_WE_INT <= '0';
					state <= x"1e";
				end if;
				SRAM_ADDR(17 downto 0) <= BUS_ADDR_IN(17 downto 0);
				
			elsif state = x"10" then	--read state 1	(address setup time done -> latch data and signal the bus that we are done)
				BUS_DONE_INTERNAL <= '1';
				BUS_DATA_INTERNAL <= SRAM_DATA;
				SRAM_OE_INT <= '1';
				state <= x"30";
				
			elsif state = x"20" then	--read state 1	(write cycle elapsed -> signal the bus that we are done)
				BUS_DONE_INTERNAL <= '1';
				SRAM_WE_INT <= '1';
				state <= x"30";
				
			elsif state = x"30" then	--wait until bus is cleared or a new request started
				state <= x"30";
				BUS_DONE_INTERNAL <= '1';
				
			else
				state <= state + '1';
			end if;
		end if;
	end process;

end Behavioral;