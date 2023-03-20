// Giuseppe Quaratino
// Video CODEC Motion Compensation Controller Module
// Loads current block from frame A
// Loads reference area from frame B
// Calculates motion vector

module controller(clk, frameA_in, frameB_in, curr_block, ref_area);

	input [0:0] clk;
	input [127:0] frameA_in, frameB_in;

	output [127:0][15:0] curr_block, ref_area;




endmodule
