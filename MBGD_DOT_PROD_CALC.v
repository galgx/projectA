`timescale 1ns/1ps
module MBGD_DOT_PROD_CALC
  #(parameter
      N = 8,//the number of the numbers in a roDW
      N_bit = 3, //the number of bits for 8 100 is 3
      DW1 = 8,//the Data Width of each number in bits for the inp1
      DW2 = 8 //the Data Width of each number in bits for inp2
  )
  (
      input clk,
      input resetn,
      input enable,
      input wire[(DW1 * N) -1 : 0] inp1,
      input wire[(DW2 * N) -1 : 0] inp2,
      output reg [(DW1+DW2)*N -1: 0]dot_products  // intermediate product sums ,128 bits
  );

  
  //assign sums[0] = (inp1[DDW - 1 : 0] * inp2[DDW - 1 : 0]);
  always @ (posedge clk or  negedge resetn)
  begin
    if(!resetn) begin
    
    dot_products <= 0;

     end
      
      else if (enable == 1) begin 
        #12      
        dot_products[(DW1+DW2)*(1)- 1 :0]  <=  (inp1[DW1 - 1 : 0] * inp2[DW2 - 1 : 0]);;
        dot_products[(DW1+DW2)*(N-6)-1:(DW1+DW2)] <=  inp1[ (1 + 1) * DW1 - 1 : 1 * DW1 ] * inp2[ (1 + 1) * DW2 - 1 : 1 * DW2 ];
        dot_products[(DW1+DW2)*(N-5)-1:(DW1+DW2)*(N-6)] <=  inp1[ (2 + 1) * DW1 - 1 : 2 * DW1 ] * inp2[ (2 + 1) * DW2 - 1 : 2 * DW2 ];
        dot_products[(DW1+DW2)*(N-4)-1:(DW1+DW2)*(N-5)] <=  inp1[ (3 + 1) * DW1 - 1 : 3 * DW1 ] * inp2[ (3 + 1) * DW2 - 1 : 3 * DW2 ];
        dot_products[(DW1+DW2)*(N-3)-1:(DW1+DW2)*(N-4)] <=  inp1[ (4 + 1) * DW1 - 1 : 4 * DW1 ] * inp2[ (4 + 1) * DW2 - 1 : 4 * DW2 ];
        dot_products[(DW1+DW2)*(N-2)-1:(DW1+DW2)*(N-3)] <=  inp1[ (5 + 1) * DW1 - 1 : 5 * DW1 ] * inp2[ (5 + 1) * DW2 - 1 : 5 * DW2 ];
        dot_products[(DW1+DW2)*(N-1)-1:(DW1+DW2)*(N-2)] <=  inp1[ (6 + 1) * DW1 - 1 : 6 * DW1 ] * inp2[ (6 + 1) * DW2 - 1 : 6 * DW2 ];
        dot_products[(DW1+DW2)*(N-0)-1:(DW1+DW2)*(N-1)] <=  inp1[ (7 + 1) * DW1 - 1 : 7 * DW1 ] * inp2[ (7 + 1) * DW2 - 1 : 7 * DW2 ];
     end
   end



endmodule