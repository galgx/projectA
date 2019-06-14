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


module phase2(clk,resetn,enable,epsilon,x_col,h,y,teta_i_t,teta);
    parameter DW1 = 8; 
    parameter DW2 = 9;
 //   parameter DW_hy = 9;
    parameter N =8;
    parameter N_bit = 3;

    input clk;
    input resetn;
    input enable;
    input wire epsilon;
    input [DW1*N - 1:0] x_col;
    input [DW1*N - 1:0] h;
    input [DW1*N - 1:0] y;
    input [DW1 -1:0] teta_i_t;
    output reg [DW1 - 1:0] teta;
    
   // reg [DW1 - 1:0] g;
    wire [DW1:0] teta_full;

   // `include "dot_product.v";
    wire  [(DW1+DW2)*N -1 : 0] dot_products;
    wire [(DW2)*N -1 :0] sub_out;//9 bits for each number after subtract 
    wire [(DW1+DW2)+N_bit -1:0] inner_product;//20 bit
    wire  [(DW1+DW2)*N -1 : 0] dot_products_phase3;
    MBGD_H_Y_SUBTRACTION MBGD_H_Y_SUBTRACTION(.clk(clk), .resetn(resetn),.enable(enable), .inp1(h), .inp2(y), .sub_out(sub_out));
    MBGD_DOT_PROD_CALC #(.DW1(DW1),.DW2(DW2)) iMBGD_DOT_PROD_CALC(.clk(clk), .resetn(resetn),.enable(enable), .inp1(x_col), .inp2(sub_out), .dot_products(dot_products));
    
    MBGD_ADD_CALC #(.DW1(DW1),.DW2(DW2)) MBGD_ADD_CALC (.clk(clk), .resetn(resetn),.enable(enable),.dot_products(dot_products), .outp(inner_product));

  // assign teta_full =  //teta_i_t - epsilon[DW1 -1:0]*inner_product[(DW1+DW2)+N_bit -1:(DW2) +N_bit]; //*g[DW1-1 :0];
     dot_prod_phase3 dot_prod_phase3(.clk(clk), .resetn(resetn),.enable(enable), .inp1(inner_product[(DW1+DW2)+N_bit -1:(DW2) +N_bit]), .inp2(8'b10), .dot_products(dot_products_phase3));
    
     MBGD_H_Y_SUBTRACTION MBGD_H_Y_SUBTRACTION3(.clk(clk), .resetn(resetn),.enable(enable), .inp2(dot_products_phase3[(DW1+DW1)*(1)- 1 :0] ), .inp1(teta_i_t), .sub_out(teta_full));
    always@(posedge clk or negedge resetn) begin
        if(!resetn)
      teta<= 8'b0;
     else 
      teta <= teta_full[DW1:1];//inner_product[(DW1+DW2)+N_bit -1:(DW2) +N_bit];  //take the 8 MSB 
    end
  // assign teta = teta_full[DW1:1];
  
    
endmodule
