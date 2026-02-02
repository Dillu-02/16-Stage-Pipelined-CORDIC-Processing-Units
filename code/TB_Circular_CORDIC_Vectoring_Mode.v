`timescale 1ns / 1ps

module tb_vectoring_cordic;

    reg clk, reset;
    reg signed [15:0] X_i, Y_i, Z_i;
    wire signed [15:0] X_O, Y_O, Z_O;

    vectoring_cordic dut (.clk(clk), .reset(reset), .X_i(X_i), .Y_i(Y_i), .Z_i(Z_i), .X_O(X_O), .Y_O(Y_O), .Z_O(Z_O));

    // 100 MHz clock
    always #5 clk = ~clk;
    
    initial 
    begin
        clk = 0;
        reset = 1;
        X_i = 0; Y_i = 0; Z_i = 0;

        #10;
        reset = 0;
        
        // (+1/root(2), +1/root(2))
        X_i <= 16'h2D41; 
        Y_i <= 16'h2D41;
        #200;

        // (-1/root(2), +1/root(2))
        X_i <= 16'hD2BF; 
        Y_i <= 16'h2D41;
        #200;

        // (-1/root(2), -1/root(2))
        X_i <= 16'hD2BF; 
        Y_i <= 16'hD2BF;
        #200;
        
        // (+1/root(2), -1/root(2))
        X_i <= 16'h2D41; 
        Y_i <= 16'hD2BF; 
        #200;
        
        $finish;
    end

endmodule
