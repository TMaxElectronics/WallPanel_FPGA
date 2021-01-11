[ActiveSupport MAP]
Device = LCMXO3LF-9400C;
Package = CABGA256;
Performance = 6;
LUTS_avail = 9400;
LUTS_used = 3714;
FF_avail = 9607;
FF_used = 1498;
INPUT_LVCMOS33 = 22;
OUTPUT_LVCMOS33 = 50;
BIDI_LVCMOS33 = 32;
IO_avail = 207;
IO_used = 104;
EBR_avail = 48;
EBR_used = 28;
; Begin EBR Section
Instance_Name = MD/VRam/Outputbuffer_0_6_0;
Type = PDPW8KC;
Width = 12;
Depth_R = 256;
Depth_W = 256;
REGMODE = OUTREG;
RESETMODE = SYNC;
ASYNC_RESET_RELEASE = SYNC;
GSR = DISABLED;
MEM_INIT_FILE = INIT_ALL_1s;
MEM_LPC_FILE = Outputbuffer.lpc;
Instance_Name = MD/VRam/Outputbuffer_0_1_5;
Type = PDPW8KC;
Width = 18;
Depth_R = 256;
Depth_W = 256;
REGMODE = OUTREG;
RESETMODE = SYNC;
ASYNC_RESET_RELEASE = SYNC;
GSR = DISABLED;
MEM_INIT_FILE = INIT_ALL_1s;
MEM_LPC_FILE = Outputbuffer.lpc;
Instance_Name = MD/VRam/Outputbuffer_0_0_6;
Type = PDPW8KC;
Width = 18;
Depth_R = 256;
Depth_W = 256;
REGMODE = OUTREG;
RESETMODE = SYNC;
ASYNC_RESET_RELEASE = SYNC;
GSR = DISABLED;
MEM_INIT_FILE = INIT_ALL_1s;
MEM_LPC_FILE = Outputbuffer.lpc;
Instance_Name = MD/VRam/Outputbuffer_0_2_4;
Type = PDPW8KC;
Width = 18;
Depth_R = 256;
Depth_W = 256;
REGMODE = OUTREG;
RESETMODE = SYNC;
ASYNC_RESET_RELEASE = SYNC;
GSR = DISABLED;
MEM_INIT_FILE = INIT_ALL_1s;
MEM_LPC_FILE = Outputbuffer.lpc;
Instance_Name = MD/VRam/Outputbuffer_0_3_3;
Type = PDPW8KC;
Width = 18;
Depth_R = 256;
Depth_W = 256;
REGMODE = OUTREG;
RESETMODE = SYNC;
ASYNC_RESET_RELEASE = SYNC;
GSR = DISABLED;
MEM_INIT_FILE = INIT_ALL_1s;
MEM_LPC_FILE = Outputbuffer.lpc;
Instance_Name = MD/VRam/Outputbuffer_0_4_2;
Type = PDPW8KC;
Width = 18;
Depth_R = 256;
Depth_W = 256;
REGMODE = OUTREG;
RESETMODE = SYNC;
ASYNC_RESET_RELEASE = SYNC;
GSR = DISABLED;
MEM_INIT_FILE = INIT_ALL_1s;
MEM_LPC_FILE = Outputbuffer.lpc;
Instance_Name = MD/VRam/Outputbuffer_0_5_1;
Type = PDPW8KC;
Width = 18;
Depth_R = 256;
Depth_W = 256;
REGMODE = OUTREG;
RESETMODE = SYNC;
ASYNC_RESET_RELEASE = SYNC;
GSR = DISABLED;
MEM_INIT_FILE = INIT_ALL_1s;
MEM_LPC_FILE = Outputbuffer.lpc;
Instance_Name = MDM/Sprite_options0;
Type = PDPW8KC;
Width = 1;
Depth_R = 64;
Depth_W = 64;
REGMODE = NOREG;
RESETMODE = SYNC;
ASYNC_RESET_RELEASE = SYNC;
GSR = DISABLED;
Instance_Name = MDM/Sprite_positions0;
Type = PDPW8KC;
Width = 8;
Depth_R = 64;
Depth_W = 64;
REGMODE = NOREG;
RESETMODE = SYNC;
ASYNC_RESET_RELEASE = SYNC;
GSR = DISABLED;
Instance_Name = MDM/GRam/GammaRam_0_1_0;
Type = DP8KC;
Width_A = 1;
Width_B = 1;
Depth_A = 256;
Depth_B = 256;
REGMODE_A = NOREG;
REGMODE_B = NOREG;
RESETMODE = ASYNC;
ASYNC_RESET_RELEASE = SYNC;
WRITEMODE_A = NORMAL;
WRITEMODE_B = NORMAL;
GSR = DISABLED;
MEM_INIT_FILE = gammadefault.mem;
MEM_LPC_FILE = GammaRam.lpc;
Instance_Name = MDM/GRam/GammaRam_0_0_1;
Type = DP8KC;
Width_A = 9;
Width_B = 9;
Depth_A = 256;
Depth_B = 256;
REGMODE_A = NOREG;
REGMODE_B = NOREG;
RESETMODE = ASYNC;
ASYNC_RESET_RELEASE = SYNC;
WRITEMODE_A = NORMAL;
WRITEMODE_B = NORMAL;
GSR = DISABLED;
MEM_INIT_FILE = gammadefault.mem;
MEM_LPC_FILE = GammaRam.lpc;
Instance_Name = master_reveal_coretop_instance/core0/tm_u/pmi_ram_dpXO3LFbinarynonespeedasyncdisablereg146101024146101024/pmi_ram_dpXbnonesadr146101024146101024123cc668_0_16_0;
Type = DP8KC;
Width_B = 2;
Depth_A = 1024;
Depth_B = 1024;
REGMODE_A = OUTREG;
REGMODE_B = OUTREG;
RESETMODE = ASYNC;
ASYNC_RESET_RELEASE = SYNC;
WRITEMODE_A = NORMAL;
WRITEMODE_B = NORMAL;
GSR = DISABLED;
MEM_LPC_FILE = pmi_ram_dpXbnonesadr146101024146101024123cc668__PMIP__1024__146__146B;
Instance_Name = master_reveal_coretop_instance/core0/tm_u/pmi_ram_dpXO3LFbinarynonespeedasyncdisablereg146101024146101024/pmi_ram_dpXbnonesadr146101024146101024123cc668_0_0_16;
Type = DP8KC;
Width_B = 9;
Depth_A = 1024;
Depth_B = 1024;
REGMODE_A = OUTREG;
REGMODE_B = OUTREG;
RESETMODE = ASYNC;
ASYNC_RESET_RELEASE = SYNC;
WRITEMODE_A = NORMAL;
WRITEMODE_B = NORMAL;
GSR = DISABLED;
MEM_LPC_FILE = pmi_ram_dpXbnonesadr146101024146101024123cc668__PMIP__1024__146__146B;
Instance_Name = master_reveal_coretop_instance/core0/tm_u/pmi_ram_dpXO3LFbinarynonespeedasyncdisablereg146101024146101024/pmi_ram_dpXbnonesadr146101024146101024123cc668_0_1_15;
Type = DP8KC;
Width_B = 9;
Depth_A = 1024;
Depth_B = 1024;
REGMODE_A = OUTREG;
REGMODE_B = OUTREG;
RESETMODE = ASYNC;
ASYNC_RESET_RELEASE = SYNC;
WRITEMODE_A = NORMAL;
WRITEMODE_B = NORMAL;
GSR = DISABLED;
MEM_LPC_FILE = pmi_ram_dpXbnonesadr146101024146101024123cc668__PMIP__1024__146__146B;
Instance_Name = master_reveal_coretop_instance/core0/tm_u/pmi_ram_dpXO3LFbinarynonespeedasyncdisablereg146101024146101024/pmi_ram_dpXbnonesadr146101024146101024123cc668_0_2_14;
Type = DP8KC;
Width_B = 9;
Depth_A = 1024;
Depth_B = 1024;
REGMODE_A = OUTREG;
REGMODE_B = OUTREG;
RESETMODE = ASYNC;
ASYNC_RESET_RELEASE = SYNC;
WRITEMODE_A = NORMAL;
WRITEMODE_B = NORMAL;
GSR = DISABLED;
MEM_LPC_FILE = pmi_ram_dpXbnonesadr146101024146101024123cc668__PMIP__1024__146__146B;
Instance_Name = master_reveal_coretop_instance/core0/tm_u/pmi_ram_dpXO3LFbinarynonespeedasyncdisablereg146101024146101024/pmi_ram_dpXbnonesadr146101024146101024123cc668_0_3_13;
Type = DP8KC;
Width_B = 9;
Depth_A = 1024;
Depth_B = 1024;
REGMODE_A = OUTREG;
REGMODE_B = OUTREG;
RESETMODE = ASYNC;
ASYNC_RESET_RELEASE = SYNC;
WRITEMODE_A = NORMAL;
WRITEMODE_B = NORMAL;
GSR = DISABLED;
MEM_LPC_FILE = pmi_ram_dpXbnonesadr146101024146101024123cc668__PMIP__1024__146__146B;
Instance_Name = master_reveal_coretop_instance/core0/tm_u/pmi_ram_dpXO3LFbinarynonespeedasyncdisablereg146101024146101024/pmi_ram_dpXbnonesadr146101024146101024123cc668_0_4_12;
Type = DP8KC;
Width_B = 9;
Depth_A = 1024;
Depth_B = 1024;
REGMODE_A = OUTREG;
REGMODE_B = OUTREG;
RESETMODE = ASYNC;
ASYNC_RESET_RELEASE = SYNC;
WRITEMODE_A = NORMAL;
WRITEMODE_B = NORMAL;
GSR = DISABLED;
MEM_LPC_FILE = pmi_ram_dpXbnonesadr146101024146101024123cc668__PMIP__1024__146__146B;
Instance_Name = master_reveal_coretop_instance/core0/tm_u/pmi_ram_dpXO3LFbinarynonespeedasyncdisablereg146101024146101024/pmi_ram_dpXbnonesadr146101024146101024123cc668_0_5_11;
Type = DP8KC;
Width_B = 9;
Depth_A = 1024;
Depth_B = 1024;
REGMODE_A = OUTREG;
REGMODE_B = OUTREG;
RESETMODE = ASYNC;
ASYNC_RESET_RELEASE = SYNC;
WRITEMODE_A = NORMAL;
WRITEMODE_B = NORMAL;
GSR = DISABLED;
MEM_LPC_FILE = pmi_ram_dpXbnonesadr146101024146101024123cc668__PMIP__1024__146__146B;
Instance_Name = master_reveal_coretop_instance/core0/tm_u/pmi_ram_dpXO3LFbinarynonespeedasyncdisablereg146101024146101024/pmi_ram_dpXbnonesadr146101024146101024123cc668_0_6_10;
Type = DP8KC;
Width_B = 9;
Depth_A = 1024;
Depth_B = 1024;
REGMODE_A = OUTREG;
REGMODE_B = OUTREG;
RESETMODE = ASYNC;
ASYNC_RESET_RELEASE = SYNC;
WRITEMODE_A = NORMAL;
WRITEMODE_B = NORMAL;
GSR = DISABLED;
MEM_LPC_FILE = pmi_ram_dpXbnonesadr146101024146101024123cc668__PMIP__1024__146__146B;
Instance_Name = master_reveal_coretop_instance/core0/tm_u/pmi_ram_dpXO3LFbinarynonespeedasyncdisablereg146101024146101024/pmi_ram_dpXbnonesadr146101024146101024123cc668_0_7_9;
Type = DP8KC;
Width_B = 9;
Depth_A = 1024;
Depth_B = 1024;
REGMODE_A = OUTREG;
REGMODE_B = OUTREG;
RESETMODE = ASYNC;
ASYNC_RESET_RELEASE = SYNC;
WRITEMODE_A = NORMAL;
WRITEMODE_B = NORMAL;
GSR = DISABLED;
MEM_LPC_FILE = pmi_ram_dpXbnonesadr146101024146101024123cc668__PMIP__1024__146__146B;
Instance_Name = master_reveal_coretop_instance/core0/tm_u/pmi_ram_dpXO3LFbinarynonespeedasyncdisablereg146101024146101024/pmi_ram_dpXbnonesadr146101024146101024123cc668_0_8_8;
Type = DP8KC;
Width_B = 9;
Depth_A = 1024;
Depth_B = 1024;
REGMODE_A = OUTREG;
REGMODE_B = OUTREG;
RESETMODE = ASYNC;
ASYNC_RESET_RELEASE = SYNC;
WRITEMODE_A = NORMAL;
WRITEMODE_B = NORMAL;
GSR = DISABLED;
MEM_LPC_FILE = pmi_ram_dpXbnonesadr146101024146101024123cc668__PMIP__1024__146__146B;
Instance_Name = master_reveal_coretop_instance/core0/tm_u/pmi_ram_dpXO3LFbinarynonespeedasyncdisablereg146101024146101024/pmi_ram_dpXbnonesadr146101024146101024123cc668_0_9_7;
Type = DP8KC;
Width_B = 9;
Depth_A = 1024;
Depth_B = 1024;
REGMODE_A = OUTREG;
REGMODE_B = OUTREG;
RESETMODE = ASYNC;
ASYNC_RESET_RELEASE = SYNC;
WRITEMODE_A = NORMAL;
WRITEMODE_B = NORMAL;
GSR = DISABLED;
MEM_LPC_FILE = pmi_ram_dpXbnonesadr146101024146101024123cc668__PMIP__1024__146__146B;
Instance_Name = master_reveal_coretop_instance/core0/tm_u/pmi_ram_dpXO3LFbinarynonespeedasyncdisablereg146101024146101024/pmi_ram_dpXbnonesadr146101024146101024123cc668_0_10_6;
Type = DP8KC;
Width_B = 9;
Depth_A = 1024;
Depth_B = 1024;
REGMODE_A = OUTREG;
REGMODE_B = OUTREG;
RESETMODE = ASYNC;
ASYNC_RESET_RELEASE = SYNC;
WRITEMODE_A = NORMAL;
WRITEMODE_B = NORMAL;
GSR = DISABLED;
MEM_LPC_FILE = pmi_ram_dpXbnonesadr146101024146101024123cc668__PMIP__1024__146__146B;
Instance_Name = master_reveal_coretop_instance/core0/tm_u/pmi_ram_dpXO3LFbinarynonespeedasyncdisablereg146101024146101024/pmi_ram_dpXbnonesadr146101024146101024123cc668_0_11_5;
Type = DP8KC;
Width_B = 9;
Depth_A = 1024;
Depth_B = 1024;
REGMODE_A = OUTREG;
REGMODE_B = OUTREG;
RESETMODE = ASYNC;
ASYNC_RESET_RELEASE = SYNC;
WRITEMODE_A = NORMAL;
WRITEMODE_B = NORMAL;
GSR = DISABLED;
MEM_LPC_FILE = pmi_ram_dpXbnonesadr146101024146101024123cc668__PMIP__1024__146__146B;
Instance_Name = master_reveal_coretop_instance/core0/tm_u/pmi_ram_dpXO3LFbinarynonespeedasyncdisablereg146101024146101024/pmi_ram_dpXbnonesadr146101024146101024123cc668_0_12_4;
Type = DP8KC;
Width_B = 9;
Depth_A = 1024;
Depth_B = 1024;
REGMODE_A = OUTREG;
REGMODE_B = OUTREG;
RESETMODE = ASYNC;
ASYNC_RESET_RELEASE = SYNC;
WRITEMODE_A = NORMAL;
WRITEMODE_B = NORMAL;
GSR = DISABLED;
MEM_LPC_FILE = pmi_ram_dpXbnonesadr146101024146101024123cc668__PMIP__1024__146__146B;
Instance_Name = master_reveal_coretop_instance/core0/tm_u/pmi_ram_dpXO3LFbinarynonespeedasyncdisablereg146101024146101024/pmi_ram_dpXbnonesadr146101024146101024123cc668_0_13_3;
Type = DP8KC;
Width_B = 9;
Depth_A = 1024;
Depth_B = 1024;
REGMODE_A = OUTREG;
REGMODE_B = OUTREG;
RESETMODE = ASYNC;
ASYNC_RESET_RELEASE = SYNC;
WRITEMODE_A = NORMAL;
WRITEMODE_B = NORMAL;
GSR = DISABLED;
MEM_LPC_FILE = pmi_ram_dpXbnonesadr146101024146101024123cc668__PMIP__1024__146__146B;
Instance_Name = master_reveal_coretop_instance/core0/tm_u/pmi_ram_dpXO3LFbinarynonespeedasyncdisablereg146101024146101024/pmi_ram_dpXbnonesadr146101024146101024123cc668_0_14_2;
Type = DP8KC;
Width_B = 9;
Depth_A = 1024;
Depth_B = 1024;
REGMODE_A = OUTREG;
REGMODE_B = OUTREG;
RESETMODE = ASYNC;
ASYNC_RESET_RELEASE = SYNC;
WRITEMODE_A = NORMAL;
WRITEMODE_B = NORMAL;
GSR = DISABLED;
MEM_LPC_FILE = pmi_ram_dpXbnonesadr146101024146101024123cc668__PMIP__1024__146__146B;
Instance_Name = master_reveal_coretop_instance/core0/tm_u/pmi_ram_dpXO3LFbinarynonespeedasyncdisablereg146101024146101024/pmi_ram_dpXbnonesadr146101024146101024123cc668_0_15_1;
Type = DP8KC;
Width_B = 9;
Depth_A = 1024;
Depth_B = 1024;
REGMODE_A = OUTREG;
REGMODE_B = OUTREG;
RESETMODE = ASYNC;
ASYNC_RESET_RELEASE = SYNC;
WRITEMODE_A = NORMAL;
WRITEMODE_B = NORMAL;
GSR = DISABLED;
MEM_LPC_FILE = pmi_ram_dpXbnonesadr146101024146101024123cc668__PMIP__1024__146__146B;
; End EBR Section
; Begin PLL Section
Instance_Name = PLL_Ent/PLLInst_0;
Type = EHXPLLJ;
CLKOP_Post_Divider_A_Input = DIVA;
CLKOS_Post_Divider_B_Input = DIVB;
CLKOS2_Post_Divider_C_Input = DIVC;
CLKOS3_Post_Divider_D_Input = DIVD;
Pre_Divider_A_Input = VCO_PHASE;
Pre_Divider_B_Input = VCO_PHASE;
Pre_Divider_C_Input = VCO_PHASE;
Pre_Divider_D_Input = VCO_PHASE;
VCO_Bypass_A_Input = VCO_PHASE;
VCO_Bypass_B_Input = VCO_PHASE;
VCO_Bypass_C_Input = VCO_PHASE;
VCO_Bypass_D_Input = VCO_PHASE;
FB_MODE = CLKOP;
CLKI_Divider = 3;
CLKFB_Divider = 17;
CLKOP_Divider = 4;
CLKOS_Divider = 16;
CLKOS2_Divider = 1;
CLKOS3_Divider = 1;
Fractional_N_Divider = 0;
CLKOP_Desired_Phase_Shift(degree) = 0;
CLKOP_Trim_Option_Rising/Falling = RISING;
CLKOP_Trim_Option_Delay = 0;
CLKOS_Desired_Phase_Shift(degree) = 0;
CLKOS_Trim_Option_Rising/Falling = RISING;
CLKOS_Trim_Option_Delay = 0;
CLKOS2_Desired_Phase_Shift(degree) = 0;
CLKOS3_Desired_Phase_Shift(degree) = 0;
; End PLL Section
