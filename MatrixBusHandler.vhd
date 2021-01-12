library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all; 

entity MatrixBusHandler is
	Port ( 
		LOGIC_CLOCK					: in 	STD_LOGIC;
		
		VRAM_ADDR					: out	STD_LOGIC_VECTOR(9 downto 0);
		VRAM_DATA					: out	STD_LOGIC_VECTOR(29 downto 0);
		VRAM_DATA_IN				: in	STD_LOGIC_VECTOR(29 downto 0);
		VRAM_WC						: out	STD_LOGIC;
		VRAM_WE						: out	STD_LOGIC;
		
		currRow						: in	STD_LOGIC_VECTOR(4 downto 0);
		
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
		BUS_RESET					: out 	std_logic;
		BUS_DONE_IN					: in 	std_logic
	);
end MatrixBusHandler;

architecture Behavioral of MatrixBusHandler is

	component GammaRam
		port (
			DataInA: in  std_logic_vector(9 downto 0); 
			DataInB: in  std_logic_vector(9 downto 0); 
			AddressA: in  std_logic_vector(7 downto 0); 
			AddressB: in  std_logic_vector(7 downto 0); 
			ClockA: in  std_logic; 
			ClockB: in  std_logic; 
			ClockEnA: in  std_logic; 
			ClockEnB: in  std_logic;  
			WrA: in  std_logic; 
			WrB: in  std_logic; 
			ResetA: in  std_logic; 
			ResetB: in  std_logic; 
			QA: out  std_logic_vector(9 downto 0); 
			QB: out  std_logic_vector(9 downto 0));
	end component;
	
	component SpriteRam
		port (
			WrAddress: in  std_logic_vector(13 downto 0); 
			RdAddress: in  std_logic_vector(13 downto 0); 
			Data: in  std_logic_vector(8 downto 0); 
			WE: in  std_logic; 
			RdClock: in  std_logic; 
			RdClockEn: in  std_logic; 
			Reset: in  std_logic; 
			WrClock: in  std_logic; 
			WrClockEn: in  std_logic; 
			Q: out  std_logic_vector(8 downto 0));
	end component;
	
	component LUT_RAM
		port (
			DataInA: in  std_logic_vector(8 downto 0); 
			DataInB: in  std_logic_vector(8 downto 0); 
			AddressA: in  std_logic_vector(8 downto 0); 
			AddressB: in  std_logic_vector(8 downto 0); 
			ClockA: in  std_logic; 
			ClockB: in  std_logic; 
			ClockEnA: in  std_logic; 
			ClockEnB: in  std_logic; 
			WrA: in  std_logic; 
			WrB: in  std_logic; 
			ResetA: in  std_logic; 
			ResetB: in  std_logic; 
			QA: out  std_logic_vector(8 downto 0); 
			QB: out  std_logic_vector(8 downto 0));
	end component;

	signal state		:	STD_LOGIC_VECTOR(7 downto 0);
	signal currReadRow	:	STD_LOGIC_VECTOR(4 downto 0);
	signal lastReadRow	:	STD_LOGIC_VECTOR(4 downto 0);

	signal offsetLatchMode	:	STD_LOGIC_VECTOR(3 downto 0);
	signal offsetLatchClock	:	STD_LOGIC;
	signal offsetLatchClockOrd	:	STD_LOGIC;
	signal xOffset_pre	:	STD_LOGIC_VECTOR(7 downto 0); 
	signal yOffset_pre	:	STD_LOGIC_VECTOR(7 downto 0);
	signal xOffset		:	STD_LOGIC_VECTOR(7 downto 0) := x"00"; 
	signal yOffset		:	STD_LOGIC_VECTOR(7 downto 0) := x"00";
	signal xOffset_16		:	STD_LOGIC_VECTOR(15 downto 0); 
	signal yOffset_16		:	STD_LOGIC_VECTOR(15 downto 0);

	signal x			:	STD_LOGIC_VECTOR(7 downto 0);
	signal y			:	STD_LOGIC_VECTOR(7 downto 0);
	signal ywithOffset	:	STD_LOGIC_VECTOR(7 downto 0);
	signal xPre			:	STD_LOGIC_VECTOR(7 downto 0);
	signal yPre			:	STD_LOGIC_VECTOR(7 downto 0);

	signal currColor	:	STD_LOGIC_VECTOR(3 downto 0);	
	signal currAddress	:	STD_LOGIC_VECTOR(31 downto 0);	
	signal currRowOffset:	STD_LOGIC_VECTOR(1 downto 0);
	signal currValue	:	STD_LOGIC_VECTOR(7 downto 0);
	
	signal currRowOffset_lat:	STD_LOGIC_VECTOR(1 downto 0);
	signal currColor_lat	:	STD_LOGIC_VECTOR(3 downto 0);	
	signal xPre_lat			:	STD_LOGIC_VECTOR(7 downto 0);

	signal BUS_ADDR_INTERNAL	:	STD_LOGIC_VECTOR(31 downto 0);

	type PixelData is array (0 to 2) of std_logic_vector(9 downto 0);
	signal data			:	PixelData;
	
	signal otherData			:	std_logic_vector(15 downto 0);

	signal OUT_ENABLE					:	STD_LOGIC;
	signal ADDRESS_VALID				:	STD_LOGIC;
	signal reset						:	STD_LOGIC;

	signal BUS_DIRECTION_INTERNAL		:	STD_LOGIC;		-- 0 write, 1 read
	signal BUS_DATA_INTERNAL			:	STD_LOGIC_VECTOR(15 downto 0);
	 
	signal transferDone					:	std_logic;
	signal we							:	std_logic;
	signal readData						:	STD_LOGIC_VECTOR(15 downto 0);
	signal BUS_transferState			:	std_logic_vector(3 downto 0);


	signal xBuf		:	STD_LOGIC_VECTOR(11 downto 0);
	signal xOut		:	STD_LOGIC_VECTOR(7 downto 0);
	signal yBuf		:	STD_LOGIC_VECTOR(11 downto 0);
	signal yBuf2	:	STD_LOGIC_VECTOR(11 downto 0);
	signal yOut		:	STD_LOGIC_VECTOR(7 downto 0);
	signal yOut2	:	STD_LOGIC_VECTOR(7 downto 0);
	signal roBuf	:	STD_LOGIC_VECTOR(11 downto 0);
	signal roOut	:	STD_LOGIC_VECTOR(7 downto 0);
	
	signal latchMode			:	STD_LOGIC_VECTOR(3 downto 0) := x"0";
	signal latchMode16			:	STD_LOGIC_VECTOR(15 downto 0);
	signal ena_lineInt			:	STD_LOGIC;
	signal intLineSelect		:	STD_LOGIC_VECTOR(4 downto 0);
	signal flg_lineInt			:	STD_LOGIC;
	signal ena_FrameInt			:	STD_LOGIC;
	signal REG_latchConfig		:	STD_LOGIC_VECTOR(15 downto 0);
	signal REG_intConfig		:	STD_LOGIC_VECTOR(15 downto 0);
	signal latchForce			:	STD_LOGIC := '0';
	signal frameEndClock		:	STD_LOGIC;
	
	signal GR_WR_DIN			:	STD_LOGIC_VECTOR(9 downto 0);
	signal GR_WR_DOUT			:	STD_LOGIC_VECTOR(9 downto 0);
	signal GR_WR_DOUT_16		:	STD_LOGIC_VECTOR(15 downto 0);
	signal GR_RE_DOUT			:	STD_LOGIC_VECTOR(9 downto 0);
	signal GR_WR_ADDR			:	STD_LOGIC_VECTOR(7 downto 0);
	signal GR_RE_ADDR			:	STD_LOGIC_VECTOR(7 downto 0);
	signal GR_WR_CLK			:	STD_LOGIC;
	signal GR_WE				:	STD_LOGIC;
	signal GR_RE_CLK			:	STD_LOGIC;
	
	type Sprite_positions_array is array 	(0 to 39) of std_logic_vector(15 downto 0);
	type Sprite_sizes_array is array 		(0 to 39) of std_logic_vector(15 downto 0);
	type Sprite_options_array is array 		(0 to 39) of std_logic_vector(15 downto 0);
	type Sprite_pointers_array is array 	(0 to 39) of std_logic_vector(15 downto 0);
	signal Sprite_positions		:	Sprite_positions_array;
	signal Sprite_sizes			:	Sprite_sizes_array;
	signal Sprite_options		:	Sprite_options_array;
	signal Sprite_pointers		:	Sprite_pointers_array;
	signal Sprite_readData2		:	std_logic_vector(15 downto 0);
	signal otherData2			:	std_logic_vector(15 downto 0);
	
	signal Sprite_writeAddr		:	STD_LOGIC_VECTOR(14 downto 0);
	signal Sprite_writeData		:	STD_LOGIC_VECTOR(8 downto 0);
	signal Sprite_writeClk		:	STD_LOGIC;
	signal Sprite_readAddr		:	STD_LOGIC_VECTOR(15 downto 0);
	signal Sprite_readData		:	STD_LOGIC_VECTOR(8 downto 0);
	signal Sprite_readClk		:	STD_LOGIC;
	
	signal SpriteRead_addrStart	:	STD_LOGIC_VECTOR(15 downto 0);
	signal SpriteRead_yInSprite	:	STD_LOGIC_VECTOR(7 downto 0);
	signal SpriteRead_xInSprite	:	STD_LOGIC_VECTOR(7 downto 0);
	signal SpriteRead_yValid	:	STD_LOGIC;
	signal SpriteRead_xValid	:	STD_LOGIC;
	signal SpriteRead_spriteValid:	STD_LOGIC;
	signal currSprite			:	STD_LOGIC_VECTOR(7 downto 0);
	signal currSprite_pos		:	STD_LOGIC_VECTOR(15 downto 0);
	signal currSprite_x			:	STD_LOGIC_VECTOR(7 downto 0);
	signal currSprite_y			:	STD_LOGIC_VECTOR(7 downto 0);
	signal currSprite_size		:	STD_LOGIC_VECTOR(15 downto 0);
	signal currSprite_width		:	STD_LOGIC_VECTOR(7 downto 0);
	signal currSprite_height	:	STD_LOGIC_VECTOR(7 downto 0);
	signal currSprite_conf		:	STD_LOGIC_VECTOR(15 downto 0);
	signal currSprite_data		:	STD_LOGIC_VECTOR(8 downto 0);
	signal currSprite_pointer	:	STD_LOGIC_VECTOR(15 downto 0);
	
	signal writeState			:	STD_LOGIC_VECTOR(3 downto 0);
	signal SpriteLut_writeClk	:	STD_LOGIC;
	signal SpriteLut_readClk	:	STD_LOGIC;
	signal SpriteLut_WE			:	STD_LOGIC;
	
	signal SpriteLut_writeData		:	STD_LOGIC_VECTOR(8 downto 0);
	signal SpriteLut_writeAddr		:	STD_LOGIC_VECTOR(8 downto 0);
	
	signal RED_READ		:	STD_LOGIC_VECTOR(8 downto 0);
	signal GREEN_READ	:	STD_LOGIC_VECTOR(8 downto 0);
	signal BLUE_READ	:	STD_LOGIC_VECTOR(8 downto 0);
	signal ALPHA_READ	:	STD_LOGIC_VECTOR(8 downto 0);
	 
	signal RED_WE		:	STD_LOGIC;
	signal GREEN_WE		:	STD_LOGIC;
	signal BLUE_WE		:	STD_LOGIC;
	signal ALPHA_WE		:	STD_LOGIC;
	
	signal RED_WRITE	:	STD_LOGIC_VECTOR(8 downto 0);
	signal GREEN_WRITE	:	STD_LOGIC_VECTOR(8 downto 0);
	signal BLUE_WRITE	:	STD_LOGIC_VECTOR(8 downto 0);
	signal ALPHA_WRITE	:	STD_LOGIC_VECTOR(8 downto 0);
	
	 
	signal RED_IN		:	STD_LOGIC_VECTOR(9 downto 0);
	signal GREEN_IN		:	STD_LOGIC_VECTOR(9 downto 0);
	signal BLUE_IN		:	STD_LOGIC_VECTOR(9 downto 0);
	
	signal RED_OUT		:	STD_LOGIC_VECTOR(9 downto 0);
	signal GREEN_OUT	:	STD_LOGIC_VECTOR(9 downto 0);
	signal BLUE_OUT		:	STD_LOGIC_VECTOR(9 downto 0);
	signal RED_OUT_PRE	:	STD_LOGIC_VECTOR(18 downto 0);
	signal GREEN_OUT_PRE:	STD_LOGIC_VECTOR(18 downto 0);
	signal BLUE_OUT_PRE	:	STD_LOGIC_VECTOR(18 downto 0);
	
	signal lut_read16			:	std_logic_vector(15 downto 0);
	signal lut_read				:	std_logic_vector(8 downto 0);
	signal currRowOffset_MULT	:	STD_LOGIC_VECTOR(7 downto 0);
	
begin

	VRAM_DATA(9 downto 0) <= 	data(0);
	VRAM_DATA(19 downto 10) <= data(1);
	VRAM_DATA(29 downto 20) <= data(2);
	
	
	currRowOffset_MULT(6 downto 5) <= currRowOffset(1 downto 0); currRowOffset_MULT(4 downto 0) <= (others => '0');
	yPre(4 downto 0) <= currReadRow(4 downto 0);
	currReadRow <= currRow + '1';
	x <= std_logic_vector((unsigned(xPre) + unsigned(xOffset)));
	y <= std_logic_vector(unsigned(yPre) + unsigned(yOffset)); 
	currAddress(17 downto 0) <= std_logic_vector((unsigned(y) + unsigned(currRowOffset_MULT)) * to_unsigned(768, 10) + (unsigned(x) * to_unsigned(3, 2)) + unsigned(currColor));
	currAddress(31 downto 18) <= (others => '0');
	
	offsetLatchClockOrd <= offsetLatchClock or latchForce; 
	with latchMode select offsetLatchClock <= 	'0' when x"1",
												frameEndClock when x"2",
												LOGIC_CLOCK when others;
	 
	currSprite_pos		<= Sprite_positions(to_integer(unsigned(currSprite)));
	currSprite_x		<= currSprite_pos(7 downto 0);
	currSprite_y		<= currSprite_pos(15 downto 8);
	currSprite_size		<= Sprite_sizes(to_integer(unsigned(currSprite)));
	currSprite_width	<= currSprite_size(7 downto 0);
	currSprite_height	<= currSprite_size(15 downto 8);
	currSprite_conf		<= Sprite_options(to_integer(unsigned(currSprite)));
	currSprite_pointer	<= Sprite_pointers(to_integer(unsigned(currSprite)));
	
	SpriteRead_yValid <= '1' when SpriteRead_yInSprite < currSprite_height else '0';
	SpriteRead_xValid <= '1' when SpriteRead_xInSprite < currSprite_width else '0';
	SpriteRead_spriteValid <= '1' when (SpriteRead_yValid = '1') and (SpriteRead_xValid = '1') and (currSprite_conf(0) = '1') else '0';
	 	
	SpriteRead_yInSprite <= std_logic_vector((unsigned(yPre) + (unsigned(currRowOffset) * to_unsigned(32, 6))) - unsigned(currSprite_y));
	SpriteRead_xInSprite <= std_logic_vector(unsigned(xPre) - unsigned(currSprite_x));
	Sprite_readAddr <= std_logic_vector(unsigned(SpriteRead_yInSprite) * unsigned(currSprite_width) + unsigned(SpriteRead_xInSprite) + unsigned(SpriteRead_addrStart));
	
	RED_IN 		<= VRAM_DATA_IN(9 downto 0);
	GREEN_IN 	<= VRAM_DATA_IN(19 downto 10);
	BLUE_IN		<= VRAM_DATA_IN(29 downto 20);
	
	RED_OUT_PRE 	<= std_logic_vector((unsigned(RED_IN) * 	(to_unsigned(511, 9) - unsigned(ALPHA_READ))) + (unsigned(RED_READ) * unsigned(ALPHA_READ)));
	GREEN_OUT_PRE 	<= std_logic_vector((unsigned(GREEN_IN) * 	(to_unsigned(511, 9) - unsigned(ALPHA_READ))) + (unsigned(GREEN_READ) * unsigned(ALPHA_READ)));
	BLUE_OUT_PRE	<= std_logic_vector((unsigned(BLUE_IN) * 	(to_unsigned(511, 9) - unsigned(ALPHA_READ))) + (unsigned(BLUE_READ) * unsigned(ALPHA_READ)));
	RED_OUT 		<= RED_OUT_PRE(18 downto 9);
	GREEN_OUT 		<= GREEN_OUT_PRE(18 downto 9);
	BLUE_OUT		<= BLUE_OUT_PRE(18 downto 9);
					
	process(offsetLatchClockOrd) begin
		if rising_edge(offsetLatchClockOrd) then
			xOffset <= xOffset_pre;
			yOffset <= yOffset_pre;
		end if;
	end process;

	process(LOGIC_CLOCK, currReadRow) begin
		if not (lastReadRow = currReadRow) then
				state <= x"00";
				BUS_REQ <= '0';
				lastReadRow <= currReadRow; 
				VRAM_WC <= '0';
				xPre <= x"00";
				currRowOffset <= "00";
				currColor <= x"0";
				writeState <= x"3";
				frameEndClock <= '0';
				currSprite <= x"00";
				Sprite_readClk <= '0';
				SpriteLUT_readClk <= '0';
				VRAM_WE <= '1';
				
			elsif rising_edge(LOGIC_CLOCK) then
		
			--request bus
			if state = x"00" then 
				reset <= '0';
				BUS_REQ <= '1';
				if BUS_GRANT = '1' then
					state <= x"01";
				end if;
			elsif state = x"01" then --read byte
				if BUS_DONE_IN = '1' then
					reset <= '1';
					currValue <= BUS_DATA_IN(7 downto 0);
					state <= x"02";
					VRAM_ADDR(9 downto 2) <= std_logic_vector(to_unsigned(127, 7) - unsigned(xPre));
					VRAM_ADDR(1 downto 0) <= currRowOffset;
					currRowOffset_lat <= currRowOffset;
					currColor_lat <= currColor;
					
					if currColor = x"2" then
						currColor <= x"0";
						if currRowOffset = "11" then
							currRowOffset <= "00";
							
							xPre <= xPre + '1';
							
							we <= '1';
						else
							currRowOffset <= currRowOffset + '1';
							state <= x"02";
							we <= '0';
						end if;
					else
						currColor <= currColor + '1';
						state <= x"02";
						we <= '0';
					end if;
				end if;
				
				VRAM_WC <= '0';
				
			elsif state = x"02" then
				state <= x"03";
				
			elsif state = x"03" then
				reset <= '0';
				data(to_integer(unsigned(currColor_lat)))(9 downto 0) <= GR_RE_DOUT;
				BUS_ADDR_INTERNAL <= currAddress;
				
				if (currColor_lat = x"2") then
					state <= x"04";
				else
					state <= x"01";
				end if;
				
			elsif state = x"04" then
				VRAM_WC <= '1';
				if xPre = x"80" then
					state <= x"10";
				else
					state <= x"01";
				end if;
				
			elsif state = x"10" then --all pixels loaded - wait (and do sprite stuff)
				VRAM_WC <= '0';
				BUS_REQ <= '0';
				if currReadRow = "11111" then
					frameEndClock <= '1';
				end if;
				state <= x"80";
				
			elsif state = x"80" then --do sprite stuff
				if (currSprite_conf(0) = '1') then
					if not (SpriteRead_yValid = '1') then
						if currRowOffset = "11" then
							currRowOffset <= "00";
							currSprite <= currSprite + '1';
						else
							currRowOffset <= currRowOffset + '1';
						end if;
						state <= x"7f";
					else
						xPre <= currSprite_x;
						SpriteRead_addrStart <= currSprite_pointer;
						state <= x"8f";
						currRowOffset_lat <= currRowOffset;
					end if;
				else
					if currSprite = x"27" then
						state <= x"ff";
					else
						currSprite <= currSprite + '1';
						state <= x"7f";
					end if;
				end if;
				
			elsif state = x"90" then 
				VRAM_WC <= '0';
				VRAM_WE <= '0';
				if SpriteRead_xValid = '1' then
					VRAM_ADDR(9 downto 2) <= std_logic_vector(to_unsigned(127, 7) - unsigned(xPre));
					VRAM_ADDR(1 downto 0) <= currRowOffset;
					Sprite_readClk <= '1';
					xPre <= xPre + '1';
					state <= x"91";
				else
					if currSprite = x"27" then
						state <= x"ff";
					else
						currSprite <= currSprite + '1';
						state <= x"7f";
					end if;
				end if;
			elsif state = x"91" then 
				Sprite_readClk <= '0';
				VRAM_WC <= '1';
				SpriteLUT_readClk <= '1';
				state <= x"92";
				
			elsif state = x"92" then 
				VRAM_WC <= '0';
				VRAM_WE <= '1';
				SpriteLUT_readClk <= '0';
				state <= x"93";
				
			elsif state = x"93" then
				state <= x"94";
				data(0) <= RED_OUT;
				data(1) <= GREEN_OUT;
				data(2) <= BLUE_OUT;
			
			elsif state = x"94" then 
				VRAM_WC <= '1';
				if xPre >= x"80" then
					if currSprite = x"27" then
						state <= x"ff";
					else
						currSprite <= currSprite + '1';
						state <= x"7f";
					end if;
				else
					state <= x"90";
				end if;
				
			elsif state = x"7f" then --done
				state <= x"80";
				
			elsif state = x"8f" then --done
				state <= x"90";
			end if;
			
		end if;
	end process;

--BUS logic

	OUT_ENABLE <= ADDRESS_VALID;
	ADDRESS_VALID <= '1' when ((BUS_ADDR_IN >= x"00040000") and (BUS_ADDR_IN < x"00040403")) or ((BUS_ADDR_IN >= x"00050000") and (BUS_ADDR_IN < x"00058900")) else '0';
	BUS_VALID <= ADDRESS_VALID;

	BUS_DATA_OUT <= BUS_DATA_INTERNAL when (OUT_ENABLE = '1') and (BUS_DIRECTION_IN = '1') else x"0000"; 
	BUS_ADDR_OUT <= BUS_ADDR_INTERNAL when BUS_GRANT = '1' else x"00000000"; 
	
	xOffset_16(7 downto 0) <= xOffset; xOffset_16(15 downto 8) <= (others => '0'); 
	yOffset_16(7 downto 0) <= yOffset; yOffset_16(15 downto 8) <= (others => '0'); 
	latchMode16(3 downto 0) <= latchMode; latchMode16(15 downto 4) <= (others => '0'); 
	
	with BUS_ADDR_IN select BUS_DATA_INTERNAL <= 	xOffset_16 when x"00040400",
													yOffset_16 when x"00040401",
													latchMode16 when x"00040402",
													otherData when others;
													
	
	otherData <= otherData2 when BUS_ADDR_IN >= x"50000" else GR_WR_DOUT_16;
	otherData2 <= lut_read16 when BUS_ADDR_IN >= x"58100" else Sprite_readData2;
	
	lut_read16(8 downto 0) <= lut_read; lut_read16(15 downto 9) <= (others => '0');
	with BUS_ADDR_IN(1 downto 0) select lut_read <=			RED_WRITE 	when "00",
																GREEN_WRITE when "01",
																BLUE_WRITE 	when "10",
																ALPHA_WRITE	when "11";
																
	with BUS_ADDR_IN(1 downto 0) select Sprite_readData2 <=	Sprite_positions(to_integer(unsigned(BUS_ADDR_IN(7 downto 2)))) 	when "00",
																Sprite_sizes(to_integer(unsigned(BUS_ADDR_IN(7 downto 2)))) 		when "01",
																Sprite_options(to_integer(unsigned(BUS_ADDR_IN(7 downto 2)))) 	when "10",
																Sprite_pointers(to_integer(unsigned(BUS_ADDR_IN(7 downto 2)))) 	when "11";
															
											

	BUS_RESET <= reset when (BUS_GRANT = '1') else '0'; 
	BUS_DIRECTION_OUT <= '1' when (BUS_GRANT = '1') else '0'; 

	BUS_DONE_OUT <= transferDone;
	
	GR_WR_DIN <= BUS_DATA_IN(9 downto 0);
	GR_WR_ADDR <= BUS_ADDR_IN(7 downto 0) when ((BUS_ADDR_IN >= x"40000") and (BUS_ADDR_IN < x"40400")) else x"00";

	process(LOGIC_CLOCK) begin
		if (ADDRESS_VALID = '0') then
			BUS_transferState <= x"0";
			transferDone <= '0';
			GR_WR_CLK <= '0';
			latchForce <= '0';
			RED_WE <= '0';
			GREEN_WE <= '0';
			BLUE_WE <= '0';
			ALPHA_WE <= '0';
			
		elsif rising_edge(LOGIC_CLOCK) then
			
			if ((BUS_ADDR_IN >= x"40000") and (BUS_ADDR_IN < x"40400")) then
				if BUS_transferState = x"0" then
					BUS_transferState <= x"1";
					
				elsif BUS_transferState = x"1" then
					GR_WR_CLK <= '1';
					BUS_transferState <= x"2";
					
				elsif BUS_transferState = x"2" then
					GR_WR_CLK <= '0';
					GR_WR_DOUT_16(9 downto 0) <= GR_WR_DOUT;
					GR_WR_DOUT_16(15 downto 10) <= (others => '0'); 
					BUS_transferState <= x"f";
					
				elsif BUS_transferState = x"f" then
					GR_WR_CLK <= '0';
					transferDone <= '1'; 
				end if;
				
			elsif BUS_ADDR_IN = x"40400" then
				if (BUS_DIRECTION_IN = '0') then
					xOffset_pre <= BUS_DATA_IN(7 downto 0); 
				end if;
				transferDone <= '1'; 
				
			elsif BUS_ADDR_IN = x"40401" then
				if (BUS_DIRECTION_IN = '0') then
					yOffset_pre <= BUS_DATA_IN(7 downto 0); 
				end if;
				transferDone <= '1'; 
				
			elsif BUS_ADDR_IN = x"40402" then
				if (BUS_DIRECTION_IN = '0') then
					latchMode(3 downto 0) <= BUS_DATA_IN(3 downto 0); 
					latchForce <= BUS_DATA_IN(4); 
				end if;
				transferDone <= '1'; 
			elsif ((BUS_ADDR_IN >= x"50000") and (BUS_ADDR_IN < x"58000")) then
				if BUS_transferState = x"0" then
					Sprite_writeAddr(14 downto 0) <= BUS_ADDR_IN(14 downto 0);
					Sprite_writeData(8 downto 0) <= BUS_DATA_IN(8 downto 0);
					BUS_transferState <= x"1";
					
				elsif BUS_transferState = x"1" then
					Sprite_writeClk <= '1';
					BUS_transferState <= x"2";
					
				elsif BUS_transferState = x"2" then
					Sprite_writeClk <= '0';
					transferDone <= '1'; 
					
				end if;
			
			elsif ((BUS_ADDR_IN >= x"58000") and (BUS_ADDR_IN < x"58100")) then
				if BUS_transferState = x"0" then
					BUS_transferState <= x"f";
					
				elsif BUS_transferState = x"f" then
					if (BUS_DIRECTION_IN = '0') then
						if BUS_ADDR_IN(1 downto 0) = "00" then	
							Sprite_positions(to_integer(unsigned(BUS_ADDR_IN(7 downto 2)))) <= BUS_DATA_IN;
						elsif BUS_ADDR_IN(1 downto 0) = "01" then	
							Sprite_sizes(to_integer(unsigned(BUS_ADDR_IN(7 downto 2)))) <= BUS_DATA_IN;
						elsif BUS_ADDR_IN(1 downto 0) = "10" then	
							Sprite_options(to_integer(unsigned(BUS_ADDR_IN(7 downto 2)))) <= BUS_DATA_IN;
						elsif BUS_ADDR_IN(1 downto 0) = "11" then	
							Sprite_pointers(to_integer(unsigned(BUS_ADDR_IN(7 downto 2)))) <= BUS_DATA_IN;
						end if;
					end if;
					transferDone <= '1'; 
				end if;
			elsif ((BUS_ADDR_IN >= x"58100") and (BUS_ADDR_IN < x"58900")) then
				if BUS_transferState = x"0" then
					if (BUS_DIRECTION_IN = '0') then
						if BUS_ADDR_IN(1 downto 0) = "00" then	
							RED_WE <= '1';
						elsif BUS_ADDR_IN(1 downto 0) = "01" then	
							GREEN_WE <= '1';
						elsif BUS_ADDR_IN(1 downto 0) = "10" then	
							BLUE_WE <= '1';
						elsif BUS_ADDR_IN(1 downto 0) = "11" then	
							ALPHA_WE <= '1';
						end if;
					end if;
					BUS_transferState <= x"1";
					
				elsif BUS_transferState = x"1" then
					SpriteLut_writeClk <= '1';
					BUS_transferState <= x"2";
					
				elsif BUS_transferState = x"2" then
					SpriteLut_writeClk <= '0';
					BUS_transferState <= x"f";
					
				elsif BUS_transferState = x"f" then
					transferDone <= '1'; 
				end if;
			end if; 
		end if;
	end process;  
	
	GR_RE_ADDR <= currValue; 
	GR_RE_CLK  <= not LOGIC_CLOCK;
	GR_WE <= not BUS_DIRECTION_IN;
	
	GRam: GammaRam 
		port map(
			DataInA		=> GR_WR_DIN,
			DataInB 	=> (others => '0'),
			AddressA	=> GR_WR_ADDR,
			AddressB	=> GR_RE_ADDR, 
			ClockA		=> GR_WR_CLK,
			ClockB		=> GR_RE_CLK,
			ClockEnA	=> '1',
			ClockEnB	=> '1',
			WrA			=> GR_WE,
			WrB			=> '0',
			ResetA		=> '0',
			ResetB		=> '0',
			QA			=> GR_WR_DOUT,
			QB			=> GR_RE_DOUT
		);
		
	SRam: SpriteRam 
		port map(
			WrAddress => Sprite_writeAddr(13 downto 0),
			RdAddress => Sprite_readAddr(13 downto 0),
			Data => Sprite_writeData,
			WE => '1',
			RdClock => Sprite_readClk,
			RdClockEn => '1',
			Reset => '0',
			WrClock => Sprite_writeClk,
			WrClockEn => '1',
			Q => Sprite_readData
		);
		
	SpriteLut_writeData <= BUS_DATA_IN(8 downto 0);
	SpriteLut_writeAddr <= BUS_ADDR_IN(10 downto 2);
			
	RedLut:		LUT_RAM
		port map(
			DataInA		=> SpriteLut_writeData,
			DataInB 	=> (others => '0'),
			AddressA	=> SpriteLut_writeAddr,
			AddressB	=> Sprite_readData,
			ClockA		=> SpriteLut_writeClk,
			ClockB		=> SpriteLut_readClk,
			ClockEnA	=> '1',
			ClockEnB	=> '1',
			WrA			=> RED_WE,
			WrB			=> '0',
			ResetA		=> '0',
			ResetB		=> '0',
			QA			=> RED_WRITE,
			QB			=> RED_READ
		);
		
	GreenLut:	LUT_RAM
		port map(
			DataInA		=> SpriteLut_writeData,
			DataInB 	=> (others => '0'),
			AddressA	=> SpriteLut_writeAddr,
			AddressB	=> Sprite_readData,
			ClockA		=> SpriteLut_writeClk,
			ClockB		=> SpriteLut_readClk,
			ClockEnA	=> '1',
			ClockEnB	=> '1',
			WrA			=> GREEN_WE,
			WrB			=> '0',
			ResetA		=> '0',
			ResetB		=> '0',
			QA			=> GREEN_WRITE,
			QB			=> GREEN_READ
		);
		
	BlueLut:	LUT_RAM
		port map(
			DataInA		=> SpriteLut_writeData,
			DataInB 	=> (others => '0'),
			AddressA	=> SpriteLut_writeAddr,
			AddressB	=> Sprite_readData,
			ClockA		=> SpriteLut_writeClk,
			ClockB		=> SpriteLut_readClk,
			ClockEnA	=> '1',
			ClockEnB	=> '1',
			WrA			=> BLUE_WE,
			WrB			=> '0',
			ResetA		=> '0',
			ResetB		=> '0',
			QA			=> BLUE_WRITE,
			QB			=> BLUE_READ
		);
		
	AlphaLut:	LUT_RAM
		port map(
			DataInA		=> SpriteLut_writeData,
			DataInB 	=> (others => '0'),
			AddressA	=> SpriteLut_writeAddr,
			AddressB	=> Sprite_readData,
			ClockA		=> SpriteLut_writeClk,
			ClockB		=> SpriteLut_readClk,
			ClockEnA	=> '1',
			ClockEnB	=> '1',
			WrA			=> ALPHA_WE,
			WrB			=> '0',
			ResetA		=> '0',
			ResetB		=> '0',
			QA			=> ALPHA_WRITE,
			QB			=> ALPHA_READ
		);


end Behavioral;