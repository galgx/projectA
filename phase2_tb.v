module phase2_tb();
 
// -----------------------------------------------------------       
//                  Reset & Clock
// -----------------------------------------------------------  
  
  reg            clock;
  reg            resetn;
  reg            enable;
  
// -----------------------------------------------------------       
//                  Registers & Wires
// -----------------------------------------------------------  

   reg [63:0] x_col;
   reg [63:0] y;
   reg [63:0] h;
   reg [63:0] g;
   parameter DW =8; 
   parameter N =8;
    parameter N_bit = 3;
   // `include "dot_product.v";


  
 
   phase2 U_2( .clk(clock),.resetn(resetn),.enable(enable),.x_col(x),.y(y),.h(h), .g(g) );


 // ----------------------------------------------------------------------
//                   Test Pattern
// ----------------------------------------------------------------------


initial begin

initiate_all;                                 // Initiates all input signals to '0' and open necessary files
	 
   #100 
   resetn = 1;
   @(posedge clock)
   enable = 1;
   #100

 //  x = 64'b0000001000000100;      // CPU WRITE- first parameter is the address, second is the data 
   //teta = 64'b0000001000000100;
   x_col = 64'b00011100;
   h = 64'b01011110;
   y = 64'b01000100;
   //#100

end
   



// ----------------------------------------------------------------------
//                   Clock generator  (Duty cycle 8ns)
// ----------------------------------------------------------------------

   
  always
    #10 clock <= ~clock;  
	
	

// ----------------------------------------------------------------------
//                   Tasks
// ----------------------------------------------------------------------

 
 task initiate_all;       
   begin
	 clock = 1'b0;	 
	 resetn = 1'b1;   
	 enable =1'b0;
	 x_col = 64'b0;
	 h = 64'b0;
	 y = 64'b0;
	// cpu_apb_rdata  = 8'b0;

	  
     #10 resetn = 1'b0;     // Disable Reset signal.	 
	 
        //TO DO: ask if we need to write the configuration file and what exactly it has
		// I changed the tasks to get the input from us
		
      end
 endtask
	


 
 endmodule 