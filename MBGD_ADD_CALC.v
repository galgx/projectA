module MBGD_ADD_CALC
  #(parameter
      N = 8,//the number of the numbers in a row
      N_bit = 3, //the number of bits for 8 100 is 3
      DW = 8 //the number of buts for each number
  )
  (
      input clk,
      input resetn,
      input enable,
      input  wire [(2*DW)*N -1 : 0] dot_products, // intermediate product sums
      output reg[(2*DW) + N_bit - 1 : 0] outp
  );
  
  always @ (posedge clk or  negedge resetn)
  begin
    if(!resetn) begin
         outp = 0;
         end
      
      else if (enable == 1) begin 
            outp =   dot_products[(2*DW)*N -1: (2*DW)*(N-1)] + dot_products[(2*DW)*(N-1)- 1:(2*DW)*(N-2)] + dot_products[(2*DW)*(N-2) -1:(2*DW)*(N-3)] + dot_products[(2*DW)*(N-3) -1:(2*DW)*(N-4)  ] +  dot_products[(2*DW + N_bit)*(N-4)- 1:(2*DW + N_bit)*(N-5) ]  + dot_products[(2*DW + N_bit)*(N-5)- 1:(2*DW + N_bit)*(N-6) ] +   dot_products[(2*DW + N_bit)*(N-6) -1:(2*DW + N_bit)] +  dot_products[(2*DW) - 1 :0];
  
  end
  end
  
endmodule