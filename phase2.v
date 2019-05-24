`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2019 04:58:36 PM
// Design Name: 
// Module Name: h
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module phase2(clk,resetn,enable,x_col,h,y,g);
    parameter DW1 = 8; 
    parameter DW2 = 9;
 //   parameter DW_hy = 9;
    parameter N =8;
    parameter N_bit = 3;
    input clk;
    input resetn;
    input enable;
    input [DW1*N - 1:0] x_col;
    input [DW1*N - 1:0] h;
    input [DW1*N - 1:0] y;
    output wire [DW1 - 1:0] g;

   // `include "dot_product.v";
    wire  [(DW1+DW2)*N -1 : 0] dot_products;
    wire [(DW2)*N -1 :0] sub_out;//9 bits for each number after subtract 
    wire [(DW1+DW2)+N_bit -1:0] inner_product;//20 bit
    
    MBGD_H_Y_SUBTRACTION MBGD__H_Y_SUBTRACTION(.clk(clk), .resetn(resetn),.enable(enable), .inp1(h), .inp2(y), .sub_out(sub_out));
    MBGD_DOT_PROD_CALC #(.DW1(DW1),.DW2(DW2)) iMBGD_DOT_PROD_CALC(.clk(clk), .resetn(resetn),.enable(enable), .inp1(x_col), .inp2(sub_out), .dot_products(dot_products));
    
    MBGD_ADD_CALC #(.DW1(DW1),.DW2(DW2)) MBGD_ADD_CALC (.clk(clk), .resetn(resetn),.enable(enable),.dot_products(dot_products), .outp(inner_product));
   
    assign g = inner_product[(DW1+DW2)+N_bit -1:(DW2) +N_bit -1 ];  //take the 8 MSB 
  
  
    
endmodule
