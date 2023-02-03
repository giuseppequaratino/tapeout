module cpu(searchWindow, totalSAE);

    parameter N=46,
              M=16,
              offsetX=0,
              offsetY=0;

    input [N-1:0][N-1:0] searchWindow;

    output reg [31:0] totalSAE

    // motionVec (offsetX,offsetY) ranges from [(M-N)/2, (M-N)/2] to [(N-M)/2, (N-M)/2]
    integer row, column;
    wire [M-1:0][M-1:0] refArea, curBlock;
    
    // Reference Area is an MxM region at the center of the search window with a motion vector of (0,0)
    // It is consistent among processors given an NxN frame
    // Current Block is an MxM region that slides around the search window based on its motion vector
    // Each processor has a different block based on the offsetX and offsetY motion vector parameters

    refArea[M-1:0][M-1:0] = searchWindow[(N-M)/2:(N-M)/2+M-1][(N-M)/2:(N-M)/2+M-1];
    curBlock[M-1:0][M-1:0] = searchWindow[(N-M)/2+offsetX:(N-M)/2+M+offsetX-1][(N-M)/2+offsetY:(N-M)/2+M+offsetY-1];

    totalSae = 0;

    // Unroll loop after testing
    for (row=0; row<M; row++)begin
        for (column=0; column<M; column++)begin
            totalSAE = totalSAE + abs(curBlock[row,column] - refArea[row,column]);
        end
    end

endmodule 