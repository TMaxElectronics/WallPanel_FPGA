-- VHDL testbench template generated by SCUBA Diamond (64-bit) 3.11.0.396.4
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

use IEEE.math_real.all;

use IEEE.numeric_std.all;

entity tb is
end entity tb;


architecture test of tb is 

    component Outputbuffer
        port (WrAddress : in std_logic_vector(7 downto 0); 
        RdAddress : in std_logic_vector(7 downto 0); 
        Data : in std_logic_vector(119 downto 0); WE: in std_logic; 
        RdClock: in std_logic; RdClockEn: in std_logic; 
        Reset: in std_logic; WrClock: in std_logic; 
        WrClockEn: in std_logic; Q : out std_logic_vector(119 downto 0)
    );
    end component;

    signal WrAddress : std_logic_vector(7 downto 0) := (others => '0');
    signal RdAddress : std_logic_vector(7 downto 0) := (others => '0');
    signal Data : std_logic_vector(119 downto 0) := (others => '0');
    signal WE: std_logic := '0';
    signal RdClock: std_logic := '0';
    signal RdClockEn: std_logic := '0';
    signal Reset: std_logic := '0';
    signal WrClock: std_logic := '0';
    signal WrClockEn: std_logic := '0';
    signal Q : std_logic_vector(119 downto 0);
begin
    u1 : Outputbuffer
        port map (WrAddress => WrAddress, RdAddress => RdAddress, Data => Data, 
            WE => WE, RdClock => RdClock, RdClockEn => RdClockEn, Reset => Reset, 
            WrClock => WrClock, WrClockEn => WrClockEn, Q => Q
        );

    process

    begin
      WrAddress <= (others => '0') ;
      wait for 100 ns;
      wait until Reset = '0';
      for i in 0 to 518 loop
        wait until WrClock'event and WrClock = '1';
        WrAddress <= WrAddress + '1' after 1 ns;
      end loop;
      wait;
    end process;

    process

    begin
      RdAddress <= (others => '0') ;
      wait for 100 ns;
      wait until Reset = '0';
      for i in 0 to 518 loop
        wait until RdClock'event and RdClock = '1';
        RdAddress <= RdAddress + '1' after 1 ns;
      end loop;
      wait;
    end process;

    process

    begin
      Data <= (others => '0') ;
      wait for 100 ns;
      wait until Reset = '0';
      for i in 0 to 259 loop
        wait until WrClock'event and WrClock = '1';
        Data <= Data + '1' after 1 ns;
      end loop;
      wait;
    end process;

    process

    begin
      WE <= '0' ;
      wait until Reset = '0';
      for i in 0 to 259 loop
        wait until WrClock'event and WrClock = '1';
        WE <= '1' after 1 ns;
      end loop;
      WE <= '0' ;
      wait;
    end process;

    RdClock <= not RdClock after 5.00 ns;

    process

    begin
      RdClockEn <= '0' ;
      wait for 100 ns;
      wait until Reset = '0';
      RdClockEn <= '1' ;
      wait;
    end process;

    process

    begin
      Reset <= '1' ;
      wait for 100 ns;
      Reset <= '0' ;
      wait;
    end process;

    WrClock <= not WrClock after 5.00 ns;

    process

    begin
      WrClockEn <= '0' ;
      wait for 100 ns;
      wait until Reset = '0';
      WrClockEn <= '1' ;
      wait;
    end process;

end architecture test;
