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


module phase1(clk,reset,enable,x,teta,h);
    input clk;
    input reset;
    input enable;
    input [63:0] x;
    input [63:0] teta;
    output [7:0] h;
    parameter DW =8; 
    parameter N =8;
    parameter N_bit = 3;
   // `include "dot_product.v";
    wire [2*DW + N_bit - 1 : 0] [0 : N - 1] dot_products;
    wire [18:0] inner_product;
    wire [7:0] z;
    dot_products MBGD_DOT_PROD_CALC(.clk(clk), .reset(reset),.enable(enable), .inp1(x), .inp2(teta), .dot_products(dot_products));
    
    dot_product MBGD_ADD_CALC (.clk(clk), .reset(reset),.enable(enable),.dot_products(dot_products), .outp(inner_product));

    assign z = inner_product[18:(18-8)];  //take the 8 MSB 
  
    sigmoid_LUT isigmoid_LUT (.clk(clk), .reset(reset),.enable(enable), .z(z), .h(h));
  
    
endmodule
