// Giuseppe Quaratino
// Video CODEC Motion Compensation Controller Module
// Loads current block from frame A
// Loads reference area from frame B
// Calculates motion vector

module controller(clk, curr_block, ref_area);

	input [0:0] clk;

	output reg [7:0] curr_block [255:0];
	output reg [7:0] ref_area [2115:0];

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
    
    genvar row, column, iblock;
    
    // generate block for current block 
    generate
        for(iblock=0; iblock<30; iblock=iblock+1) begin    
            for(row=0; row<16; row=row+1) begin
                for(column=0; column<4; column=column+1) begin
                    assign addrA = (row[10:0], column[5:0]);
                    curr_block[column*(row+15):0] = frameA_in;   // Iteratively loads pixels into the current block reg 
                end
            end
        end
    endgenerate
    
endmodule
