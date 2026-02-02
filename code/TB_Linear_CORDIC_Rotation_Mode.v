`timescale 1ns / 1ps

module tb_linear_cordic_rotation_mode;

    reg clk;
    reg reset;
    reg signed [15:0] X_i, Y_i, Z_i;
    wire signed [15:0] X_O, Y_O, Z_O;
    
    linear_cordic_rotation_mode dut(.clk(clk), .reset(reset), .X_i(X_i), .Y_i(Y_i), .Z_i(Z_i), .X_O(X_O), .Y_O(Y_O), .Z_O(Z_O));
    
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
        
        // (X, Z) = (0.5, 0.25)
        X_i <= 16'sd8192;
        Y_i <= 16'sd0;
        Z_i <= 16'sd4096;
        #200;
        
        // (X, Z) = (0.5, -0.5)
        X_i <= 16'sd8192;
        Y_i <= 16'sd0;
        Z_i <= -16'sd8192;
        #200;
        
        // (X, Z) = (-0.5, 0.25)
        X_i <= -16'sd8192;
        Y_i <= 16'sd0;
        Z_i <= 16'sd4096;
        #200;
        
        // (X, Z) = (-0.5, 0.375)
        X_i <= -16'sd8192;
        Y_i <= 16'sd0;
        Z_i <= 16'sd12288;
        #200;
        
        // Y=0.25+(0.5×0.5)=0.5
        X_i <= 16'sd8192;
        Y_i <= 16'sd4096;
        Z_i <= 16'sd8192;
        #200;
        
        // (X, Z) = (0.5, 0)
        X_i <= 16'sd8192;
        Y_i <= 16'sd0;
        Z_i <= 16'sd0;
        #200;
        
        // (X, Z) = (0.5, ~2^-14)
        X_i <= 16'sd8192;    
        Y_i <= 16'sd0;
        Z_i <= 16'sd1; 
        #200; 
        
        // (X, Z) = (1/root(2), 1/root(2))
        X_i <= 16'sd12000;
        Y_i <= 16'sd0;
        Z_i <= 16'sd12000;
        #200; 
    
        // (X, Z) = (root(2), root(2))
        X_i <= 16'sd23169;
        Y_i <= 16'sd0;
        Z_i <= 16'sd23169;
        #200; 
    
        // (X, Z) = (> root(2), > root(2))
        X_i <= 16'sd23180;
        Y_i <= 16'sd0;
        Z_i <= 16'sd23180;
        #200; 
          
        
        $finish;
    end   
    
endmodule
