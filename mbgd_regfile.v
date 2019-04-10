module(resetn,apb_pclk,apb_pwrite,apb_psel,apb_pwdata,apb_penable,apb_paddress,prdata,prd,pwr);


/**************   reset and clocks   ************/
	input          resetn;
	input          clock; //???????????


/**************   APB Interface Signals   ************/

	input wire          apb_pclk;                                                       
	input wire          apb_pwrite;                                                     
	input wire  	    apb_psel;
	input wire [31:0]   apb_pwdata;
	input wire          apb_penable;
	input wire [9:0]    apb_paddress;    
	 
	 
	output reg [31:0]	prdata;	
	output reg	        prd	;
	output reg	        pwr	;

	
/**************   constant states  ************/
  parameter         IDLE    = 2'b00;              // states
  parameter         SETUP   = 2'b01;
  parameter         ACCESS  = 2'b10;

/**************   registers    ************/

	reg REG_1    ;
	reg REG_2    ;
	reg REG_3    ;
	reg REG_4    ;
	reg REG_5    ;
	reg REG_6    ;
	reg REG_7    ;

	reg   [ 1 : 0 ]    pres_state;                  // to store state changes
	reg   [ 1 : 0 ]    next_state;


	reg   [ 7 : 0 ]    prdata1;

/**************   registers address   ************/

	parameter REG_1_ADDR	 = 10'b0000000000;  // 0x00
	parameter REG_2_ADDR	 = 10'b0000000001;  // 0x04
	parameter REG_3_ADDR	 = 10'b0000000010;  // 0x08
	parameter REG_4_ADDR	 = 10'b0000000011;  // 0x0c
	parameter REG_5_ADDR	 = 10'b0000000100;  // 0x10
	parameter REG_6_ADDR	 = 10'b0000000101;  // 0x14
	parameter REG_7_ADDR	 = 10'b0000000110;  // 0x18

  reg   [ 7 : 0 ]    slave [ 0 : 255 ];  // slaveory-256 bytes



  
  /* prd	<= apb_psel and not apb_pen and not apb_pwrite;
pwr	<= apb_psel and not apb_pen and apb_pwrite; */

  always @ ( posedge apb_pclk or negedge presetn )
  begin// : fsm_slave
    if ( ! presetn )
      pres_state = IDLE;
    else 
      pres_state = next_state;
  end// : fsm_slave
  
  always @ (*) 
  begin
    prdata1 = 8'b0;
    next_state = 2'b0;     

    case ( pres_state )
      
      IDLE   :
        begin //: idle_state
	  if ( ! apb_penable )
	   begin
            if ( apb_psel == 0 ) 
	     begin
               next_state = IDLE;
	             prdata1 = 8'b0;
             end
	    
            else if ( ( apb_psel == 1 ) && ( apb_penable == 0 ) )
               next_state = SETUP;
	    
          end 
	        
        end //: idle_state
      
      SETUP  :
        begin //: setup_state
	  
          if( ( apb_psel == 1 ) && ( apb_penable == 1) )
            next_state  = ACCESS;

        end //: setup_state
      
      ACCESS :
        begin //: access_state
	 
          if ( ( apb_psel == 1 ) && ( apb_penable == 0 ) )
            next_state  = SETUP;
	
          else
          begin //: no_transfer
            next_state  = IDLE;
          end //: no_transfer
          
	  if(!apb_pwrite)        
            prdata1         = slave [ apb_paddress ];
	  
          if (( apb_psel == 0 ) && ( apb_penable == 0 ))  
            next_state = IDLE;
	
        end //: enable_state
      
      default : next_state = IDLE;
    endcase
  end //: state_change
  
  
  /**************   read   ************/

  always @ ( /*posedge apb_pclk or negedge presetn*/ *)
  begin 
    if ( ! presetn)
    begin
      prdata = 8'b0;
    end  
    else
      if ( ( pres_state == ACCESS ) && ( apb_pwrite == 0 ) )
        prdata = prdata1;
  end

    /**************   write  ************/
  always @ (/*posedge apb_pclk or negedge presetn*/ * )
  begin
    if ( (pres_state == ACCESS) && (apb_pwrite ==1) )
     begin
        slave [apb_paddress] = apb_pwdata; 
     end 
  end
  
endmodule

























 endmodule
