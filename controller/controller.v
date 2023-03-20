// Giuseppe Quaratino
// Video CODEC Motion Compensation Controller Module
// Loads current block from frame A
// Loads reference area from frame B
// Calculates motion vector

module controller(clk, curr_block, ref_area);

	input [0:0] clk;

	output [127:0][15:0] curr_block, ref_area;

    wire [0:0] csA, csB;
    // Bits 16:7 is the row index from 0-719
    // Bits 6:0 is the column index from 0-79
    wire [16:0] addrA, addrB;
    wire [127:0] frameA_in, frameB_in;

    sram_1rw1r_128x65536_128 frameA(
        .clk0(clk),
        .csb0(!csA),
        .web0(1),
        .wmask0(0),
        .addr0(addrA),
        .din0(0),
        .dout0(frameA_in),
    
        .clk1(0),
        .csb1(1),
        .addr1(0),
        .dout1(frameA_in)
 );
 
    sram_1rw1r_128x65536_128 frameB(
    .clk0(clk),
        .csb0(!csB),
        .web0(1),
        .wmask0(0),
        .addr0(addrB),
        .din0(0),
        .dout0(frameB_in),
    
        .clk1(0),
        .csb1(1),
        .addr1(0),
        .dout1(frameB_in)
 );
    


endmodule
