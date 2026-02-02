`timescale 1ns / 1ps

module vectoring_cordic (clk, reset, X_i, Y_i, Z_i, X_O, Y_O, Z_O);
  
  input clk;
  input reset;

  input  signed [15:0] X_i;
  input  signed [15:0] Y_i;
  input  signed [15:0] Z_i;
  output signed [15:0] X_O;
  output signed [15:0] Y_O;
  output signed [15:0] Z_O;
  

//stage#1  
wire signed [15:0] as_O_asx_w_st1, as_O_asy_w_st1, as_O_asz_w_st1, X_w_st1_st2, Y_w_st1_st2, Z_w_st1_st2;
wire signed [15:0] X_new, Y_new, Z_new;

mux_2to1 mux_x_st1(.in0(X_i), .in1(-X_i), .sel(X_i[15]), .out(X_new));
mux_2to1 mux_y_st1(.in0(Y_i), .in1(-Y_i), .sel(X_i[15]), .out(Y_new));
mux_2to1 mux_z_st1(.in0(Z_i), .in1(Z_i+16'h8000), .sel(X_i[15]), .out(Z_new));

add_sub asx_st1(.as_in1(X_new), .as_in2(Y_new), .as_control(Y_new[15]), .as_out(as_O_asx_w_st1));
reg16b  reg16bxout_st1(.reg_in(as_O_asx_w_st1), .reg_out(X_w_st1_st2), .clk(clk), .reset(reset));

add_sub asy_st1(.as_in1(Y_new), .as_in2(X_new), .as_control(~Y_new[15]), .as_out(as_O_asy_w_st1));
reg16b  reg16byout_st1(.reg_in(as_O_asy_w_st1), .reg_out(Y_w_st1_st2), .clk(clk), .reset(reset));

add_sub asz_st1(.as_in1(Z_new), .as_in2(16'h2000), .as_control(Y_new[15]), .as_out(as_O_asz_w_st1));
reg16b  reg16bzout_st1(.reg_in(as_O_asz_w_st1), .reg_out(Z_w_st1_st2), .clk(clk), .reset(reset));



//stage#2
wire signed [15:0] as_O_asx_w_st2, as_O_asy_w_st2, as_O_asz_w_st2, X_w_st2_st3, Y_w_st2_st3, Z_w_st2_st3;

add_sub asx_st2(.as_in1(X_w_st1_st2), .as_in2(Y_w_st1_st2 >>> 1), .as_control(Y_w_st1_st2[15]), .as_out(as_O_asx_w_st2));
reg16b  reg16bxout_st2(.reg_in(as_O_asx_w_st2), .reg_out(X_w_st2_st3), .clk(clk), .reset(reset));

add_sub asy_st2(.as_in1(Y_w_st1_st2), .as_in2(X_w_st1_st2 >>> 1), .as_control(~Y_w_st1_st2[15]), .as_out(as_O_asy_w_st2));
reg16b  reg16byout_st2(.reg_in(as_O_asy_w_st2), .reg_out(Y_w_st2_st3), .clk(clk), .reset(reset));

add_sub asz_st2(.as_in1(Z_w_st1_st2), .as_in2(16'h12E4), .as_control(Y_w_st1_st2[15]), .as_out(as_O_asz_w_st2));
reg16b  reg16bzout_st2(.reg_in(as_O_asz_w_st2), .reg_out(Z_w_st2_st3), .clk(clk), .reset(reset));



//stage#3
wire signed [15:0] as_O_asx_w_st3, as_O_asy_w_st3, as_O_asz_w_st3, X_w_st3_st4, Y_w_st3_st4, Z_w_st3_st4;

add_sub asx_st3(.as_in1(X_w_st2_st3), .as_in2(Y_w_st2_st3 >>> 2), .as_control(Y_w_st2_st3[15]), .as_out(as_O_asx_w_st3));
reg16b  reg16bxout_st3(.reg_in(as_O_asx_w_st3), .reg_out(X_w_st3_st4), .clk(clk), .reset(reset));

add_sub asy_st3(.as_in1(Y_w_st2_st3), .as_in2(X_w_st2_st3 >>> 2), .as_control(~Y_w_st2_st3[15]), .as_out(as_O_asy_w_st3));
reg16b  reg16byout_st3(.reg_in(as_O_asy_w_st3), .reg_out(Y_w_st3_st4), .clk(clk), .reset(reset));

add_sub asz_st3(.as_in1(Z_w_st2_st3), .as_in2(16'h09FB), .as_control(Y_w_st2_st3[15]), .as_out(as_O_asz_w_st3));
reg16b  reg16bzout_st3(.reg_in(as_O_asz_w_st3), .reg_out(Z_w_st3_st4), .clk(clk), .reset(reset));



//stage#4
wire signed [15:0] as_O_asx_w_st4, as_O_asy_w_st4, as_O_asz_w_st4, X_w_st4_st5, Y_w_st4_st5, Z_w_st4_st5;

add_sub asx_st4(.as_in1(X_w_st3_st4), .as_in2(Y_w_st3_st4 >>> 3), .as_control(Y_w_st3_st4[15]), .as_out(as_O_asx_w_st4));
reg16b  reg16bxout_st4(.reg_in(as_O_asx_w_st4), .reg_out(X_w_st4_st5), .clk(clk), .reset(reset));

add_sub asy_st4(.as_in1(Y_w_st3_st4), .as_in2(X_w_st3_st4 >>> 3), .as_control(~Y_w_st3_st4[15]), .as_out(as_O_asy_w_st4));
reg16b  reg16byout_st4(.reg_in(as_O_asy_w_st4), .reg_out(Y_w_st4_st5), .clk(clk), .reset(reset));

add_sub asz_st4(.as_in1(Z_w_st3_st4), .as_in2(16'h0511), .as_control(Y_w_st3_st4[15]), .as_out(as_O_asz_w_st4));
reg16b  reg16bzout_st4(.reg_in(as_O_asz_w_st4), .reg_out(Z_w_st4_st5), .clk(clk), .reset(reset));



//stage#5
wire signed [15:0] as_O_asx_w_st5, as_O_asy_w_st5, as_O_asz_w_st5, X_w_st5_st6, Y_w_st5_st6, Z_w_st5_st6;

add_sub asx_st5(.as_in1(X_w_st4_st5), .as_in2(Y_w_st4_st5 >>> 4), .as_control(Y_w_st4_st5[15]), .as_out(as_O_asx_w_st5));
reg16b  reg16bxout_st5(.reg_in(as_O_asx_w_st5), .reg_out(X_w_st5_st6), .clk(clk), .reset(reset));

add_sub asy_st5(.as_in1(Y_w_st4_st5), .as_in2(X_w_st4_st5 >>> 4), .as_control(~Y_w_st4_st5[15]), .as_out(as_O_asy_w_st5));
reg16b  reg16byout_st5(.reg_in(as_O_asy_w_st5), .reg_out(Y_w_st5_st6), .clk(clk), .reset(reset));

add_sub asz_st5(.as_in1(Z_w_st4_st5), .as_in2(16'h028B), .as_control(Y_w_st4_st5[15]), .as_out(as_O_asz_w_st5));
reg16b  reg16bzout_st5(.reg_in(as_O_asz_w_st5), .reg_out(Z_w_st5_st6), .clk(clk), .reset(reset));



//stage#6
wire signed [15:0] as_O_asx_w_st6, as_O_asy_w_st6, as_O_asz_w_st6, X_w_st6_st7, Y_w_st6_st7, Z_w_st6_st7;

add_sub asx_st6(.as_in1(X_w_st5_st6), .as_in2(Y_w_st5_st6 >>> 5), .as_control(Y_w_st5_st6[15]), .as_out(as_O_asx_w_st6));
reg16b  reg16bxout_st6(.reg_in(as_O_asx_w_st6), .reg_out(X_w_st6_st7), .clk(clk), .reset(reset));

add_sub asy_st6(.as_in1(Y_w_st5_st6), .as_in2(X_w_st5_st6 >>> 5), .as_control(~Y_w_st5_st6[15]), .as_out(as_O_asy_w_st6));
reg16b  reg16byout_st6(.reg_in(as_O_asy_w_st6), .reg_out(Y_w_st6_st7), .clk(clk), .reset(reset));

add_sub asz_st6(.as_in1(Z_w_st5_st6), .as_in2(16'h0146), .as_control(Y_w_st5_st6[15]), .as_out(as_O_asz_w_st6));
reg16b  reg16bzout_st6(.reg_in(as_O_asz_w_st6), .reg_out(Z_w_st6_st7), .clk(clk), .reset(reset));



//stage#7
wire signed [15:0] as_O_asx_w_st7, as_O_asy_w_st7, as_O_asz_w_st7, X_w_st7_st8, Y_w_st7_st8, Z_w_st7_st8;

add_sub asx_st7(.as_in1(X_w_st6_st7), .as_in2(Y_w_st6_st7 >>> 6), .as_control(Y_w_st6_st7[15]), .as_out(as_O_asx_w_st7));
reg16b  reg16bxout_st7(.reg_in(as_O_asx_w_st7), .reg_out(X_w_st7_st8), .clk(clk), .reset(reset));

add_sub asy_st7(.as_in1(Y_w_st6_st7), .as_in2(X_w_st6_st7 >>> 6), .as_control(~Y_w_st6_st7[15]), .as_out(as_O_asy_w_st7));
reg16b  reg16byout_st7(.reg_in(as_O_asy_w_st7), .reg_out(Y_w_st7_st8), .clk(clk), .reset(reset));

add_sub asz_st7(.as_in1(Z_w_st6_st7), .as_in2(16'h00A3), .as_control(Y_w_st6_st7[15]), .as_out(as_O_asz_w_st7));
reg16b  reg16bzout_st7(.reg_in(as_O_asz_w_st7), .reg_out(Z_w_st7_st8), .clk(clk), .reset(reset));



//stage#8
wire signed [15:0] as_O_asx_w_st8, as_O_asy_w_st8, as_O_asz_w_st8, X_w_st8_st9, Y_w_st8_st9, Z_w_st8_st9;

add_sub asx_st8(.as_in1(X_w_st7_st8), .as_in2(Y_w_st7_st8 >>> 7), .as_control(Y_w_st7_st8[15]), .as_out(as_O_asx_w_st8));
reg16b  reg16bxout_st8(.reg_in(as_O_asx_w_st8), .reg_out(X_w_st8_st9), .clk(clk), .reset(reset));

add_sub asy_st8(.as_in1(Y_w_st7_st8), .as_in2(X_w_st7_st8 >>> 7), .as_control(~Y_w_st7_st8[15]), .as_out(as_O_asy_w_st8));
reg16b  reg16byout_st8(.reg_in(as_O_asy_w_st8), .reg_out(Y_w_st8_st9), .clk(clk), .reset(reset));

add_sub asz_st8(.as_in1(Z_w_st7_st8), .as_in2(16'h0051), .as_control(Y_w_st7_st8[15]), .as_out(as_O_asz_w_st8));
reg16b  reg16bzout_st8(.reg_in(as_O_asz_w_st8), .reg_out(Z_w_st8_st9), .clk(clk), .reset(reset));



//stage#9
wire signed [15:0] as_O_asx_w_st9, as_O_asy_w_st9, as_O_asz_w_st9, X_w_st9_st10, Y_w_st9_st10, Z_w_st9_st10;

add_sub asx_st9(.as_in1(X_w_st8_st9), .as_in2(Y_w_st8_st9 >>> 8), .as_control(Y_w_st8_st9[15]), .as_out(as_O_asx_w_st9));
reg16b  reg16bxout_st9(.reg_in(as_O_asx_w_st9), .reg_out(X_w_st9_st10), .clk(clk), .reset(reset));

add_sub asy_st9(.as_in1(Y_w_st8_st9), .as_in2(X_w_st8_st9 >>> 8), .as_control(~Y_w_st8_st9[15]), .as_out(as_O_asy_w_st9));
reg16b  reg16byout_st9(.reg_in(as_O_asy_w_st9), .reg_out(Y_w_st9_st10), .clk(clk), .reset(reset));

add_sub asz_st9(.as_in1(Z_w_st8_st9), .as_in2(16'h0029), .as_control(Y_w_st8_st9[15]), .as_out(as_O_asz_w_st9));
reg16b  reg16bzout_st9(.reg_in(as_O_asz_w_st9), .reg_out(Z_w_st9_st10), .clk(clk), .reset(reset));



//stage#10
wire signed [15:0] as_O_asx_w_st10, as_O_asy_w_st10, as_O_asz_w_st10, X_w_st10_st11, Y_w_st10_st11, Z_w_st10_st11;

add_sub asx_st10(.as_in1(X_w_st9_st10), .as_in2(Y_w_st9_st10 >>> 9), .as_control(Y_w_st9_st10[15]), .as_out(as_O_asx_w_st10));
reg16b  reg16bxout_st10(.reg_in(as_O_asx_w_st10), .reg_out(X_w_st10_st11), .clk(clk), .reset(reset));

add_sub asy_st10(.as_in1(Y_w_st9_st10), .as_in2(X_w_st9_st10 >>> 9), .as_control(~Y_w_st9_st10[15]), .as_out(as_O_asy_w_st10));
reg16b  reg16byout_st10(.reg_in(as_O_asy_w_st10), .reg_out(Y_w_st10_st11), .clk(clk), .reset(reset));

add_sub asz_st10(.as_in1(Z_w_st9_st10), .as_in2(16'h0014), .as_control(Y_w_st9_st10[15]), .as_out(as_O_asz_w_st10));
reg16b  reg16bzout_st10(.reg_in(as_O_asz_w_st10), .reg_out(Z_w_st10_st11), .clk(clk), .reset(reset));



//stage#11
wire signed [15:0] as_O_asx_w_st11, as_O_asy_w_st11, as_O_asz_w_st11, X_w_st11_st12, Y_w_st11_st12, Z_w_st11_st12;

add_sub asx_st11(.as_in1(X_w_st10_st11), .as_in2(Y_w_st10_st11 >>> 10), .as_control(Y_w_st10_st11[15]), .as_out(as_O_asx_w_st11));
reg16b  reg16bxout_st11(.reg_in(as_O_asx_w_st11), .reg_out(X_w_st11_st12), .clk(clk), .reset(reset));

add_sub asy_st11(.as_in1(Y_w_st10_st11), .as_in2(X_w_st10_st11 >>> 10), .as_control(~Y_w_st10_st11[15]), .as_out(as_O_asy_w_st11));
reg16b  reg16byout_st11(.reg_in(as_O_asy_w_st11), .reg_out(Y_w_st11_st12), .clk(clk), .reset(reset));

add_sub asz_st11(.as_in1(Z_w_st10_st11), .as_in2(16'h000A), .as_control(Y_w_st10_st11[15]), .as_out(as_O_asz_w_st11));
reg16b  reg16bzout_st11(.reg_in(as_O_asz_w_st11), .reg_out(Z_w_st11_st12), .clk(clk), .reset(reset));



//stage#12
wire signed [15:0] as_O_asx_w_st12, as_O_asy_w_st12, as_O_asz_w_st12, X_w_st12_st13, Y_w_st12_st13, Z_w_st12_st13;

add_sub asx_st12(.as_in1(X_w_st11_st12), .as_in2(Y_w_st11_st12 >>> 11), .as_control(Y_w_st11_st12[15]), .as_out(as_O_asx_w_st12));
reg16b  reg16bxout_st12(.reg_in(as_O_asx_w_st12), .reg_out(X_w_st12_st13), .clk(clk), .reset(reset));

add_sub asy_st12(.as_in1(Y_w_st11_st12), .as_in2(X_w_st11_st12 >>> 11), .as_control(~Y_w_st11_st12[15]), .as_out(as_O_asy_w_st12));
reg16b  reg16byout_st12(.reg_in(as_O_asy_w_st12), .reg_out(Y_w_st12_st13), .clk(clk), .reset(reset));

add_sub asz_st12(.as_in1(Z_w_st11_st12), .as_in2(16'h0005), .as_control(Y_w_st11_st12[15]), .as_out(as_O_asz_w_st12));
reg16b  reg16bzout_st12(.reg_in(as_O_asz_w_st12), .reg_out(Z_w_st12_st13), .clk(clk), .reset(reset));



//stage#13
wire signed [15:0] as_O_asx_w_st13, as_O_asy_w_st13, as_O_asz_w_st13, X_w_st13_st14, Y_w_st13_st14, Z_w_st13_st14;

add_sub asx_st13(.as_in1(X_w_st12_st13), .as_in2(Y_w_st12_st13 >>> 12), .as_control(Y_w_st12_st13[15]), .as_out(as_O_asx_w_st13));
reg16b  reg16bxout_st13(.reg_in(as_O_asx_w_st13), .reg_out(X_w_st13_st14), .clk(clk), .reset(reset));

add_sub asy_st13(.as_in1(Y_w_st12_st13), .as_in2(X_w_st12_st13 >>> 12), .as_control(~Y_w_st12_st13[15]), .as_out(as_O_asy_w_st13));
reg16b  reg16byout_st13(.reg_in(as_O_asy_w_st13), .reg_out(Y_w_st13_st14), .clk(clk), .reset(reset));

add_sub asz_st13(.as_in1(Z_w_st12_st13), .as_in2(16'h0003), .as_control(Y_w_st12_st13[15]), .as_out(as_O_asz_w_st13));
reg16b  reg16bzout_st13(.reg_in(as_O_asz_w_st13), .reg_out(Z_w_st13_st14), .clk(clk), .reset(reset));



//stage#14
wire signed [15:0] as_O_asx_w_st14, as_O_asy_w_st14, as_O_asz_w_st14, X_w_st14_st15, Y_w_st14_st15, Z_w_st14_st15;

add_sub asx_st14(.as_in1(X_w_st13_st14), .as_in2(Y_w_st13_st14 >>> 13), .as_control(Y_w_st13_st14[15]), .as_out(as_O_asx_w_st14));
reg16b  reg16bxout_st14(.reg_in(as_O_asx_w_st14), .reg_out(X_w_st14_st15), .clk(clk), .reset(reset));

add_sub asy_st14(.as_in1(Y_w_st13_st14), .as_in2(X_w_st13_st14 >>> 13), .as_control(~Y_w_st13_st14[15]), .as_out(as_O_asy_w_st14));
reg16b  reg16byout_st14(.reg_in(as_O_asy_w_st14), .reg_out(Y_w_st14_st15), .clk(clk), .reset(reset));

add_sub asz_st14(.as_in1(Z_w_st13_st14), .as_in2(16'h0001), .as_control(Y_w_st13_st14[15]), .as_out(as_O_asz_w_st14));
reg16b  reg16bzout_st14(.reg_in(as_O_asz_w_st14), .reg_out(Z_w_st14_st15), .clk(clk), .reset(reset));



//stage#15
wire signed [15:0] as_O_asx_w_st15, as_O_asy_w_st15, as_O_asz_w_st15, X_w_st15_st16, Y_w_st15_st16, Z_w_st15_st16;

add_sub asx_st15(.as_in1(X_w_st14_st15), .as_in2(Y_w_st14_st15 >>> 14), .as_control(Y_w_st14_st15[15]), .as_out(as_O_asx_w_st15));
reg16b  reg16bxout_st15(.reg_in(as_O_asx_w_st15), .reg_out(X_w_st15_st16), .clk(clk), .reset(reset));

add_sub asy_st15(.as_in1(Y_w_st14_st15), .as_in2(X_w_st14_st15 >>> 14), .as_control(~Y_w_st14_st15[15]), .as_out(as_O_asy_w_st15));
reg16b  reg16byout_st15(.reg_in(as_O_asy_w_st15), .reg_out(Y_w_st15_st16), .clk(clk), .reset(reset));

add_sub asz_st15(.as_in1(Z_w_st14_st15), .as_in2(16'h0001), .as_control(Y_w_st14_st15[15]), .as_out(as_O_asz_w_st15));
reg16b  reg16bzout_st15(.reg_in(as_O_asz_w_st15), .reg_out(Z_w_st15_st16), .clk(clk), .reset(reset));



//stage#16
wire signed [15:0] as_O_asx_w_st16, as_O_asy_w_st16, as_O_asz_w_st16, X_w_st16_st17, Y_w_st16_st17, Z_w_st16_st17;

add_sub asx_st16(.as_in1(X_w_st15_st16), .as_in2(Y_w_st15_st16 >>> 15), .as_control(Y_w_st15_st16[15]), .as_out(as_O_asx_w_st16));
reg16b  reg16bxout_st16(.reg_in(as_O_asx_w_st16), .reg_out(X_O), .clk(clk), .reset(reset));

add_sub asy_st16(.as_in1(Y_w_st15_st16), .as_in2(X_w_st15_st16 >>> 15), .as_control(~Y_w_st15_st16[15]), .as_out(as_O_asy_w_st16));
reg16b  reg16byout_st16(.reg_in(as_O_asy_w_st16), .reg_out(Y_O), .clk(clk), .reset(reset));

add_sub asz_st16(.as_in1(Z_w_st15_st16), .as_in2(16'h0000), .as_control(Y_w_st15_st16[15]), .as_out(as_O_asz_w_st16));
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




module mux_2to1(in0, in1, sel, out);

input signed [15:0] in0, in1;
input sel;
output reg signed [15:0] out;

always @(*)
begin
    if(sel)
        out = in1;
    else
        out = in0;
end
    
endmodule




module dff(in, out, clk, reset);

input in, clk, reset;
output reg out;

always @(posedge clk)
    begin
        if(reset)
            out <= 0;
        else
            out <= in;
    end

endmodule
