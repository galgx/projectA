module MBGD_DOT_PROD_CALC
  #(parameter
      N = 8,//the number of the numbers in a row
      N_bit = 3, //the number of bits for 8 100 is 3
      DW = 8 //the number of buts for each number
  )
  (
      input clk,
      input reset,
      input enable,
      input wire[(DW * N) -1 : 0] inp1,
      input wire[(DW * N) -1 : 0] inp2,
      output reg [2*DW + N_bit - 1 : 0] [0 : N - 1] dot_products  // intermediate product sums
  );

  
  //assign sums[0] = (inp1[DW - 1 : 0] * inp2[DW - 1 : 0]);
  always @ (posedge clk)
  begin
    if(reset == 1) begin
        for (integer i = 0; i < N; i = i + 1) begin
             dot_products[i] = 0;
         end
      end 
      else if (enable == 1) begin 
        dot_products[0] = (inp1[DW - 1 : 0] * inp2[DW - 1 : 0]);;
        dot_products[1] = inp1[ (1 + 1) * DW - 1 : 1 * DW ] * inp2[ (1 + 1) * DW - 1 : 1 * DW ];
        dot_products[2] = inp1[ (2 + 1) * DW - 1 : 2 * DW ] * inp2[ (2 + 1) * DW - 1 : 2 * DW ];
        dot_products[3] = inp1[ (3 + 1) * DW - 1 : 3 * DW ] * inp2[ (3 + 1) * DW - 1 : 3 * DW ];
        dot_products[4] = inp1[ (4 + 1) * DW - 1 : 4 * DW ] * inp2[ (4 + 1) * DW - 1 : 4 * DW ];
        dot_products[5] = inp1[ (5 + 1) * DW - 1 : 5 * DW ] * inp2[ (5 + 1) * DW - 1 : 5 * DW ];
        dot_products[6] = inp1[ (6 + 1) * DW - 1 : 6 * DW ] * inp2[ (6 + 1) * DW - 1 : 6 * DW ];
        dot_products[7] = inp1[ (7 + 1) * DW - 1 : 7 * DW ] * inp2[ (7 + 1) * DW - 1 : 7 * DW ];
     end
   end



endmodule