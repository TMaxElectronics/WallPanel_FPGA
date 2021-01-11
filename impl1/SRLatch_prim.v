// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.11.0.396.4
// Netlist written on Mon Jan 04 18:13:02 2021
//
// Verilog Description of module SRLatch
//

module SRLatch (s, r, q);   // d:/onedrive/lattice diamond projects/wallpanel_fpga/srlatch.vhd(5[8:15])
    input s;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/srlatch.vhd(8[9:10])
    input r;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/srlatch.vhd(9[9:10])
    output q;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/srlatch.vhd(10[9:10])
    
    wire r_c /* synthesis is_clock=1, SET_AS_NETWORK=r_c */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/srlatch.vhd(9[9:10])
    
    wire s_c, q_c, GND_net, n13, n14, VCC_net;
    
    VLO i28 (.Z(GND_net));
    OB q_pad (.I(q_c), .O(q));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/srlatch.vhd(10[9:10])
    LUT4 i24_1_lut (.A(s_c), .Z(n13)) /* synthesis lut_function=(!(A)) */ ;   // d:/onedrive/lattice diamond projects/wallpanel_fpga/srlatch.vhd(8[9:10])
    defparam i24_1_lut.init = 16'h5555;
    IB s_pad (.I(s), .O(s_c));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/srlatch.vhd(8[9:10])
    IB r_pad (.I(r), .O(r_c));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/srlatch.vhd(9[9:10])
    GSR GSR_INST (.GSR(n13));
    LUT4 m0_lut (.Z(n14)) /* synthesis lut_function=0, syn_instantiated=1 */ ;
    defparam m0_lut.init = 16'h0000;
    FD1S3AY qS_14 (.D(n14), .CK(r_c), .Q(q_c));   // d:/onedrive/lattice diamond projects/wallpanel_fpga/srlatch.vhd(29[3] 33[10])
    defparam qS_14.GSR = "ENABLED";
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    TSALL TSALL_INST (.TSALL(GND_net));
    VHI i31 (.Z(VCC_net));
    
endmodule
//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

