module syncRAM(  clk, resetn, dataIn, Addr, CS, RD, dataOut);


// parameters for the width 

parameter ADDR   = 8;

parameter DATA   = 8;

parameter DEPTH  = 8;


//ports
input   clk;
input   resetn;
input   [ADDR-1:0]  Addr;
input   [DATA-1:0]  dataIn;
input   CS, RD;
output reg [DATA-1:0]  dataOut;

  
//internal variables

reg [DATA-1:0] SRAM [DEPTH-1:0];


always @ (posedge clk or negedge resetn)

begin

  if (CS == 1'b1) begin
  
  	 if (RD == 1'b0) begin
  
  		SRAM [Addr] = dataIn;
  
  	 end
  
  	 else begin
  
      dataOut = SRAM [Addr]; 
  
  	end
  
  end
  
end

endmodule