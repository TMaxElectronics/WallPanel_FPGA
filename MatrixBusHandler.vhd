library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all; 

entity MatrixBusHandler is
	Port ( 
		LOGIC_CLOCK					: in 	STD_LOGIC;
		
		VRAM_ADDR					: out	STD_LOGIC_VECTOR(7 downto 0);
		VRAM_DATA					: out	STD_LOGIC_VECTOR(119 downto 0);
		VRAM_WC						: out	STD_LOGIC;
		
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
	type RowData is array (0 to 3) of PixelData;
	signal data			:	RowData;
	
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
	
	signal writeState			:	STD_LOGIC_VECTOR(3 downto 0);
	
begin

	VRAM_DATA(9 downto 0) <= 		data(2)(0);
	VRAM_DATA(19 downto 10) <= 	data(2)(1);
	VRAM_DATA(29 downto 20) <= 	data(2)(2);

	VRAM_DATA(39 downto 30) <= 	data(3)(0);
	VRAM_DATA(49 downto 40) <= 	data(3)(1);
	VRAM_DATA(59 downto 50) <= 	data(3)(2);

	VRAM_DATA(69 downto 60) <= 	data(0)(0);
	VRAM_DATA(79 downto 70) <= 	data(0)(1);
	VRAM_DATA(89 downto 80) <= 	data(0)(2);

	VRAM_DATA(99 downto 90) <= 	data(1)(0);
	VRAM_DATA(109 downto 100) <= 	data(1)(1);
	VRAM_DATA(119 downto 110) <= 	data(1)(2); 

	yPre(4 downto 0) <= currReadRow(4 downto 0);
	currReadRow <= currRow + '1';
	x <= std_logic_vector((unsigned(xPre) + unsigned(xOffset)));
	y <= std_logic_vector(unsigned(yPre) + unsigned(yOffset)); 
	currAddress(17 downto 0) <= std_logic_vector((unsigned(y) + (unsigned(currRowOffset) * to_unsigned(32, 6))) * to_unsigned(768, 10) + (unsigned(x) * to_unsigned(3, 2)) + unsigned(currColor));
	currAddress(31 downto 18) <= (others => '0');
	
	offsetLatchClockOrd <= offsetLatchClock or latchForce; 
	with latchMode select offsetLatchClock <= 	'0' when x"1",
												frameEndClock when x"2",
												LOGIC_CLOCK when others;
	 
	currSprite_pos		<= Sprite_positions(to_integer(unsigned(currSprite)));
	currSprite_x		<= currSprite_pos(7 downto 0);
	currSprite_y		<= currSprite_pos(15 downto 8);
	currSprite_size		<= Sprite_sizes(to_integer(unsigned(currSprite)));
	currSprite_width	<= currSprite_pos(7 downto 0);
	currSprite_height	<= currSprite_pos(15 downto 8);
	currSprite_conf		<= Sprite_options(to_integer(unsigned(currSprite)));
	
	SpriteRead_yValid <= '1' when (unsigned(currSprite_y) <= (unsigned(yPre) + (unsigned(currRowOffset) * to_unsigned(32, 6)))) and ((unsigned(currSprite_y) + unsigned(currSprite_height)) >= (unsigned(y) + (unsigned(currRowOffset) * to_unsigned(32, 6)))) else '0';
	SpriteRead_xValid <= '1' when (unsigned(currSprite_x) <= unsigned(xPre)) and ((unsigned(currSprite_x) + unsigned(currSprite_width)) >= unsigned(xPre)) else '0';
	SpriteRead_spriteValid <= '1' when (SpriteRead_yValid = '1') and (SpriteRead_xValid = '1') and (currSprite_conf(0) = '1') else '0';
	 	
	SpriteRead_yInSprite <= std_logic_vector(unsigned(currSprite_y) - unsigned(yPre) - (unsigned(currRowOffset) * to_unsigned(32, 6)));
	SpriteRead_xInSprite <= std_logic_vector(unsigned(currSprite_x) - (to_unsigned(127, 7) - unsigned(xPre)));
	Sprite_readAddr <= std_logic_vector(unsigned(SpriteRead_yInSprite) * unsigned(currSprite_width) + unsigned(SpriteRead_xInSprite) + unsigned(SpriteRead_addrStart));
					
	process(offsetLatchClockOrd) begin
		if rising_edge(offsetLatchClockOrd) then
			xOffset <= xOffset_pre;
			yOffset <= yOffset_pre;
		end if;
	end process;

	process(LOGIC_CLOCK, currReadRow) begin
		if not (lastReadRow = currReadRow) then
			state <= x"00";
			lastReadRow <= currReadRow;
			VRAM_WC <= '0';
			xPre <= x"00";
			currRowOffset <= "00";
			currColor <= x"0";
			writeState <= x"3";
			frameEndClock <= '0';
			
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
					VRAM_ADDR <= std_logic_vector(to_unsigned(127, 7) - unsigned(xPre));
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
				--GR_RE_CLK <= '1';
				state <= x"03";
				
			elsif state = x"03" then
				reset <= '0';
				data(to_integer(unsigned(currRowOffset_lat)))(to_integer(unsigned(currColor_lat)))(9 downto 0) <= GR_RE_DOUT;
				--GR_RE_CLK <= '0';
				
				if (currRowOffset_lat = "11") and (currColor_lat = x"2") then
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
						state <= x"8f";
						currRowOffset_lat <= currRowOffset;
					end if;
				else
					if currSprite = x"27" then
						currSprite <= currSprite + '1';
						state <= x"7f";
					else
						currSprite <= x"00";
						state <= x"ff";
					end if;
				end if;
				
			elsif state = x"90" then --all pixels loaded - wait (and do sprite stuff)
				VRAM_WC <= '0';
				if SpriteRead_xValid = '1' then
					VRAM_ADDR <= std_logic_vector(to_unsigned(127, 7) - unsigned(xPre));
					state <= x"91";
				else
					if currSprite = x"27" then
						currSprite <= currSprite + '1';
						state <= x"7f";
					else
						currSprite <= x"00";
						state <= x"ff";
					end if;
				end if;
			elsif state = x"91" then --all pixels loaded - wait (and do sprite stuff)
				Sprite_readClk <= '1';
				xPre <= xPre + '1';
				state <= x"92";
				
			elsif state = x"92" then --all pixels loaded - wait (and do sprite stuff)
				Sprite_readClk <= '0';
				if not (sprite_readData = "000000000") then
					data(to_integer(unsigned(currRowOffset_lat)))(0)(9 downto 0) <= sprite_readData & '0';
					data(to_integer(unsigned(currRowOffset_lat)))(1)(9 downto 0) <= sprite_readData & '0';
					data(to_integer(unsigned(currRowOffset_lat)))(2)(9 downto 0) <= sprite_readData & '0';
					state <= x"93";
				end if;
				state <= x"90";
				
			elsif state = x"93" then --all pixels loaded - wait (and do sprite stuff)
				VRAM_WC <= '1';
				state <= x"90";
			
			elsif state = x"ff" then --done
				state <= x"ff";

			else 
				state <= state + '1';
			end if;
			
		end if;
		
		if falling_edge(LOGIC_CLOCK) then
			if state = x"03" then
				BUS_ADDR_INTERNAL <= currAddress;
			end if;
		end if;
	end process;

--BUS logic

	OUT_ENABLE <= ADDRESS_VALID;
	ADDRESS_VALID <= '1' when ((BUS_ADDR_IN >= x"00040000") and (BUS_ADDR_IN < x"00040403")) or ((BUS_ADDR_IN >= x"00050000") and (BUS_ADDR_IN < x"00058100")) else '0';
	BUS_VALID <= ADDRESS_VALID;

	BUS_DATA_OUT <= BUS_DATA_INTERNAL when (OUT_ENABLE = '1') and (BUS_DIRECTION_IN = '1') else x"0000"; 
	BUS_ADDR_OUT <= BUS_ADDR_INTERNAL when BUS_GRANT = '1' else x"00000000"; 
	GR_WR_DOUT_16(9 downto 0) <= GR_WR_DOUT;
	GR_WR_DOUT_16(15 downto 10) <= (others => '0'); 
	
	xOffset_16(7 downto 0) <= xOffset; xOffset_16(15 downto 8) <= (others => '0'); 
	yOffset_16(7 downto 0) <= yOffset; yOffset_16(15 downto 8) <= (others => '0'); 
	latchMode16(3 downto 0) <= latchMode; latchMode16(15 downto 4) <= (others => '0'); 
	
	with BUS_ADDR_IN select BUS_DATA_INTERNAL <= 	xOffset_16 when x"00040400",
													yOffset_16 when x"00040401",
													latchMode16 when x"00040402",
													otherData when others;
													
	
	otherData <= Sprite_readData2 when BUS_ADDR_IN > x"50000" else GR_WR_DOUT_16;
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
			
		elsif rising_edge(LOGIC_CLOCK) then
			
			if ((BUS_ADDR_IN >= x"40000") and (BUS_ADDR_IN < x"40400")) then
				if BUS_transferState = x"0" then
					BUS_transferState <= x"1";
					
				elsif BUS_transferState = x"1" then
					GR_WR_CLK <= '1';
					BUS_transferState <= x"f";
					
				elsif BUS_transferState = x"f" then
					GR_WR_CLK <= '0';
					BUS_transferState <= x"f";
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
					BUS_transferState <= x"f";
					
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

end Behavioral;