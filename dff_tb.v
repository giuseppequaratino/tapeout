module tb();

    reg [0:0] clk, reset, d;
    wire [0:0] q;

    dff #(.WIDTH(1)) ff(.clk(clk), .reset(reset), .d(d), .q(q));

    always @(clk)begin
        $display("d = %b; clk = %b; reset = %b; q = %b", d, clk, reset, q);
    end

    initial begin
        d=0; reset=0; clk=0;
        #10 clk = ~clk;
        #10 clk = ~clk; 
        #10 clk = ~clk; d=1;
        #10 clk = ~clk; 
        #10 clk = ~clk; 
        #10 clk = ~clk; 
        #10 clk = ~clk; reset = 1;
        #10 clk = ~clk;
    end

endmodule