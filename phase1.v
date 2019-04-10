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


module phase1(x,teta,h);
    input [63:0] x;
    input [63:0] teta;
    output [7:0] h;
   // `include "dot_product.v";
    
    reg [18:0] inner_product;
    wire [7:0] z;
    dot_product idot_product ( .inp1(x), .inp2(teta), .outp(inner_product));

    assign z = inner_product[63:(63-8)];  
    sigmoid_LUT isigmoid_LUT ( .z(z), .h(h));
   
    
endmodule
