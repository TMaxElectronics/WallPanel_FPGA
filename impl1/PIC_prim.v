// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.11.0.396.4
// Netlist written on Mon Jan 04 18:13:50 2021
//
// Verilog Description of module PIC
//

module PIC (LOGIC_CLOCK, PIC_OE_IN, PIC_WE_IN, PIC_CS_IN, PIC_ADDR_IN, 
            PIC_DATA_IN, PIC_READY, BUS_DATA_OUT, BUS_DATA_IN, BUS_ADDR_OUT, 
            BUS_ADDR_IN, BUS_REQ, BUS_GRANT, BUS_DIRECTION_OUT, BUS_DIRECTION_IN, 
            BUS_DONE_OUT, BUS_DONE_IN);   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(6[8:11])
    input LOGIC_CLOCK;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(8[3:14])
    input PIC_OE_IN;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(10[3:12])
    input PIC_WE_IN;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(11[3:12])
    input PIC_CS_IN;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(12[3:12])
    input [16:0]PIC_ADDR_IN;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(13[3:14])
    inout [15:0]PIC_DATA_IN;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(14[3:14])
    output PIC_READY;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(15[3:12])
    output [15:0]BUS_DATA_OUT;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(17[3:15])
    input [15:0]BUS_DATA_IN;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(18[3:14])
    output [31:0]BUS_ADDR_OUT;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    input [31:0]BUS_ADDR_IN;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(20[3:14])
    output BUS_REQ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(22[3:10])
    input BUS_GRANT;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(23[3:12])
    output BUS_DIRECTION_OUT;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(25[3:20])
    input BUS_DIRECTION_IN;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(26[3:19])
    output BUS_DONE_OUT;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(27[3:15])
    input BUS_DONE_IN;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(28[3:14])
    
    wire LOGIC_CLOCK_c /* synthesis is_clock=1 */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(8[3:14])
    wire LOGIC_CLOCK_N_7 /* synthesis is_inv_clock=1 */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(22[3:10])
    
    wire GND_net, PIC_OE_IN_c, PIC_WE_IN_c, PIC_ADDR_IN_c_16, PIC_ADDR_IN_c_15, 
        PIC_ADDR_IN_c_14, PIC_ADDR_IN_c_13, PIC_ADDR_IN_c_12, PIC_ADDR_IN_c_11, 
        PIC_ADDR_IN_c_10, PIC_ADDR_IN_c_9, PIC_ADDR_IN_c_8, PIC_ADDR_IN_c_7, 
        PIC_ADDR_IN_c_6, PIC_ADDR_IN_c_5, PIC_ADDR_IN_c_4, PIC_ADDR_IN_c_3, 
        PIC_ADDR_IN_c_2, PIC_ADDR_IN_c_1, PIC_ADDR_IN_c_0, PIC_READY_c, 
        BUS_DATA_OUT_c_15, BUS_DATA_OUT_c_14, BUS_DATA_OUT_c_13, BUS_DATA_OUT_c_12, 
        BUS_DATA_OUT_c_11, BUS_DATA_OUT_c_10, BUS_DATA_OUT_c_9, BUS_DATA_OUT_c_8, 
        BUS_DATA_OUT_c_7, BUS_DATA_OUT_c_6, BUS_DATA_OUT_c_5, BUS_DATA_OUT_c_4, 
        BUS_DATA_OUT_c_3, BUS_DATA_OUT_c_2, BUS_DATA_OUT_c_1, BUS_DATA_OUT_c_0, 
        BUS_DATA_IN_c_15, BUS_DATA_IN_c_14, BUS_DATA_IN_c_13, BUS_DATA_IN_c_12, 
        BUS_DATA_IN_c_11, BUS_DATA_IN_c_10, BUS_DATA_IN_c_9, BUS_DATA_IN_c_8, 
        BUS_DATA_IN_c_7, BUS_DATA_IN_c_6, BUS_DATA_IN_c_5, BUS_DATA_IN_c_4, 
        BUS_DATA_IN_c_3, BUS_DATA_IN_c_2, BUS_DATA_IN_c_1, BUS_DATA_IN_c_0, 
        PIC_DATA_IN_out_14, PIC_DATA_IN_out_13, PIC_DATA_IN_out_12, PIC_DATA_IN_out_11, 
        PIC_DATA_IN_out_10, BUS_ADDR_OUT_c_16, BUS_ADDR_OUT_c_15, BUS_ADDR_OUT_c_14, 
        BUS_ADDR_OUT_c_13, BUS_ADDR_OUT_c_12, BUS_ADDR_OUT_c_11, BUS_ADDR_OUT_c_10, 
        BUS_ADDR_OUT_c_9, BUS_ADDR_OUT_c_8, BUS_ADDR_OUT_c_7, BUS_ADDR_OUT_c_6, 
        BUS_ADDR_OUT_c_5, BUS_ADDR_OUT_c_4, BUS_ADDR_OUT_c_3, BUS_ADDR_OUT_c_2, 
        BUS_ADDR_OUT_c_1, BUS_ADDR_OUT_c_0, BUS_REQ_c, BUS_GRANT_c, 
        BUS_DIRECTION_OUT_c, BUS_DIRECTION_IN_c, BUS_DONE_IN_c, n334, 
        BUS_DIRECTION_INTERNAL, VCC_net, PIC_DATA_IN_out_6, PIC_DATA_IN_out_7, 
        PIC_DATA_IN_out_8, PIC_DATA_IN_out_9, n331, PIC_DATA_IN_out_15, 
        PIC_DATA_IN_out_5, PIC_DATA_IN_out_4, PIC_DATA_IN_out_3, PIC_DATA_IN_out_2, 
        PIC_DATA_IN_out_1, PIC_DATA_IN_out_0, n257;
    
    LUT4 i187_2_lut_3_lut (.A(BUS_GRANT_c), .B(BUS_DIRECTION_IN_c), .C(PIC_DATA_IN_out_1), 
         .Z(BUS_DATA_OUT_c_1)) /* synthesis lut_function=(!((B+!(C))+!A)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(56[39:85])
    defparam i187_2_lut_3_lut.init = 16'h2020;
    LUT4 i155_2_lut_3_lut (.A(BUS_GRANT_c), .B(BUS_DIRECTION_IN_c), .C(PIC_DATA_IN_out_0), 
         .Z(BUS_DATA_OUT_c_0)) /* synthesis lut_function=(!((B+!(C))+!A)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(56[39:85])
    defparam i155_2_lut_3_lut.init = 16'h2020;
    BB PIC_DATA_IN_pad_15 (.I(BUS_DATA_IN_c_15), .T(PIC_OE_IN_c), .B(PIC_DATA_IN[15]), 
       .O(PIC_DATA_IN_out_15));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(81[2:13])
    LUT4 i1_2_lut_3_lut (.A(PIC_OE_IN_c), .B(PIC_WE_IN_c), .C(BUS_DONE_IN_c), 
         .Z(PIC_READY_c)) /* synthesis lut_function=(!(A (B+!(C))+!A !(C))) */ ;
    defparam i1_2_lut_3_lut.init = 16'h7070;
    FD1S3AX BUS_DIRECTION_INTERNAL_101 (.D(n257), .CK(LOGIC_CLOCK_N_7), 
            .Q(BUS_DIRECTION_INTERNAL));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(85[3] 92[10])
    defparam BUS_DIRECTION_INTERNAL_101.GSR = "DISABLED";
    LUT4 i178_2_lut_3_lut (.A(BUS_GRANT_c), .B(BUS_DIRECTION_IN_c), .C(PIC_DATA_IN_out_10), 
         .Z(BUS_DATA_OUT_c_10)) /* synthesis lut_function=(!((B+!(C))+!A)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(56[39:85])
    defparam i178_2_lut_3_lut.init = 16'h2020;
    LUT4 i173_2_lut_3_lut (.A(BUS_GRANT_c), .B(BUS_DIRECTION_IN_c), .C(PIC_DATA_IN_out_15), 
         .Z(BUS_DATA_OUT_c_15)) /* synthesis lut_function=(!((B+!(C))+!A)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(56[39:85])
    defparam i173_2_lut_3_lut.init = 16'h2020;
    LUT4 i179_2_lut_3_lut (.A(BUS_GRANT_c), .B(BUS_DIRECTION_IN_c), .C(PIC_DATA_IN_out_9), 
         .Z(BUS_DATA_OUT_c_9)) /* synthesis lut_function=(!((B+!(C))+!A)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(56[39:85])
    defparam i179_2_lut_3_lut.init = 16'h2020;
    LUT4 i174_2_lut_3_lut (.A(BUS_GRANT_c), .B(BUS_DIRECTION_IN_c), .C(PIC_DATA_IN_out_14), 
         .Z(BUS_DATA_OUT_c_14)) /* synthesis lut_function=(!((B+!(C))+!A)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(56[39:85])
    defparam i174_2_lut_3_lut.init = 16'h2020;
    LUT4 i1_2_lut (.A(BUS_GRANT_c), .B(BUS_DIRECTION_INTERNAL), .Z(BUS_DIRECTION_OUT_c)) /* synthesis lut_function=(A (B)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(23[3:12])
    defparam i1_2_lut.init = 16'h8888;
    LUT4 i180_2_lut_3_lut (.A(BUS_GRANT_c), .B(BUS_DIRECTION_IN_c), .C(PIC_DATA_IN_out_8), 
         .Z(BUS_DATA_OUT_c_8)) /* synthesis lut_function=(!((B+!(C))+!A)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(56[39:85])
    defparam i180_2_lut_3_lut.init = 16'h2020;
    LUT4 i181_2_lut_3_lut (.A(BUS_GRANT_c), .B(BUS_DIRECTION_IN_c), .C(PIC_DATA_IN_out_7), 
         .Z(BUS_DATA_OUT_c_7)) /* synthesis lut_function=(!((B+!(C))+!A)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(56[39:85])
    defparam i181_2_lut_3_lut.init = 16'h2020;
    GSR GSR_INST (.GSR(n331));
    LUT4 i182_2_lut_3_lut (.A(BUS_GRANT_c), .B(BUS_DIRECTION_IN_c), .C(PIC_DATA_IN_out_6), 
         .Z(BUS_DATA_OUT_c_6)) /* synthesis lut_function=(!((B+!(C))+!A)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(56[39:85])
    defparam i182_2_lut_3_lut.init = 16'h2020;
    LUT4 i156_2_lut (.A(PIC_ADDR_IN_c_0), .B(BUS_GRANT_c), .Z(BUS_ADDR_OUT_c_0)) /* synthesis lut_function=(A (B)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(55[18:73])
    defparam i156_2_lut.init = 16'h8888;
    LUT4 i172_2_lut (.A(PIC_ADDR_IN_c_1), .B(BUS_GRANT_c), .Z(BUS_ADDR_OUT_c_1)) /* synthesis lut_function=(A (B)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(55[18:73])
    defparam i172_2_lut.init = 16'h8888;
    LUT4 i171_2_lut (.A(PIC_ADDR_IN_c_2), .B(BUS_GRANT_c), .Z(BUS_ADDR_OUT_c_2)) /* synthesis lut_function=(A (B)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(55[18:73])
    defparam i171_2_lut.init = 16'h8888;
    LUT4 i170_2_lut (.A(PIC_ADDR_IN_c_3), .B(BUS_GRANT_c), .Z(BUS_ADDR_OUT_c_3)) /* synthesis lut_function=(A (B)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(55[18:73])
    defparam i170_2_lut.init = 16'h8888;
    LUT4 i169_2_lut (.A(PIC_ADDR_IN_c_4), .B(BUS_GRANT_c), .Z(BUS_ADDR_OUT_c_4)) /* synthesis lut_function=(A (B)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(55[18:73])
    defparam i169_2_lut.init = 16'h8888;
    LUT4 i168_2_lut (.A(PIC_ADDR_IN_c_5), .B(BUS_GRANT_c), .Z(BUS_ADDR_OUT_c_5)) /* synthesis lut_function=(A (B)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(55[18:73])
    defparam i168_2_lut.init = 16'h8888;
    LUT4 i167_2_lut (.A(PIC_ADDR_IN_c_6), .B(BUS_GRANT_c), .Z(BUS_ADDR_OUT_c_6)) /* synthesis lut_function=(A (B)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(55[18:73])
    defparam i167_2_lut.init = 16'h8888;
    LUT4 i166_2_lut (.A(PIC_ADDR_IN_c_7), .B(BUS_GRANT_c), .Z(BUS_ADDR_OUT_c_7)) /* synthesis lut_function=(A (B)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(55[18:73])
    defparam i166_2_lut.init = 16'h8888;
    LUT4 i165_2_lut (.A(PIC_ADDR_IN_c_8), .B(BUS_GRANT_c), .Z(BUS_ADDR_OUT_c_8)) /* synthesis lut_function=(A (B)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(55[18:73])
    defparam i165_2_lut.init = 16'h8888;
    LUT4 i164_2_lut (.A(PIC_ADDR_IN_c_9), .B(BUS_GRANT_c), .Z(BUS_ADDR_OUT_c_9)) /* synthesis lut_function=(A (B)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(55[18:73])
    defparam i164_2_lut.init = 16'h8888;
    LUT4 i163_2_lut (.A(PIC_ADDR_IN_c_10), .B(BUS_GRANT_c), .Z(BUS_ADDR_OUT_c_10)) /* synthesis lut_function=(A (B)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(55[18:73])
    defparam i163_2_lut.init = 16'h8888;
    LUT4 i162_2_lut (.A(PIC_ADDR_IN_c_11), .B(BUS_GRANT_c), .Z(BUS_ADDR_OUT_c_11)) /* synthesis lut_function=(A (B)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(55[18:73])
    defparam i162_2_lut.init = 16'h8888;
    LUT4 i161_2_lut (.A(PIC_ADDR_IN_c_12), .B(BUS_GRANT_c), .Z(BUS_ADDR_OUT_c_12)) /* synthesis lut_function=(A (B)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(55[18:73])
    defparam i161_2_lut.init = 16'h8888;
    LUT4 i160_2_lut (.A(PIC_ADDR_IN_c_13), .B(BUS_GRANT_c), .Z(BUS_ADDR_OUT_c_13)) /* synthesis lut_function=(A (B)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(55[18:73])
    defparam i160_2_lut.init = 16'h8888;
    LUT4 i159_2_lut (.A(PIC_ADDR_IN_c_14), .B(BUS_GRANT_c), .Z(BUS_ADDR_OUT_c_14)) /* synthesis lut_function=(A (B)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(55[18:73])
    defparam i159_2_lut.init = 16'h8888;
    LUT4 i158_2_lut (.A(PIC_ADDR_IN_c_15), .B(BUS_GRANT_c), .Z(BUS_ADDR_OUT_c_15)) /* synthesis lut_function=(A (B)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(55[18:73])
    defparam i158_2_lut.init = 16'h8888;
    BB PIC_DATA_IN_pad_14 (.I(BUS_DATA_IN_c_14), .T(PIC_OE_IN_c), .B(PIC_DATA_IN[14]), 
       .O(PIC_DATA_IN_out_14));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(81[2:13])
    LUT4 i157_2_lut (.A(PIC_ADDR_IN_c_16), .B(BUS_GRANT_c), .Z(BUS_ADDR_OUT_c_16)) /* synthesis lut_function=(A (B)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(55[18:73])
    defparam i157_2_lut.init = 16'h8888;
    BB PIC_DATA_IN_pad_13 (.I(BUS_DATA_IN_c_13), .T(PIC_OE_IN_c), .B(PIC_DATA_IN[13]), 
       .O(PIC_DATA_IN_out_13));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(81[2:13])
    LUT4 i209_2_lut_rep_1 (.A(PIC_OE_IN_c), .B(PIC_WE_IN_c), .Z(n331)) /* synthesis lut_function=(!(A (B))) */ ;
    defparam i209_2_lut_rep_1.init = 16'h7777;
    BB PIC_DATA_IN_pad_12 (.I(BUS_DATA_IN_c_12), .T(PIC_OE_IN_c), .B(PIC_DATA_IN[12]), 
       .O(PIC_DATA_IN_out_12));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(81[2:13])
    LUT4 i176_2_lut_3_lut (.A(BUS_GRANT_c), .B(BUS_DIRECTION_IN_c), .C(PIC_DATA_IN_out_12), 
         .Z(BUS_DATA_OUT_c_12)) /* synthesis lut_function=(!((B+!(C))+!A)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(56[39:85])
    defparam i176_2_lut_3_lut.init = 16'h2020;
    BB PIC_DATA_IN_pad_11 (.I(BUS_DATA_IN_c_11), .T(PIC_OE_IN_c), .B(PIC_DATA_IN[11]), 
       .O(PIC_DATA_IN_out_11));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(81[2:13])
    LUT4 i1_3_lut (.A(PIC_OE_IN_c), .B(PIC_WE_IN_c), .C(BUS_DIRECTION_INTERNAL), 
         .Z(n257)) /* synthesis lut_function=(A (B (C))+!A (B)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(10[3:12])
    defparam i1_3_lut.init = 16'hc4c4;
    BB PIC_DATA_IN_pad_10 (.I(BUS_DATA_IN_c_10), .T(PIC_OE_IN_c), .B(PIC_DATA_IN[10]), 
       .O(PIC_DATA_IN_out_10));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(81[2:13])
    LUT4 i177_2_lut_3_lut (.A(BUS_GRANT_c), .B(BUS_DIRECTION_IN_c), .C(PIC_DATA_IN_out_11), 
         .Z(BUS_DATA_OUT_c_11)) /* synthesis lut_function=(!((B+!(C))+!A)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(56[39:85])
    defparam i177_2_lut_3_lut.init = 16'h2020;
    BB PIC_DATA_IN_pad_9 (.I(BUS_DATA_IN_c_9), .T(PIC_OE_IN_c), .B(PIC_DATA_IN[9]), 
       .O(PIC_DATA_IN_out_9));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(81[2:13])
    BB PIC_DATA_IN_pad_8 (.I(BUS_DATA_IN_c_8), .T(PIC_OE_IN_c), .B(PIC_DATA_IN[8]), 
       .O(PIC_DATA_IN_out_8));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(81[2:13])
    BB PIC_DATA_IN_pad_7 (.I(BUS_DATA_IN_c_7), .T(PIC_OE_IN_c), .B(PIC_DATA_IN[7]), 
       .O(PIC_DATA_IN_out_7));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(81[2:13])
    BB PIC_DATA_IN_pad_6 (.I(BUS_DATA_IN_c_6), .T(PIC_OE_IN_c), .B(PIC_DATA_IN[6]), 
       .O(PIC_DATA_IN_out_6));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(81[2:13])
    BB PIC_DATA_IN_pad_5 (.I(BUS_DATA_IN_c_5), .T(PIC_OE_IN_c), .B(PIC_DATA_IN[5]), 
       .O(PIC_DATA_IN_out_5));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(81[2:13])
    BB PIC_DATA_IN_pad_4 (.I(BUS_DATA_IN_c_4), .T(PIC_OE_IN_c), .B(PIC_DATA_IN[4]), 
       .O(PIC_DATA_IN_out_4));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(81[2:13])
    BB PIC_DATA_IN_pad_3 (.I(BUS_DATA_IN_c_3), .T(PIC_OE_IN_c), .B(PIC_DATA_IN[3]), 
       .O(PIC_DATA_IN_out_3));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(81[2:13])
    BB PIC_DATA_IN_pad_2 (.I(BUS_DATA_IN_c_2), .T(PIC_OE_IN_c), .B(PIC_DATA_IN[2]), 
       .O(PIC_DATA_IN_out_2));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(81[2:13])
    BB PIC_DATA_IN_pad_1 (.I(BUS_DATA_IN_c_1), .T(PIC_OE_IN_c), .B(PIC_DATA_IN[1]), 
       .O(PIC_DATA_IN_out_1));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(81[2:13])
    BB PIC_DATA_IN_pad_0 (.I(BUS_DATA_IN_c_0), .T(PIC_OE_IN_c), .B(PIC_DATA_IN[0]), 
       .O(PIC_DATA_IN_out_0));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(81[2:13])
    LUT4 i183_2_lut_3_lut (.A(BUS_GRANT_c), .B(BUS_DIRECTION_IN_c), .C(PIC_DATA_IN_out_5), 
         .Z(BUS_DATA_OUT_c_5)) /* synthesis lut_function=(!((B+!(C))+!A)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(56[39:85])
    defparam i183_2_lut_3_lut.init = 16'h2020;
    OB PIC_READY_pad (.I(PIC_READY_c), .O(PIC_READY));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(15[3:12])
    OB BUS_DATA_OUT_pad_15 (.I(BUS_DATA_OUT_c_15), .O(BUS_DATA_OUT[15]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(17[3:15])
    OB BUS_DATA_OUT_pad_14 (.I(BUS_DATA_OUT_c_14), .O(BUS_DATA_OUT[14]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(17[3:15])
    OB BUS_DATA_OUT_pad_13 (.I(BUS_DATA_OUT_c_13), .O(BUS_DATA_OUT[13]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(17[3:15])
    OB BUS_DATA_OUT_pad_12 (.I(BUS_DATA_OUT_c_12), .O(BUS_DATA_OUT[12]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(17[3:15])
    OB BUS_DATA_OUT_pad_11 (.I(BUS_DATA_OUT_c_11), .O(BUS_DATA_OUT[11]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(17[3:15])
    OB BUS_DATA_OUT_pad_10 (.I(BUS_DATA_OUT_c_10), .O(BUS_DATA_OUT[10]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(17[3:15])
    OB BUS_DATA_OUT_pad_9 (.I(BUS_DATA_OUT_c_9), .O(BUS_DATA_OUT[9]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(17[3:15])
    OB BUS_DATA_OUT_pad_8 (.I(BUS_DATA_OUT_c_8), .O(BUS_DATA_OUT[8]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(17[3:15])
    OB BUS_DATA_OUT_pad_7 (.I(BUS_DATA_OUT_c_7), .O(BUS_DATA_OUT[7]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(17[3:15])
    OB BUS_DATA_OUT_pad_6 (.I(BUS_DATA_OUT_c_6), .O(BUS_DATA_OUT[6]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(17[3:15])
    OB BUS_DATA_OUT_pad_5 (.I(BUS_DATA_OUT_c_5), .O(BUS_DATA_OUT[5]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(17[3:15])
    OB BUS_DATA_OUT_pad_4 (.I(BUS_DATA_OUT_c_4), .O(BUS_DATA_OUT[4]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(17[3:15])
    OB BUS_DATA_OUT_pad_3 (.I(BUS_DATA_OUT_c_3), .O(BUS_DATA_OUT[3]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(17[3:15])
    OB BUS_DATA_OUT_pad_2 (.I(BUS_DATA_OUT_c_2), .O(BUS_DATA_OUT[2]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(17[3:15])
    OB BUS_DATA_OUT_pad_1 (.I(BUS_DATA_OUT_c_1), .O(BUS_DATA_OUT[1]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(17[3:15])
    OB BUS_DATA_OUT_pad_0 (.I(BUS_DATA_OUT_c_0), .O(BUS_DATA_OUT[0]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(17[3:15])
    OB BUS_ADDR_OUT_pad_31 (.I(GND_net), .O(BUS_ADDR_OUT[31]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_30 (.I(GND_net), .O(BUS_ADDR_OUT[30]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_29 (.I(GND_net), .O(BUS_ADDR_OUT[29]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_28 (.I(GND_net), .O(BUS_ADDR_OUT[28]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_27 (.I(GND_net), .O(BUS_ADDR_OUT[27]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_26 (.I(GND_net), .O(BUS_ADDR_OUT[26]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_25 (.I(GND_net), .O(BUS_ADDR_OUT[25]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_24 (.I(GND_net), .O(BUS_ADDR_OUT[24]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_23 (.I(GND_net), .O(BUS_ADDR_OUT[23]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_22 (.I(GND_net), .O(BUS_ADDR_OUT[22]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_21 (.I(GND_net), .O(BUS_ADDR_OUT[21]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_20 (.I(GND_net), .O(BUS_ADDR_OUT[20]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_19 (.I(GND_net), .O(BUS_ADDR_OUT[19]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_18 (.I(GND_net), .O(BUS_ADDR_OUT[18]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_17 (.I(GND_net), .O(BUS_ADDR_OUT[17]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_16 (.I(BUS_ADDR_OUT_c_16), .O(BUS_ADDR_OUT[16]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_15 (.I(BUS_ADDR_OUT_c_15), .O(BUS_ADDR_OUT[15]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_14 (.I(BUS_ADDR_OUT_c_14), .O(BUS_ADDR_OUT[14]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_13 (.I(BUS_ADDR_OUT_c_13), .O(BUS_ADDR_OUT[13]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_12 (.I(BUS_ADDR_OUT_c_12), .O(BUS_ADDR_OUT[12]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_11 (.I(BUS_ADDR_OUT_c_11), .O(BUS_ADDR_OUT[11]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_10 (.I(BUS_ADDR_OUT_c_10), .O(BUS_ADDR_OUT[10]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_9 (.I(BUS_ADDR_OUT_c_9), .O(BUS_ADDR_OUT[9]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_8 (.I(BUS_ADDR_OUT_c_8), .O(BUS_ADDR_OUT[8]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_7 (.I(BUS_ADDR_OUT_c_7), .O(BUS_ADDR_OUT[7]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_6 (.I(BUS_ADDR_OUT_c_6), .O(BUS_ADDR_OUT[6]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_5 (.I(BUS_ADDR_OUT_c_5), .O(BUS_ADDR_OUT[5]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_4 (.I(BUS_ADDR_OUT_c_4), .O(BUS_ADDR_OUT[4]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_3 (.I(BUS_ADDR_OUT_c_3), .O(BUS_ADDR_OUT[3]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_2 (.I(BUS_ADDR_OUT_c_2), .O(BUS_ADDR_OUT[2]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_1 (.I(BUS_ADDR_OUT_c_1), .O(BUS_ADDR_OUT[1]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_ADDR_OUT_pad_0 (.I(BUS_ADDR_OUT_c_0), .O(BUS_ADDR_OUT[0]));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(19[3:15])
    OB BUS_REQ_pad (.I(BUS_REQ_c), .O(BUS_REQ));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(22[3:10])
    OB BUS_DIRECTION_OUT_pad (.I(BUS_DIRECTION_OUT_c), .O(BUS_DIRECTION_OUT));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(25[3:20])
    OB BUS_DONE_OUT_pad (.I(GND_net), .O(BUS_DONE_OUT));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(27[3:15])
    IB LOGIC_CLOCK_pad (.I(LOGIC_CLOCK), .O(LOGIC_CLOCK_c));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(8[3:14])
    IB PIC_OE_IN_pad (.I(PIC_OE_IN), .O(PIC_OE_IN_c));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(10[3:12])
    IB PIC_WE_IN_pad (.I(PIC_WE_IN), .O(PIC_WE_IN_c));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(11[3:12])
    IB PIC_ADDR_IN_pad_16 (.I(PIC_ADDR_IN[16]), .O(PIC_ADDR_IN_c_16));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(13[3:14])
    IB PIC_ADDR_IN_pad_15 (.I(PIC_ADDR_IN[15]), .O(PIC_ADDR_IN_c_15));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(13[3:14])
    IB PIC_ADDR_IN_pad_14 (.I(PIC_ADDR_IN[14]), .O(PIC_ADDR_IN_c_14));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(13[3:14])
    IB PIC_ADDR_IN_pad_13 (.I(PIC_ADDR_IN[13]), .O(PIC_ADDR_IN_c_13));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(13[3:14])
    IB PIC_ADDR_IN_pad_12 (.I(PIC_ADDR_IN[12]), .O(PIC_ADDR_IN_c_12));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(13[3:14])
    IB PIC_ADDR_IN_pad_11 (.I(PIC_ADDR_IN[11]), .O(PIC_ADDR_IN_c_11));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(13[3:14])
    IB PIC_ADDR_IN_pad_10 (.I(PIC_ADDR_IN[10]), .O(PIC_ADDR_IN_c_10));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(13[3:14])
    IB PIC_ADDR_IN_pad_9 (.I(PIC_ADDR_IN[9]), .O(PIC_ADDR_IN_c_9));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(13[3:14])
    IB PIC_ADDR_IN_pad_8 (.I(PIC_ADDR_IN[8]), .O(PIC_ADDR_IN_c_8));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(13[3:14])
    IB PIC_ADDR_IN_pad_7 (.I(PIC_ADDR_IN[7]), .O(PIC_ADDR_IN_c_7));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(13[3:14])
    IB PIC_ADDR_IN_pad_6 (.I(PIC_ADDR_IN[6]), .O(PIC_ADDR_IN_c_6));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(13[3:14])
    IB PIC_ADDR_IN_pad_5 (.I(PIC_ADDR_IN[5]), .O(PIC_ADDR_IN_c_5));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(13[3:14])
    IB PIC_ADDR_IN_pad_4 (.I(PIC_ADDR_IN[4]), .O(PIC_ADDR_IN_c_4));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(13[3:14])
    IB PIC_ADDR_IN_pad_3 (.I(PIC_ADDR_IN[3]), .O(PIC_ADDR_IN_c_3));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(13[3:14])
    IB PIC_ADDR_IN_pad_2 (.I(PIC_ADDR_IN[2]), .O(PIC_ADDR_IN_c_2));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(13[3:14])
    IB PIC_ADDR_IN_pad_1 (.I(PIC_ADDR_IN[1]), .O(PIC_ADDR_IN_c_1));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(13[3:14])
    IB PIC_ADDR_IN_pad_0 (.I(PIC_ADDR_IN[0]), .O(PIC_ADDR_IN_c_0));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(13[3:14])
    IB BUS_DATA_IN_pad_15 (.I(BUS_DATA_IN[15]), .O(BUS_DATA_IN_c_15));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(18[3:14])
    IB BUS_DATA_IN_pad_14 (.I(BUS_DATA_IN[14]), .O(BUS_DATA_IN_c_14));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(18[3:14])
    IB BUS_DATA_IN_pad_13 (.I(BUS_DATA_IN[13]), .O(BUS_DATA_IN_c_13));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(18[3:14])
    IB BUS_DATA_IN_pad_12 (.I(BUS_DATA_IN[12]), .O(BUS_DATA_IN_c_12));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(18[3:14])
    IB BUS_DATA_IN_pad_11 (.I(BUS_DATA_IN[11]), .O(BUS_DATA_IN_c_11));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(18[3:14])
    IB BUS_DATA_IN_pad_10 (.I(BUS_DATA_IN[10]), .O(BUS_DATA_IN_c_10));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(18[3:14])
    IB BUS_DATA_IN_pad_9 (.I(BUS_DATA_IN[9]), .O(BUS_DATA_IN_c_9));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(18[3:14])
    IB BUS_DATA_IN_pad_8 (.I(BUS_DATA_IN[8]), .O(BUS_DATA_IN_c_8));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(18[3:14])
    IB BUS_DATA_IN_pad_7 (.I(BUS_DATA_IN[7]), .O(BUS_DATA_IN_c_7));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(18[3:14])
    IB BUS_DATA_IN_pad_6 (.I(BUS_DATA_IN[6]), .O(BUS_DATA_IN_c_6));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(18[3:14])
    IB BUS_DATA_IN_pad_5 (.I(BUS_DATA_IN[5]), .O(BUS_DATA_IN_c_5));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(18[3:14])
    IB BUS_DATA_IN_pad_4 (.I(BUS_DATA_IN[4]), .O(BUS_DATA_IN_c_4));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(18[3:14])
    IB BUS_DATA_IN_pad_3 (.I(BUS_DATA_IN[3]), .O(BUS_DATA_IN_c_3));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(18[3:14])
    IB BUS_DATA_IN_pad_2 (.I(BUS_DATA_IN[2]), .O(BUS_DATA_IN_c_2));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(18[3:14])
    IB BUS_DATA_IN_pad_1 (.I(BUS_DATA_IN[1]), .O(BUS_DATA_IN_c_1));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(18[3:14])
    IB BUS_DATA_IN_pad_0 (.I(BUS_DATA_IN[0]), .O(BUS_DATA_IN_c_0));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(18[3:14])
    IB BUS_GRANT_pad (.I(BUS_GRANT), .O(BUS_GRANT_c));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(23[3:12])
    IB BUS_DIRECTION_IN_pad (.I(BUS_DIRECTION_IN), .O(BUS_DIRECTION_IN_c));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(26[3:19])
    IB BUS_DONE_IN_pad (.I(BUS_DONE_IN), .O(BUS_DONE_IN_c));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(28[3:14])
    LUT4 i184_2_lut_3_lut (.A(BUS_GRANT_c), .B(BUS_DIRECTION_IN_c), .C(PIC_DATA_IN_out_4), 
         .Z(BUS_DATA_OUT_c_4)) /* synthesis lut_function=(!((B+!(C))+!A)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(56[39:85])
    defparam i184_2_lut_3_lut.init = 16'h2020;
    FD1S3AX BUS_REQ_100 (.D(n334), .CK(LOGIC_CLOCK_N_7), .Q(BUS_REQ_c));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(85[3] 92[10])
    defparam BUS_REQ_100.GSR = "ENABLED";
    LUT4 i185_2_lut_3_lut (.A(BUS_GRANT_c), .B(BUS_DIRECTION_IN_c), .C(PIC_DATA_IN_out_3), 
         .Z(BUS_DATA_OUT_c_3)) /* synthesis lut_function=(!((B+!(C))+!A)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(56[39:85])
    defparam i185_2_lut_3_lut.init = 16'h2020;
    VHI i212 (.Z(VCC_net));
    INV i214 (.A(LOGIC_CLOCK_c), .Z(LOGIC_CLOCK_N_7));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(8[3:14])
    LUT4 i175_2_lut_3_lut (.A(BUS_GRANT_c), .B(BUS_DIRECTION_IN_c), .C(PIC_DATA_IN_out_13), 
         .Z(BUS_DATA_OUT_c_13)) /* synthesis lut_function=(!((B+!(C))+!A)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(56[39:85])
    defparam i175_2_lut_3_lut.init = 16'h2020;
    VLO i1 (.Z(GND_net));
    TSALL TSALL_INST (.TSALL(GND_net));
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    LUT4 m1_lut (.Z(n334)) /* synthesis lut_function=1, syn_instantiated=1 */ ;
    defparam m1_lut.init = 16'hffff;
    LUT4 i186_2_lut_3_lut (.A(BUS_GRANT_c), .B(BUS_DIRECTION_IN_c), .C(PIC_DATA_IN_out_2), 
         .Z(BUS_DATA_OUT_c_2)) /* synthesis lut_function=(!((B+!(C))+!A)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/pic.vhd(56[39:85])
    defparam i186_2_lut_3_lut.init = 16'h2020;
    
endmodule
//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

