library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all; 

entity MatrixDriver is
	Port ( 
		PIXEL_CLOCK							: 	in STD_LOGIC;
		LOGIC_CLOCK							: 	in STD_LOGIC;
		
		RGB_OUT								: 	out	STD_LOGIC_VECTOR(11 downto 0);
		MATRIX_CLOCK						: 	out STD_LOGIC;
		MATRIX_LAT_OUT						: 	out	STD_LOGIC;
		MATRIX_OE_OUT						: 	out	STD_LOGIC;
		MATRIX_ROWCLK						:	out	STD_LOGIC;
		MATRIX_ROWLAT						:	out	STD_LOGIC;
		MATRIX_ROWDATA						:	out	STD_LOGIC;
		
		VRAM_ADDR							: in	STD_LOGIC_VECTOR(7 downto 0);
		VRAM_DATA							: in	STD_LOGIC_VECTOR(119 downto 0);
		VRAM_WC								: in	STD_LOGIC;
		
		currRow_out							: out	STD_LOGIC_VECTOR(4 downto 0);
			
		BUS_DATA_OUT						: out 	STD_LOGIC_VECTOR(15 downto 0);
		BUS_DATA_IN							: in 	STD_LOGIC_VECTOR(15 downto 0);
		BUS_ADDR_OUT						: out 	STD_LOGIC_VECTOR(31 downto 0);
		BUS_ADDR_IN							: in 	STD_LOGIC_VECTOR(31 downto 0);
		
		BUS_REQ								: out 	std_logic;
		BUS_GRANT							: in 	std_logic;
		BUS_VALID							: out 	std_logic;
		
		debug								: out 	std_logic_vector(7 downto 0);
		
		BUS_DIRECTION_IN					: in 	std_logic; 
		BUS_DONE_OUT						: out 	std_logic
	);
end MatrixDriver; 

architecture Behavioral of MatrixDriver is

	component Outputbuffer
		port (
        WrAddress: in  std_logic_vector(7 downto 0); 
        RdAddress: in  std_logic_vector(7 downto 0); 
        Data: in  std_logic_vector(119 downto 0); 
        WE: in  std_logic; 
        RdClock: in  std_logic; 
        RdClockEn: in  std_logic; 
        Reset: in  std_logic; 
        WrClock: in  std_logic; 
        WrClockEn: in  std_logic; 
        Q: out  std_logic_vector(119 downto 0));
	end component;

	signal MATRIX_LAT			: 	STD_LOGIC;
	signal MATRIX_OE			: 	STD_LOGIC;
	signal currPixel			:	STD_LOGIC_VECTOR(7 downto 0);
	signal currBit				:	STD_LOGIC_VECTOR(3 downto 0) := x"0";
	signal currRow				:	STD_LOGIC_VECTOR(4 downto 0);
	signal lastRow				:	STD_LOGIC_VECTOR(4 downto 0);

	type GammaArray is array (0 to 255) of std_logic_vector(9 downto 0);
	signal GammaMap				:	GammaArray;

	type ColorData is array (0 to 3) of std_logic_vector(9 downto 0);
	signal RED					:	ColorData;
	signal GREEN				:	ColorData;
	signal BLUE					:	ColorData;

	type   PWMArrayType is array (0 to 15) of std_logic_vector(15 downto 0);
	signal PWMArray				:	PWMArrayType;
	signal PWMMaxArray				:	PWMArrayType;

	signal MATRIX_CLKEN			:	STD_LOGIC := '0';
	signal MATRIX_CLKEN_LAT		:	STD_LOGIC;

	signal VRAM_READ_ADDR		:	STD_LOGIC_VECTOR(7 downto 0);
	signal VRAM_PAGEMAPPING		:	STD_LOGIC := '0';
	signal VRAM_DOUT			:	STD_LOGIC_VECTOR(119 downto 0);
	signal VRAM_READ_CLK		:	STD_LOGIC;

	signal brightness			:	STD_LOGIC_VECTOR(15 downto 0) := x"000f";
	signal currPWMVal			:	STD_LOGIC_VECTOR(15 downto 0);
	signal currPWMCount			:	STD_LOGIC_VECTOR(15 downto 0);
	signal currPWMCountMax		:	STD_LOGIC_VECTOR(15 downto 0);
	signal rowDataOverride		:	STD_LOGIC;
	signal PWMDone				:	STD_LOGIC; 

	signal OUT_ENABLE					:	STD_LOGIC;
	signal ADDRESS_VALID				:	STD_LOGIC;

	signal BUS_DIRECTION_INTERNAL		:	STD_LOGIC;		-- 0 write, 1 read
	signal BUS_DATA_INTERNAL			:	STD_LOGIC_VECTOR(15 downto 0);
	 
	signal WRITE_DONE					:	std_logic;
	signal readData						:	STD_LOGIC_VECTOR(15 downto 0);
	
	signal VRAM_WRITE_ADDR				:	STD_LOGIC_VECTOR(7 downto 0);

begin

	MATRIX_OE_OUT <= MATRIX_OE;
	MATRIX_LAT_OUT <= MATRIX_LAT;

	RED(0)		<= VRAM_DOUT(9 downto 0);
	GREEN(0)	<= VRAM_DOUT(19 downto 10);
	BLUE(0)		<= VRAM_DOUT(29 downto 20);

	RED(1)	 	<= VRAM_DOUT(39 downto 30);
	GREEN(1) 	<= VRAM_DOUT(49 downto 40);
	BLUE(1)	 	<= VRAM_DOUT(59 downto 50);

	RED(2) 		<= VRAM_DOUT(69 downto 60);
	GREEN(2) 	<= VRAM_DOUT(79 downto 70);
	BLUE(2) 	<= VRAM_DOUT(89 downto 80);

	RED(3) 		<= VRAM_DOUT(99 downto 90);
	GREEN(3) 	<= VRAM_DOUT(109 downto 100);
	BLUE(3)	 	<= VRAM_DOUT(119 downto 110);

	RGB_OUT(0)		<= RED(0)(to_integer(unsigned(currBit)));
	RGB_OUT(1)		<= GREEN(0)(to_integer(unsigned(currBit)));
	RGB_OUT(2)		<= BLUE(0)(to_integer(unsigned(currBit)));

	RGB_OUT(3)		<= RED(1)(to_integer(unsigned(currBit)));
	RGB_OUT(4)		<= GREEN(1)(to_integer(unsigned(currBit)));
	RGB_OUT(5)		<= BLUE(1)(to_integer(unsigned(currBit)));

	RGB_OUT(6)		<= RED(2)(to_integer(unsigned(currBit)));
	RGB_OUT(7)		<= GREEN(2)(to_integer(unsigned(currBit)));
	RGB_OUT(8)		<= BLUE(2)(to_integer(unsigned(currBit)));

	RGB_OUT(9)		<= RED(3)(to_integer(unsigned(currBit)));
	RGB_OUT(10)		<= GREEN(3)(to_integer(unsigned(currBit)));
	RGB_OUT(11)		<= BLUE(3)(to_integer(unsigned(currBit)));

	VRAM_READ_CLK <= not PIXEL_CLOCK;

	MATRIX_ROWDATA <= '1' when currRow = "00000" else '0';

	currRow_out <= currRow;
	 
	process(PIXEL_CLOCK) begin
		if RISING_EDGE(PIXEL_CLOCK) then
			if currPixel < x"80" then
				
				currPixel <= currPixel + '1';
			elsif currPixel = x"80" then
				MATRIX_CLKEN <= '0';
				
				--continue once PWM has finished the pulse
				if PWMDone = '1' then
					currPixel <= currPixel + '1';
				end if;
			elsif currPixel = x"81" then
				MATRIX_LAT <= '1';
				currPixel <= currPixel + '1';
				if not (lastRow = currRow) then
					lastRow <= currRow;
					MATRIX_ROWCLK <= '1';
				end if;
			elsif currPixel = x"82" then
				MATRIX_ROWCLK <= '0';
				MATRIX_ROWLAT <= '1';
				currPixel <= x"83";
				
				if currBit >= x"9" then
					currBit <= x"0";
					currRow <= currRow + '1';
					VRAM_PAGEMAPPING <= not VRAM_PAGEMAPPING;
				else
					currBit <= currBit + '1';
				end if;
				
			elsif currPixel = x"83" then
				MATRIX_LAT <= '0';
				MATRIX_ROWLAT <= '0';
				MATRIX_CLKEN <= '1';
				currPixel <= x"00";
				
			else
				currPixel <= x"00";
			end if;
		end if;
		
		if FALLING_EDGE(PIXEL_CLOCK) then
			if currPixel = x"83" then
				currPWMVal <= PWMArray(to_integer(unsigned(currBit)));
				currPWMCountMax <= PWMMaxArray(to_integer(unsigned(currBit)));
			end if;
			MATRIX_CLKEN_LAT <= MATRIX_CLKEN;
		end if;
	end process;

	MATRIX_CLOCK <= PIXEL_CLOCK when MATRIX_CLKEN_LAT = '1' else '0';
	 
	MATRIX_OE <= '0' when currPWMCount < currPWMVal else '1';
	PWMDone <= '0' when currPWMCount < currPWMCountMax else '1';
	process(LOGIC_CLOCK) begin
		if MATRIX_LAT = '1' then
			currPWMCount <= x"ffff";
		elsif RISING_EDGE(LOGIC_CLOCK) then
			if currPWMCount < currPWMCountMax then
				currPWMCount <= currPWMCount + '1';
			elsif currPWMCount = x"ffff" then
				currPWMCount <= x"0000";
			end if;
		end if;
	end process;

	PWMArray(1)(3 downto 0) <= brightness(3 downto 0);
	PWMArray(2)(4 downto 1) <= brightness(3 downto 0);
	PWMArray(3)(5 downto 2) <= brightness(3 downto 0);
	PWMArray(4)(6 downto 3) <= brightness(3 downto 0);
	PWMArray(5)(7 downto 4) <= brightness(3 downto 0);
	PWMArray(6)(8 downto 5) <= brightness(3 downto 0);
	PWMArray(7)(9 downto 6) <= brightness(3 downto 0);
	PWMArray(8)(10 downto 7) <= brightness(3 downto 0);
	PWMArray(9)(11 downto 8) <= brightness(3 downto 0);
	PWMArray(0)(12 downto 9) <= brightness(3 downto 0); 

	PWMMaxArray(0) <= x"1E00";
	PWMMaxArray(1) <= x"000f";
	PWMMaxArray(2) <= x"001E";
	PWMMaxArray(3) <= x"003C";
	PWMMaxArray(4) <= x"0078";
	PWMMaxArray(5) <= x"00F0";
	PWMMaxArray(6) <= x"01E0";
	PWMMaxArray(7) <= x"03C0";
	PWMMaxArray(8) <= x"0780";
	PWMMaxArray(9) <= x"0F00";
										
	VRAM_READ_ADDR(7) <= VRAM_PAGEMAPPING;
	VRAM_WRITE_ADDR(7) <= not VRAM_PAGEMAPPING;
	VRAM_READ_ADDR(6 downto 0) <= currPixel(6 downto 0);
	VRAM_WRITE_ADDR(6 downto 0) <= VRAM_ADDR(6 downto 0);
	
	--debug(0) <= VRAM_READ_CLK;
	--debug(3 downto 1) <= VRAM_DOUT(3 downto 1);
	--debug(7 downto 4) <= VRAM_READ_ADDR(7 downto 4);

	--VRAM_DOUT <= x"ff000000ff000000ff0050ff";

	VRam: Outputbuffer 
		port map(
			WrAddress 		=>	VRAM_WRITE_ADDR,
			RdAddress 		=> 	VRAM_READ_ADDR,
			Data 			=> 	VRAM_DATA,
			WE 				=> 	'1',
			RdClock 		=> 	VRAM_READ_CLK,
			RdClockEn		=>	'1',
			Reset			=> 	'0',
			WrClock			=>	VRAM_WC, 
			WrClockEn		=>	'1',
			Q				=> 	VRAM_DOUT
		);
		
-- bus logic
	ADDRESS_VALID <= '1' when ((BUS_ADDR_IN >= x"40480") and (BUS_ADDR_IN < x"40481")) else '0';
	BUS_VALID <= ADDRESS_VALID;

	BUS_DATA_OUT <= BUS_DATA_INTERNAL when (ADDRESS_VALID = '1') and (BUS_DIRECTION_IN = '1') else x"0000"; 
	BUS_DATA_INTERNAL <= readData when ADDRESS_VALID <= '1' else x"0000";
	
	with BUS_ADDR_IN select readData <= 	brightness when x"00040480",
											x"0000" when others; 
											
	BUS_DONE_OUT <= '1' when (ADDRESS_VALID = '1') and (BUS_DIRECTION_IN = '1') else WRITE_DONE;

	process(LOGIC_CLOCK) begin
		if (ADDRESS_VALID = '0') or (BUS_DIRECTION_IN = '1') then
			WRITE_DONE <= '0';
		elsif falling_edge(LOGIC_CLOCK) then
			WRITE_DONE <= '1'; 
			if BUS_ADDR_IN = x"40480" then
				brightness(3 downto 0) <= BUS_DATA_IN(3 downto 0); 
			end if;
		end if;
	end process;

end Behavioral;