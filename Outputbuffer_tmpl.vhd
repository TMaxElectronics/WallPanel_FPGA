-- VHDL module instantiation generated by SCUBA Diamond (64-bit) 3.11.0.396.4
-- Module  Version: 6.5
-- Fri Jan 08 17:30:18 2021

-- parameterized module component declaration
component Outputbuffer
    port (WrAddress: in  std_logic_vector(7 downto 0); 
        RdAddress: in  std_logic_vector(7 downto 0); 
        Data: in  std_logic_vector(119 downto 0); WE: in  std_logic; 
        RdClock: in  std_logic; RdClockEn: in  std_logic; 
        Reset: in  std_logic; WrClock: in  std_logic; 
        WrClockEn: in  std_logic; Q: out  std_logic_vector(119 downto 0));
end component;

-- parameterized module component instance
__ : Outputbuffer
    port map (WrAddress(7 downto 0)=>__, RdAddress(7 downto 0)=>__, Data(119 downto 0)=>__, 
        WE=>__, RdClock=>__, RdClockEn=>__, Reset=>__, WrClock=>__, 
        WrClockEn=>__, Q(119 downto 0)=>__);