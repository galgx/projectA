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


module phase1(clk,resetn,enable,x,teta,h);
    parameter DW =8; 
    parameter N =8;
    parameter N_bit = 3;
    input clk;
    input resetn;
    input enable;
    input [DW*N - 1:0] x;
    input [DW*N - 1:0] teta;
    output [DW -1:0] h;

   // `include "dot_product.v";
    wire  [(2*DW)*N -1 : 0] dot_products;
    wire [2*DW + N_bit -1:0] inner_product;
    wire [DW -1:0] z;
    MBGD_DOT_PROD_CALC MBGD_DOT_PROD_CALC(.clk(clk), .resetn(resetn),.enable(enable), .inp1(x), .inp2(teta), .dot_products(dot_products));
    
    MBGD_ADD_CALC MBGD_ADD_CALC (.clk(clk), .resetn(resetn),.enable(enable),.dot_products(dot_products), .outp(inner_product));

    assign z = inner_product[2*DW + N_bit -1:(DW + N_bit)];  //take the 8 MSB 
  
    MBGD_SIGMOID_CALC iMBGD_SIGMOID_CALC (.clk(clk), .resetn(resetn),.enable(enable), .z(z), .h(h));
  
    
endmodule
