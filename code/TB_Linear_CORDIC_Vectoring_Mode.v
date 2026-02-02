`timescale 1ns / 1ps

module tb_linear_cordic_vectoring_mode;

    reg clk;
    reg reset;
    reg signed [15:0] X_i, Y_i, Z_i;
    wire signed [15:0] X_O, Y_O, Z_O;
    
    linear_cordic_vectoring_mode dut(.clk(clk), .reset(reset), .X_i(X_i), .Y_i(Y_i), .Z_i(Z_i), .X_O(X_O), .Y_O(Y_O), .Z_O(Z_O));
    
    // 100 MHz clock frequency
    always #5 clk = ~clk;
    
    initial
    begin
        clk = 0;
        reset = 1;
        X_i = 0;
        Y_i = 0;
        Z_i = 0;
        
        #10;
        reset = 0;
        
        // 0.5 / 1.0 = 0.5
        X_i <= 16'sd16384; 
        Y_i <= 16'sd8192;  
        Z_i <= 16'sd0;
        #200;
        
        // 0.25 / 0.5 = -0.5
        X_i <= 16'sd8192;  
        Y_i <= -16'sd4096; 
        Z_i <= 16'sd0;
        #200;
        
        // 0.75 / 1.0 = 0.75
        X_i <= 16'sd16384; 
        Y_i <= 16'sd12288;
        Z_i <= 16'sd0;
        #200;
        
        // 1.0 / 0.5 = 2.0
        X_i <= 16'sd8192;
        Y_i <= 16'sd16384;
        Z_i <= 16'sd0;
        #200;
                
        // 0.4 / 0.8 = 0.5
        X_i <= 16'sd13107;
        Y_i <= 16'sd6554;
        Z_i <= 16'sd1638;
        #200;
                
        // 0.125 / 0.25 = 0.5
        X_i <= 16'sd4096;
        Y_i <= 16'sd2048;
        Z_i <= 16'sd0;
        #200;                                   
        
        $finish;
    end   
    
endmodule
