// Verilog testbench

`timescale 1ps/1ps
`define DATA_WIDTH 8
`define NUM_ELEMS  8
`define N_BIT  3
module inner_product_tb ();

	// note this only runs for 50 cycles with the below settings
	// alter TB_TIMEOUT to run longer
	localparam TB_TIMEOUT    = 100000;
	localparam TB_CLK_PERIOD = 2000;
	localparam TB_RST_PERIOD = 4000;

	initial begin
	
	#10
	//00000010 00000100 2,4
	
	num1= 64'b0000001000000100;
	num2= 64'b0000001000000100;
		
	
	
	//num1= 64'b000000101;
	//num2 = 64'b01010101;
	
	
	
	
	end

	// clock
	reg tb_clk = 1'b0;
	always #(TB_CLK_PERIOD/2) tb_clk = ~tb_clk;


	// DUT
	//wire [(2*`DATA_WIDTH + `N_BIT) - 1  : 0] outp;
	wire [7:0] outp;
	reg [0:63] num1, num2;

phase1 iphase1(.x(num1),.teta(num2),.h(outp));
      // instantiate 
   /*   dot_product
          #(
                .N(`NUM_ELEMS),
                .DW(`DATA_WIDTH)
          ) my_inner_product (
                .inp1(num1),
                .inp2(num2), // takes in count as 2 inputs 
                .outp(outp)
          );
*/



endmodule