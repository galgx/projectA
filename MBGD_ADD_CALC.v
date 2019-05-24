`timescale 1ns/1ps
module MBGD_ADD_CALC
  #(parameter
      N = 8,//the number of the numbers in a roDW
      N_bit = 3, //the number of bits for 8 100 is 3
      DW1 = 8, //the data width of bits for each number
      DW2 =8  
  )
  (
      input clk,
      input resetn,
      input enable,
      input  wire [(DW1+DW2)*N -1 : 0] dot_products, // intermediate product sums
      output reg[(DW1+DW2) + N_bit - 1 : 0] outp
  );
  
  always @ (posedge clk or  negedge resetn)
  begin
    if(!resetn) begin
         outp <=  0;
         end
      
      else if (enable == 1) begin
            #22 
            outp <=  dot_products[(DW1+DW2)*N -1: (DW1+DW2)*(N-1)] + dot_products[(DW1+DW2)*(N-1)- 1:(DW1+DW2)*(N-2)] + dot_products[(DW1+DW2)*(N-2) -1:(DW1+DW2)*(N-3)] + dot_products[(DW1+DW2)*(N-3) -1:(DW1+DW2)*(N-4)  ] +  dot_products[(DW1+DW2)*(N-4)- 1:(DW1+DW2)*(N-5) ]  + dot_products[(DW1+DW2)*(N-5)- 1:(DW1+DW2)*(N-6) ] +   dot_products[(DW1+DW2)*(N-6) -1:(DW1+DW2)] +  dot_products[(DW1+DW2) - 1 :0];
  
  end
  end
  
endmodule