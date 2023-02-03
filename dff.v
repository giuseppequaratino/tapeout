module dff(clk, reset, d, q);

    parameter WIDTH = 1;
    input wire [WIDTH-1:0] d;
    input wire [0:0] clk, reset;
    
    output reg [WIDTH-1:0] q;
    
    always @(posedge clk, posedge reset) 
     if(reset) q<=0;
     else q<=d;

endmodule