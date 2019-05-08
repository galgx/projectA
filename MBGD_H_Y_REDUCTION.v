module MBGD_H_Y_REDUCTION

#(parameter
      N = 8,//the number of the numbers in a row
      N_bit = 3, //the number of bits for 8 100 is 3
      DW = 8 //the number of buts for each number
  )
  (
      input clk,
      input resetn,
      input enable,
      input wire[(DW * N) -1 : 0] inp1,
      input wire[(DW * N) -1 : 0] inp2,
      output reg[(DW * N) -1: 0] reduction  // intermediate product sums ,128 bits
  );
  
    always @ (posedge clk or  negedge resetn)
  begin
    if(!resetn) begin
    
    reduction = 64'b0;

     end
      
      else if (enable == 1) begin 
        reduction[(DW)*(1)- 1 :0]  = (inp1[DW - 1 : 0] - inp2[DW - 1 : 0]);;
        reduction[(DW)*(N-6)-1:(DW)] = inp1[ (1 + 1) * DW - 1 : 1 * DW ] - inp2[ (1 + 1) * DW - 1 : 1 * DW ];
        reduction[(DW)*(N-5)-1:(DW)*(N-6)] = inp1[ (2 + 1) * DW - 1 : 2 * DW ] - inp2[ (2 + 1) * DW - 1 : 2 * DW ];
        reduction[(DW)*(N-4)-1:(DW)*(N-5)] = inp1[ (3 + 1) * DW - 1 : 3 * DW ] - inp2[ (3 + 1) * DW - 1 : 3 * DW ];
        reduction[(DW)*(N-3)-1:(DW)*(N-4)] = inp1[ (4 + 1) * DW - 1 : 4 * DW ] - inp2[ (4 + 1) * DW - 1 : 4 * DW ];
        reduction[(DW)*(N-2)-1:(DW)*(N-3)] = inp1[ (5 + 1) * DW - 1 : 5 * DW ] - inp2[ (5 + 1) * DW - 1 : 5 * DW ];
        reduction[(DW)*(N-1)-1:(DW)*(N-2)] = inp1[ (6 + 1) * DW - 1 : 6 * DW ] - inp2[ (6 + 1) * DW - 1 : 6 * DW ];
        reduction[(DW)*(N-0)-1:(DW)*(N-1)] = inp1[ (7 + 1) * DW - 1 : 7 * DW ] - inp2[ (7 + 1) * DW - 1 : 7 * DW ];
     end
   end



endmodule
