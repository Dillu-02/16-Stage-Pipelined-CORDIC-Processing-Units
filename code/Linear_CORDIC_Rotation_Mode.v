`timescale 1ns / 1ps

module linear_cordic_rotation_mode (clk, reset, X_i, Y_i, Z_i, X_O, Y_O, Z_O);
  
  input clk;
  input reset;

  input  signed [15:0] X_i;
  input  signed [15:0] Y_i;
  input  signed [15:0] Z_i;
  output signed [15:0] X_O;
  output signed [15:0] Y_O;
  output signed [15:0] Z_O;
  
  localparam signed [15:0] ONE_Q14 = 16'sd16384; // 1.0 in Q1.14 (1 sign bit + 1 integer bit + 14 fractional bits)

//stage#1  
wire signed [15:0] as_O_asy_w_st1, as_O_asz_w_st1; 
wire signed [15:0] X_w_st1_st2, Y_w_st1_st2, Z_w_st1_st2;

reg16b  reg16bxout_st1(.reg_in(X_i), .reg_out(X_w_st1_st2), .clk(clk), .reset(reset));

add_sub asy_st1(.as_in1(Y_i), .as_in2(X_i), .as_control(Z_i[15]), .as_out(as_O_asy_w_st1));
reg16b  reg16byout_st1(.reg_in(as_O_asy_w_st1), .reg_out(Y_w_st1_st2), .clk(clk), .reset(reset));

add_sub asz_st1(.as_in1(Z_i), .as_in2(ONE_Q14), .as_control(~(Z_i[15])), .as_out(as_O_asz_w_st1));
reg16b  reg16bzout_st1(.reg_in(as_O_asz_w_st1), .reg_out(Z_w_st1_st2), .clk(clk), .reset(reset));




//stage#2
wire signed [15:0] as_O_asx_w_st2, as_O_asy_w_st2, as_O_asz_w_st2, X_w_st2_st3, Y_w_st2_st3, Z_w_st2_st3;

reg16b  reg16bxout_st2(.reg_in(X_w_st1_st2), .reg_out(X_w_st2_st3), .clk(clk), .reset(reset));

add_sub asy_st2(.as_in1(Y_w_st1_st2), .as_in2(X_w_st1_st2 >>> 1), .as_control(Z_w_st1_st2[15]), .as_out(as_O_asy_w_st2));
reg16b  reg16byout_st2(.reg_in(as_O_asy_w_st2), .reg_out(Y_w_st2_st3), .clk(clk), .reset(reset));

add_sub asz_st2(.as_in1(Z_w_st1_st2), .as_in2(ONE_Q14 >>> 1), .as_control(~(Z_w_st1_st2[15])), .as_out(as_O_asz_w_st2));
reg16b  reg16bzout_st2(.reg_in(as_O_asz_w_st2), .reg_out(Z_w_st2_st3), .clk(clk), .reset(reset));



//stage#3
wire signed [15:0] as_O_asx_w_st3, as_O_asy_w_st3, as_O_asz_w_st3, X_w_st3_st4, Y_w_st3_st4, Z_w_st3_st4;

reg16b  reg16bxout_st3(.reg_in(X_w_st2_st3), .reg_out(X_w_st3_st4), .clk(clk), .reset(reset));

add_sub asy_st3(.as_in1(Y_w_st2_st3), .as_in2(X_w_st2_st3 >>> 2), .as_control(Z_w_st2_st3[15]), .as_out(as_O_asy_w_st3));
reg16b  reg16byout_st3(.reg_in(as_O_asy_w_st3), .reg_out(Y_w_st3_st4), .clk(clk), .reset(reset));

add_sub asz_st3(.as_in1(Z_w_st2_st3), .as_in2(ONE_Q14 >>> 2), .as_control(~(Z_w_st2_st3[15])), .as_out(as_O_asz_w_st3));
reg16b  reg16bzout_st3(.reg_in(as_O_asz_w_st3), .reg_out(Z_w_st3_st4), .clk(clk), .reset(reset));



//stage#4
wire signed [15:0] as_O_asx_w_st4, as_O_asy_w_st4, as_O_asz_w_st4, X_w_st4_st5, Y_w_st4_st5, Z_w_st4_st5;

reg16b  reg16bxout_st4(.reg_in(X_w_st3_st4), .reg_out(X_w_st4_st5), .clk(clk), .reset(reset));

add_sub asy_st4(.as_in1(Y_w_st3_st4), .as_in2(X_w_st3_st4 >>> 3), .as_control(Z_w_st3_st4[15]), .as_out(as_O_asy_w_st4));
reg16b  reg16byout_st4(.reg_in(as_O_asy_w_st4), .reg_out(Y_w_st4_st5), .clk(clk), .reset(reset));

add_sub asz_st4(.as_in1(Z_w_st3_st4), .as_in2(ONE_Q14 >>> 3), .as_control(~(Z_w_st3_st4[15])), .as_out(as_O_asz_w_st4));
reg16b  reg16bzout_st4(.reg_in(as_O_asz_w_st4), .reg_out(Z_w_st4_st5), .clk(clk), .reset(reset));



//stage#5
wire signed [15:0] as_O_asx_w_st5, as_O_asy_w_st5, as_O_asz_w_st5, X_w_st5_st6, Y_w_st5_st6, Z_w_st5_st6;

reg16b  reg16bxout_st5(.reg_in(X_w_st4_st5), .reg_out(X_w_st5_st6), .clk(clk), .reset(reset));

add_sub asy_st5(.as_in1(Y_w_st4_st5), .as_in2(X_w_st4_st5 >>> 4), .as_control(Z_w_st4_st5[15]), .as_out(as_O_asy_w_st5));
reg16b  reg16byout_st5(.reg_in(as_O_asy_w_st5), .reg_out(Y_w_st5_st6), .clk(clk), .reset(reset));

add_sub asz_st5(.as_in1(Z_w_st4_st5), .as_in2(ONE_Q14 >>> 4), .as_control(~(Z_w_st4_st5[15])), .as_out(as_O_asz_w_st5));
reg16b  reg16bzout_st5(.reg_in(as_O_asz_w_st5), .reg_out(Z_w_st5_st6), .clk(clk), .reset(reset));



//stage#6
wire signed [15:0] as_O_asx_w_st6, as_O_asy_w_st6, as_O_asz_w_st6, X_w_st6_st7, Y_w_st6_st7, Z_w_st6_st7;

reg16b  reg16bxout_st6(.reg_in(X_w_st5_st6), .reg_out(X_w_st6_st7), .clk(clk), .reset(reset));

add_sub asy_st6(.as_in1(Y_w_st5_st6), .as_in2(X_w_st5_st6 >>> 5), .as_control(Z_w_st5_st6[15]), .as_out(as_O_asy_w_st6));
reg16b  reg16byout_st6(.reg_in(as_O_asy_w_st6), .reg_out(Y_w_st6_st7), .clk(clk), .reset(reset));

add_sub asz_st6(.as_in1(Z_w_st5_st6), .as_in2(ONE_Q14 >>> 5), .as_control(~(Z_w_st5_st6[15])), .as_out(as_O_asz_w_st6));
reg16b  reg16bzout_st6(.reg_in(as_O_asz_w_st6), .reg_out(Z_w_st6_st7), .clk(clk), .reset(reset));



//stage#7
wire signed [15:0] as_O_asx_w_st7, as_O_asy_w_st7, as_O_asz_w_st7, X_w_st7_st8, Y_w_st7_st8, Z_w_st7_st8;

reg16b  reg16bxout_st7(.reg_in(X_w_st6_st7), .reg_out(X_w_st7_st8), .clk(clk), .reset(reset));

add_sub asy_st7(.as_in1(Y_w_st6_st7), .as_in2(X_w_st6_st7 >>> 6), .as_control(Z_w_st6_st7[15]), .as_out(as_O_asy_w_st7));
reg16b  reg16byout_st7(.reg_in(as_O_asy_w_st7), .reg_out(Y_w_st7_st8), .clk(clk), .reset(reset));

add_sub asz_st7(.as_in1(Z_w_st6_st7), .as_in2(ONE_Q14 >>> 6), .as_control(~(Z_w_st6_st7[15])), .as_out(as_O_asz_w_st7));
reg16b  reg16bzout_st7(.reg_in(as_O_asz_w_st7), .reg_out(Z_w_st7_st8), .clk(clk), .reset(reset));



//stage#8
wire signed [15:0] as_O_asx_w_st8, as_O_asy_w_st8, as_O_asz_w_st8, X_w_st8_st9, Y_w_st8_st9, Z_w_st8_st9;

reg16b  reg16bxout_st8(.reg_in(X_w_st7_st8), .reg_out(X_w_st8_st9), .clk(clk), .reset(reset));

add_sub asy_st8(.as_in1(Y_w_st7_st8), .as_in2(X_w_st7_st8 >>> 7), .as_control(Z_w_st7_st8[15]), .as_out(as_O_asy_w_st8));
reg16b  reg16byout_st8(.reg_in(as_O_asy_w_st8), .reg_out(Y_w_st8_st9), .clk(clk), .reset(reset));

add_sub asz_st8(.as_in1(Z_w_st7_st8), .as_in2(ONE_Q14 >>> 7), .as_control(~(Z_w_st7_st8[15])), .as_out(as_O_asz_w_st8));
reg16b  reg16bzout_st8(.reg_in(as_O_asz_w_st8), .reg_out(Z_w_st8_st9), .clk(clk), .reset(reset));



//stage#9
wire signed [15:0] as_O_asx_w_st9, as_O_asy_w_st9, as_O_asz_w_st9, X_w_st9_st10, Y_w_st9_st10, Z_w_st9_st10;

reg16b  reg16bxout_st9(.reg_in(X_w_st8_st9), .reg_out(X_w_st9_st10), .clk(clk), .reset(reset));

add_sub asy_st9(.as_in1(Y_w_st8_st9), .as_in2(X_w_st8_st9 >>> 8), .as_control(Z_w_st8_st9[15]), .as_out(as_O_asy_w_st9));
reg16b  reg16byout_st9(.reg_in(as_O_asy_w_st9), .reg_out(Y_w_st9_st10), .clk(clk), .reset(reset));

add_sub asz_st9(.as_in1(Z_w_st8_st9), .as_in2(ONE_Q14 >>> 8), .as_control(~(Z_w_st8_st9[15])), .as_out(as_O_asz_w_st9));
reg16b  reg16bzout_st9(.reg_in(as_O_asz_w_st9), .reg_out(Z_w_st9_st10), .clk(clk), .reset(reset));



//stage#10
wire signed [15:0] as_O_asx_w_st10, as_O_asy_w_st10, as_O_asz_w_st10, X_w_st10_st11, Y_w_st10_st11, Z_w_st10_st11;

reg16b  reg16bxout_st10(.reg_in(X_w_st9_st10), .reg_out(X_w_st10_st11), .clk(clk), .reset(reset));

add_sub asy_st10(.as_in1(Y_w_st9_st10), .as_in2(X_w_st9_st10 >>> 9), .as_control(Z_w_st9_st10[15]), .as_out(as_O_asy_w_st10));
reg16b  reg16byout_st10(.reg_in(as_O_asy_w_st10), .reg_out(Y_w_st10_st11), .clk(clk), .reset(reset));

add_sub asz_st10(.as_in1(Z_w_st9_st10), .as_in2(ONE_Q14 >>> 9), .as_control(~(Z_w_st9_st10[15])), .as_out(as_O_asz_w_st10));
reg16b  reg16bzout_st10(.reg_in(as_O_asz_w_st10), .reg_out(Z_w_st10_st11), .clk(clk), .reset(reset));



//stage#11
wire signed [15:0] as_O_asx_w_st11, as_O_asy_w_st11, as_O_asz_w_st11, X_w_st11_st12, Y_w_st11_st12, Z_w_st11_st12;

reg16b  reg16bxout_st11(.reg_in(X_w_st10_st11), .reg_out(X_w_st11_st12), .clk(clk), .reset(reset));

add_sub asy_st11(.as_in1(Y_w_st10_st11), .as_in2(X_w_st10_st11 >>> 10), .as_control(Z_w_st10_st11[15]), .as_out(as_O_asy_w_st11));
reg16b  reg16byout_st11(.reg_in(as_O_asy_w_st11), .reg_out(Y_w_st11_st12), .clk(clk), .reset(reset));

add_sub asz_st11(.as_in1(Z_w_st10_st11), .as_in2(ONE_Q14 >>> 10), .as_control(~(Z_w_st10_st11[15])), .as_out(as_O_asz_w_st11));
reg16b  reg16bzout_st11(.reg_in(as_O_asz_w_st11), .reg_out(Z_w_st11_st12), .clk(clk), .reset(reset));



//stage#12
wire signed [15:0] as_O_asx_w_st12, as_O_asy_w_st12, as_O_asz_w_st12, X_w_st12_st13, Y_w_st12_st13, Z_w_st12_st13;

reg16b  reg16bxout_st12(.reg_in(X_w_st11_st12), .reg_out(X_w_st12_st13), .clk(clk), .reset(reset));

add_sub asy_st12(.as_in1(Y_w_st11_st12), .as_in2(X_w_st11_st12 >>> 11), .as_control(Z_w_st11_st12[15]), .as_out(as_O_asy_w_st12));
reg16b  reg16byout_st12(.reg_in(as_O_asy_w_st12), .reg_out(Y_w_st12_st13), .clk(clk), .reset(reset));

add_sub asz_st12(.as_in1(Z_w_st11_st12), .as_in2(ONE_Q14 >>> 11), .as_control(~(Z_w_st11_st12[15])), .as_out(as_O_asz_w_st12));
reg16b  reg16bzout_st12(.reg_in(as_O_asz_w_st12), .reg_out(Z_w_st12_st13), .clk(clk), .reset(reset));



//stage#13
wire signed [15:0] as_O_asx_w_st13, as_O_asy_w_st13, as_O_asz_w_st13, X_w_st13_st14, Y_w_st13_st14, Z_w_st13_st14;

reg16b  reg16bxout_st13(.reg_in(X_w_st12_st13), .reg_out(X_w_st13_st14), .clk(clk), .reset(reset));

add_sub asy_st13(.as_in1(Y_w_st12_st13), .as_in2(X_w_st12_st13 >>> 12), .as_control(Z_w_st12_st13[15]), .as_out(as_O_asy_w_st13));
reg16b  reg16byout_st13(.reg_in(as_O_asy_w_st13), .reg_out(Y_w_st13_st14), .clk(clk), .reset(reset));

add_sub asz_st13(.as_in1(Z_w_st12_st13), .as_in2(ONE_Q14 >>> 12), .as_control(~(Z_w_st12_st13[15])), .as_out(as_O_asz_w_st13));
reg16b  reg16bzout_st13(.reg_in(as_O_asz_w_st13), .reg_out(Z_w_st13_st14), .clk(clk), .reset(reset));



//stage#14
wire signed [15:0] as_O_asx_w_st14, as_O_asy_w_st14, as_O_asz_w_st14, X_w_st14_st15, Y_w_st14_st15, Z_w_st14_st15;

reg16b  reg16bxout_st14(.reg_in(X_w_st13_st14), .reg_out(X_w_st14_st15), .clk(clk), .reset(reset));

add_sub asy_st14(.as_in1(Y_w_st13_st14), .as_in2(X_w_st13_st14 >>> 13), .as_control(Z_w_st13_st14[15]), .as_out(as_O_asy_w_st14));
reg16b  reg16byout_st14(.reg_in(as_O_asy_w_st14), .reg_out(Y_w_st14_st15), .clk(clk), .reset(reset));

add_sub asz_st14(.as_in1(Z_w_st13_st14), .as_in2(ONE_Q14 >>> 13), .as_control(~(Z_w_st13_st14[15])), .as_out(as_O_asz_w_st14));
reg16b  reg16bzout_st14(.reg_in(as_O_asz_w_st14), .reg_out(Z_w_st14_st15), .clk(clk), .reset(reset));



//stage#15
wire signed [15:0] as_O_asx_w_st15, as_O_asy_w_st15, as_O_asz_w_st15, X_w_st15_st16, Y_w_st15_st16, Z_w_st15_st16;

reg16b  reg16bxout_st15(.reg_in(X_w_st14_st15), .reg_out(X_w_st15_st16), .clk(clk), .reset(reset));

add_sub asy_st15(.as_in1(Y_w_st14_st15), .as_in2(X_w_st14_st15 >>> 14), .as_control(Z_w_st14_st15[15]), .as_out(as_O_asy_w_st15));
reg16b  reg16byout_st15(.reg_in(as_O_asy_w_st15), .reg_out(Y_w_st15_st16), .clk(clk), .reset(reset));

add_sub asz_st15(.as_in1(Z_w_st14_st15), .as_in2(ONE_Q14 >>> 14), .as_control(~(Z_w_st14_st15[15])), .as_out(as_O_asz_w_st15));
reg16b  reg16bzout_st15(.reg_in(as_O_asz_w_st15), .reg_out(Z_w_st15_st16), .clk(clk), .reset(reset));



//stage#16
wire signed [15:0] as_O_asx_w_st16, as_O_asy_w_st16, as_O_asz_w_st16, X_w_st16_st17, Y_w_st16_st17, Z_w_st16_st17;

reg16b  reg16bxout_st16(.reg_in(X_w_st15_st16), .reg_out(X_O), .clk(clk), .reset(reset));

add_sub asy_st16(.as_in1(Y_w_st15_st16), .as_in2(X_w_st15_st16 >>> 15), .as_control(Z_w_st15_st16[15]), .as_out(as_O_asy_w_st16));
reg16b  reg16byout_st16(.reg_in(as_O_asy_w_st16), .reg_out(Y_O), .clk(clk), .reset(reset));

add_sub asz_st16(.as_in1(Z_w_st15_st16), .as_in2(ONE_Q14 >>> 15), .as_control(~(Z_w_st15_st16[15])), .as_out(as_O_asz_w_st16));
reg16b  reg16bzout_st16(.reg_in(as_O_asz_w_st16), .reg_out(Z_O), .clk(clk), .reset(reset));


endmodule




module reg16b(reg_in, reg_out, clk, reset);
input clk, reset;
input signed [15:0] reg_in;
output reg signed [15:0] reg_out;

always @(posedge clk)
begin
    if (reset)
      reg_out <= 16'sd0;
    else
      reg_out <= reg_in;     
end
endmodule  




module add_sub(as_in1, as_in2,as_control, as_out);
input signed [15:0] as_in1, as_in2;
input as_control;
output reg signed [15:0] as_out;

always @(*)
begin
  if (as_control)
    as_out = as_in1 - as_in2;
  else
    as_out = as_in1 + as_in2;
end
endmodule

