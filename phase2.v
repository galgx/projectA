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
    parameter DW =8; 
 //   parameter DW_hy = 9;
    parameter N =8;
    parameter N_bit = 3;
    input clk;
    input resetn;
    input enable;
    input [DW*N - 1:0] x_col;
    input [DW*N - 1:0] h;
    input [DW*N - 1:0] y;
    output wire [(DW + DW)*N - 1:0] g;

   // `include "dot_product.v";
    wire  [(2*DW)*N -1 : 0] dot_products;
    wire [DW*N -1 :0] reduction; 
    wire [(2*DW)+N_bit -1:0] inner_product;
    
    MBGD_H_Y_REDUCTION MBGD__H_Y_REDUCTION(.clk(clk), .resetn(resetn),.enable(enable), .inp1(h), .inp2(y), .reduction(reduction));
    MBGD_DOT_PROD_CALC MBGD_DOT_PROD_CALC(.clk(clk), .resetn(resetn),.enable(enable), .inp1(x_col), .inp2(reduction), .dot_products(dot_products));
    
    MBGD_ADD_CALC MBGD_ADD_CALC (.clk(clk), .resetn(resetn),.enable(enable),.dot_products(dot_products), .outp(inner_product));

    assign g = inner_product[(2*DW)+N_bit -1:DW +N_bit -1 ];  //take the 8 MSB 
  
  
    
endmodule
