module MBGD_ADD_CALC
  #(parameter
      N = 8,//the number of the numbers in a row
      N_bit = 3, //the number of bits for 8 100 is 3
      DW = 8 //the number of buts for each number
  )
  (
      input clk,
      input reset,
      input enable,
      input wire [2*DW + N_bit - 1 : 0] [0 : N - 1] dot_products, // intermediate product sums
      output reg[(2*DW) + N_bit - 1 : 0] outp
  );
  
   always @ (posedge clk)
  begin
    if(reset == 1) begin
         outp = 0;
         end
      
      else if (enable == 1) begin 
            outp = dot_products[0] + dot_products[1] + dot_products[2] + dot_products[3] + dot_products[4] + dot_products[5] + dot_products[7];
  
  end
  end
  
endmodule