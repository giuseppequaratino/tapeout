module parallelization(searchWindow, refArea, SAE);

    parameter N=46,
              M=16;

    input [N-1:0][N-1:0] searchWindow;
    input [M-1:0][M-1:0] refArea;

    output [(N-M+1)^2-1:0] SAE;

    integer i,j;

    for (i=(M-N)/2;i<(N-M)/2;i++)begin
        for(j=(M-N)/2;j<(N-M);j++)begin
            cpu #(N=N, M=M, offsetX=i, offsetY=j) cpuPara(.searchWindow(searchWindow), .totalSAE(SAE));
        end
    end
    
    //cpu #(N=N, M=M, offsetX=M-N/2, offsetY=M-N/2) cpuPara(.searchWindow(searchWindow), .totalSAE(SAE));


endmodule 