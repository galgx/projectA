module slave_apb (  output reg [ 7 : 0 ] prdata, //dataout from slave 
                    input                penable,// to enable read or write
                    input                pwrite, // control signal 
                    input 	         psel,  // select signal
                    input                pclk,   // posedge clk
                    input                presetn, // negedge reset              
                    input [ 7 : 0 ] paddr,  // 8-bit address            
                    input [ 7 : 0 ] pwdata  // 8-bit write data
                    );
  
  parameter         IDLE    = 2'b00;              // states
  parameter         SETUP   = 2'b01;
  parameter         ACCESS  = 2'b10;

  reg   [ 1 : 0 ]    pres_state;                  // to store state changes
  reg   [ 1 : 0 ]    next_state;

  reg   [ 7 : 0 ]    slave [ 0 : 255 ];  // slaveory-256 bytes
  reg   [ 7 : 0 ]    prdata1;
  
  always @ ( posedge pclk or negedge presetn )
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
	  if ( ! penable )
	   begin
            if ( psel == 0 ) 
	     begin
               next_state = IDLE;
	             prdata1 = 8'b0;
             end
	    
            else if ( ( psel == 1 ) && ( penable == 0 ) )
               next_state = SETUP;
	    
          end 
	        
        end //: idle_state
      
      SETUP  :
        begin //: setup_state
	  
          if( ( psel == 1 ) && ( penable == 1) )
            next_state  = ACCESS;

        end //: setup_state
      
      ACCESS :
        begin //: access_state
	 
          if ( ( psel == 1 ) && ( penable == 0 ) )
            next_state  = SETUP;
	
          else
          begin //: no_transfer
            next_state  = IDLE;
          end //: no_transfer
          
	  if(!pwrite)        
            prdata1         = slave [ paddr ];
	  
          if (( psel == 0 ) && ( penable == 0 ))  
            next_state = IDLE;
	
        end //: enable_state
      
      default : next_state = IDLE;
    endcase
  end //: state_change
  
  always @ ( /*posedge pclk or negedge presetn*/ *)
  begin 
    if ( ! presetn)
    begin
      prdata = 8'b0;
    end  
    else
      if ( ( pres_state == ACCESS ) && ( pwrite == 0 ) )
        prdata = prdata1;
  end

  always @ (/*posedge pclk or negedge presetn*/ * )
  begin
    if ( (pres_state == ACCESS) && (pwrite ==1) )
     begin
        slave [paddr] = pwdata; 
     end 
  end
  
endmodule