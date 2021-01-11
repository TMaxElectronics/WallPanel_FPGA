library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all; 

entity Master is
	Port ( 
		CLK							: in   	STD_LOGIC;
		
		UART_RX						: in	STD_LOGIC;
		UART_TX						: out	STD_LOGIC;
		
		Matrix_DATA_Out				: out	STD_LOGIC_VECTOR(11 downto 0);
		Matrix_LINE_SEL_Out			: out	STD_LOGIC_VECTOR(3 downto 0);
		Matrix_CTRL_Out				: out	STD_LOGIC_VECTOR(2 downto 0);
		
		SRAM_OE						: out 	STD_LOGIC;
		SRAM_WE						: out 	STD_LOGIC;
		SRAM_CE						: out 	STD_LOGIC;
		SRAM_DATA					: inout STD_LOGIC_VECTOR(15 downto 0);
		SRAM_ADDR					: out 	STD_LOGIC_VECTOR(17 downto 0);
		
		PIC_OE						: in	STD_LOGIC;
		PIC_WE_IN					: in	STD_LOGIC;
		PIC_CS						: in	STD_LOGIC;
		PIC_ADDR_IN					: in 	STD_LOGIC_VECTOR(18 downto 0);
		PIC_DATA_IN					: inout STD_LOGIC_VECTOR(15 downto 0);
		PIC_READY					: out 	std_logic;
		
		LED							: out	STD_LOGIC_VECTOR(7 downto 0)
	);
end Master;

architecture Behavioral of Master is
 
component PLL
port (
	CLKI: in  std_logic; 	
	CLKOP: out  std_logic;	
	CLKOS: out  std_logic);
end component;

signal PIXEL_CLOCK			:	STD_LOGIC;
signal LOGIC_CLOCK			:	STD_LOGIC;
signal LOGIC_CLOCK_HS		:	STD_LOGIC;
signal debug				: 	STD_LOGIC_VECTOR(7 downto 0);

signal BUS_data				:	STD_LOGIC_VECTOR(15 downto 0);
signal BUS_addr				:	STD_LOGIC_VECTOR(31 downto 0);
signal BUS_dir				:	STD_LOGIC := '0';
signal BUS_DONE				:	STD_LOGIC := '0';
signal BUS_VALID			:	STD_LOGIC := '0';
signal BUS_RESET			:	STD_LOGIC := '0';
signal BUS_req				:	STD_LOGIC_VECTOR(3 downto 0);		--0 IDLE, 1 Mdm, 2 PIC, 3 GPU
signal BUS_grant			:	STD_LOGIC_VECTOR(3 downto 0);
signal BUS_currGrantID		:	STD_LOGIC_VECTOR(3 downto 0);

signal PIC_data				:	STD_LOGIC_VECTOR(15 downto 0);
signal PIC_addr				:	STD_LOGIC_VECTOR(31 downto 0);
signal PIC_dir				:	STD_LOGIC := '0';
signal PIC_done				:	STD_LOGIC := '0';
signal PIC_VALID			:	STD_LOGIC := '0';

signal GPU_data				:	STD_LOGIC_VECTOR(15 downto 0);
signal GPU_addr				:	STD_LOGIC_VECTOR(31 downto 0);
signal GPU_dir				:	STD_LOGIC := '0';
signal GPU_done				:	STD_LOGIC := '0';

signal MATRIX_data			:	STD_LOGIC_VECTOR(15 downto 0);
signal MATRIX_done			:	STD_LOGIC := '0';
signal MATRIX_VALID			:	STD_LOGIC := '0';

signal MDM_data				:	STD_LOGIC_VECTOR(15 downto 0);
signal MDM_addr				:	STD_LOGIC_VECTOR(31 downto 0);
signal MDM_dir				:	STD_LOGIC := '0';
signal MDM_RESET			:	STD_LOGIC := '0';
signal MDM_done				:	STD_LOGIC := '0';
signal MDM_VALID			:	STD_LOGIC := '0';

signal SRAM_busdata			:	STD_LOGIC_VECTOR(15 downto 0);
signal SRAM_done			:	STD_LOGIC := '0';
signal SRAM_VALID			:	STD_LOGIC := '0';

signal BUS_DONE_OVERRIDE	:	STD_LOGIC := '0';

signal PIC_busState			:	STD_LOGIC_VECTOR(7 downto 0);

signal VRAM_ADDR			:	STD_LOGIC_VECTOR(7 downto 0);
signal VRAM_DATA			:	STD_LOGIC_VECTOR(119 downto 0);
signal VRAM_WC				:	STD_LOGIC;
signal MATRIX_CURRROW		:	STD_LOGIC_VECTOR(4 downto 0);

begin 

BUS_grant(0) <= '1' when BUS_currGrantID = x"0" else '0';
BUS_grant(1) <= '1' when BUS_currGrantID = x"1" else '0';
BUS_grant(2) <= '1' when BUS_currGrantID = x"2" else '0';
BUS_grant(3) <= '1' when BUS_currGrantID = x"3" else '0'; 

BUS_RESET 	<= MDM_RESET;
BUS_data 	<= PIC_data or MATRIX_data or MDM_data or SRAM_BUSDATA;
BUS_DONE 	<= PIC_done or MATRIX_done or MDM_done or SRAM_DONE or BUS_DONE_OVERRIDE;
BUS_VALID 	<= PIC_VALID or MATRIX_VALID or MDM_VALID or SRAM_VALID;
BUS_dir 	<= PIC_dir or MDM_dir;
BUS_addr 	<= (PIC_addr or MDM_addr) when BUS_currGrantID > x"0" else x"ffffffff";

BUS_req(0) <= '1';

--LED(1 downto 0) <= BUS_currGrantID(1 downto 0);
--LED(2) <= BUS_DONE;
--LED(3) <= VRAM_WC;
--LED(5 downto 4) <= VRAM_DATA(1 downto 0);
LED(7 downto 0) <= debug(7 downto 0);
 
process(LOGIC_CLOCK, BUS_currGrantID) begin
	if BUS_req(to_integer(unsigned(BUS_currGrantID))) = '0' then 
		BUS_currGrantID <= (others => '0');
		BUS_DONE_OVERRIDE <= '0';
		
	elsif RISING_EDGE(LOGIC_CLOCK) then
		if BUS_currGrantID = x"0" then
			if BUS_req(1) = '1' then
				BUS_currGrantID <= x"1";
			elsif BUS_req(2) = '1' then
				BUS_currGrantID <= x"2";
			elsif BUS_req(3) = '1' then
				BUS_currGrantID <= x"3";
			end if;
		else
			if BUS_VALID = '0' then
				BUS_DONE_OVERRIDE <= '1';
			end if;
		end if;
	end if;
end process;

Matrix_LINE_SEL_Out(3) <= '0';

MD : entity work.MatrixDriver
	port map(  
		PIXEL_CLOCK => PIXEL_CLOCK,
		LOGIC_CLOCK	=> LOGIC_CLOCK,
		RGB_OUT => Matrix_DATA_Out,
		MATRIX_CLOCK => Matrix_CTRL_Out(0),
		MATRIX_LAT_OUT => Matrix_CTRL_Out(1), 
		MATRIX_OE_OUT => Matrix_CTRL_Out(2),
		MATRIX_ROWCLK => Matrix_LINE_SEL_Out(0),
		MATRIX_ROWLAT => Matrix_LINE_SEL_Out(1),
		MATRIX_ROWDATA => Matrix_LINE_SEL_Out(2),
		
		VRAM_ADDR	=>	VRAM_ADDR,
		VRAM_DATA	=>	VRAM_DATA,
		VRAM_WC		=>	VRAM_WC,
		
		currRow_out		=> 	MATRIX_CURRROW,
		
		BUS_DATA_OUT	=>	MATRIX_data,
		BUS_DATA_IN		=>	BUS_DATA,
		BUS_ADDR_IN		=>	BUS_addr,
		BUS_VALID		=>	MATRIX_VALID,
		BUS_GRANT	=>	'0',
		
		BUS_DIRECTION_IN	=> 	BUS_dir,
		debug				=>	debug,
		BUS_DONE_OUT		=>  MATRIX_DONE
	);  
MDM : entity work.MatrixBusHandler
	port map( 
		LOGIC_CLOCK => 	LOGIC_CLOCK,
		
		VRAM_ADDR	=>	VRAM_ADDR,
		VRAM_DATA	=>	VRAM_DATA,
		VRAM_WC		=>	VRAM_WC,
		
		currRow		=> 	MATRIX_CURRROW,
		
		BUS_DATA_OUT	=>	MDM_data,
		BUS_DATA_IN		=>	BUS_DATA,
		BUS_ADDR_OUT	=>	MDM_ADDR,
		BUS_ADDR_IN		=>	BUS_addr,
		BUS_VALID		=>	MDM_VALID,
		BUS_RESET		=>	MDM_RESET,
		BUS_REQ			=>	BUS_req(1),
		BUS_GRANT		=>	BUS_grant(1),
		
		BUS_DIRECTION_OUT	=> 	MDM_dir,
		BUS_DIRECTION_IN	=> 	BUS_dir,
		BUS_DONE_OUT		=> 	MDM_DONE,
		BUS_DONE_IN			=> 	BUS_DONE
	);
	
RAM : entity work.SRAM 
	Port map ( 
		LOGIC_CLOCK => 	LOGIC_CLOCK,
		
		SRAM_OE		=> SRAM_OE,
		SRAM_WE		=> SRAM_WE,
		SRAM_CE		=> SRAM_CE,
		SRAM_DATA	=> SRAM_DATA,
		SRAM_ADDR	=> SRAM_ADDR,
		BUS_VALID	=> SRAM_VALID,
		BUS_DATA_OUT=> SRAM_busdata,
		BUS_DATA_IN	=> BUS_DATA,
		BUS_ADDR_IN	=> BUS_ADDR,
		BUS_RESET	=> BUS_RESET,
		
		BUS_DIRECTION_IN => BUS_dir,
		BUS_DONE_OUT	=> SRAM_DONE
	);
	
PIC_BUS_INTERFACE : entity work.PIC 
	Port map( 
		LOGIC_CLOCK => 	LOGIC_CLOCK,
		
		PIC_OE_IN => 	PIC_OE,
		PIC_WE_IN => 	PIC_WE_IN,
		PIC_CS_IN => 	PIC_CS,
		PIC_ADDR_IN => 	PIC_ADDR_IN,
		PIC_DATA_IN => 	PIC_DATA_IN,
		PIC_READY => 	PIC_READY,
		
		BUS_DATA_OUT	=>	PIC_DATA,
		BUS_DATA_IN		=> 	BUS_DATA,
		BUS_ADDR_OUT	=>	PIC_ADDR,
		BUS_ADDR_IN		=> 	BUS_ADDR,
		BUS_VALID		=>	PIC_VALID,
		BUS_REQ		=>	BUS_req(2),
		BUS_GRANT	=>	BUS_grant(2),
		
		BUS_DIRECTION_OUT	=> 	PIC_dir,
		BUS_DIRECTION_IN	=> 	BUS_dir,
		BUS_DONE_OUT		=> 	PIC_DONE,
		BUS_DONE_IN			=> 	BUS_DONE
	);

--PIXEL_CLOCK <= CLK;
PLL_Ent: PLL
    port map(
		CLKI => CLK, 
		CLKOP => LOGIC_CLOCK,
		CLKOS => PIXEL_CLOCK
	);


end Behavioral;