`timescale 1ns / 1ps

module tb_cordic_stage;

    reg clk;
    reg reset;
    reg  signed [15:0] X_i;
    reg  signed [15:0] Y_i;
    reg  signed [15:0] Z_i;
    
    wire signed [15:0] X_O;
    wire signed [15:0] Y_O;
    wire signed [15:0] Z_O;

    cordic_stage dut(.clk(clk), .reset(reset), .X_i(X_i), .Y_i(Y_i), .Z_i(Z_i), .X_O(X_O), .Y_O(Y_O), .Z_O(Z_O));

    // 100 MHz clock
    always #5 clk = ~clk;

    initial 
    begin
        clk   = 0;
        reset = 1;

        X_i = 16'h0000;
        Y_i = 16'h0000;
        Z_i = 16'h0000;

        #10;
        reset = 0;

        X_i <= 16'h26FF;
    end

    always @(posedge clk) 
    begin
        if (reset)
            Z_i <= 16'h0000;
        else
            Z_i <= Z_i + 16'h0001;
    end

endmodule


