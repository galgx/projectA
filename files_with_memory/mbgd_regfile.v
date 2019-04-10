//////////////////////////////////////////////////////////////////////////      
// File name: mbgd_regfile.v                                            //
// Creation:                                                            //
// Author: Anna and Gal                                                 //
//                                                                      //
//////////////////////////////////////////////////////////////////////////
// $Last Modified:           16/01/2019                                 //
//////////////////////////////////////////////////////////////////////////


/*************************************************************************************

  MBGD 

*************************************************************************************/

//`include "reg_addr.v"

module mbgd_regfile(resetn, apb_pclk, apb_pwrite, apb_psel, apb_pwdata, apb_penable, apb_paddress, 
apb_pready, prdata, state, RAM_dataOut, RAM_Addr, RAM_dataIn, RAM_CS, RAM_RD);

    parameter ADDR   = 8;
    parameter DATA   = 8;

// ----------------------------------------------------------------------
//                   reset and clocks
// ----------------------------------------------------------------------

	input   wire       resetn;

// ----------------------------------------------------------------------
//                  APB Interface Signals
// ----------------------------------------------------------------------

	input wire             apb_pclk;                                                       
	input wire             apb_pwrite;                                                     
	input wire  	       apb_psel;
	input wire [DATA-1 :0]    apb_pwdata;
	input wire             apb_penable;
	input wire [ADDR-1 :0]    apb_paddress;
	output reg			   apb_pready;
	output reg [DATA-1 :0]    prdata;	
	output reg [1:0]       state;   // only for us to check the state machine

// ----------------------------------------------------------------------
//                  RAM Interface Signals
// ----------------------------------------------------------------------	
    
    input  wire [ADDR-1 :0] RAM_dataOut   ; 
    output reg	[ADDR-1 :0]  RAM_Addr  ;
    output reg   [DATA-1 :0]  RAM_dataIn;
    output reg   RAM_CS, RAM_RD;
    

// ----------------------------------------------------------------------
//                  constant states
// ----------------------------------------------------------------------

  parameter         IDLE    = 2'b00;              
  parameter         SETUP   = 2'b01;
  parameter         ACCESS  = 2'b10;
  
  // Slave Registers address
  
  
/* `define REG_1_ADDR     10'b0000000000;  // 0x00
  `define REG_2_ADDR     10'b0000000001;  // 0x04
  `define REG_3_ADDR     10'b0000000010;  // 0x08
  `define REG_4_ADDR     10'b0000000011;  // 0x0c
  `define REG_5_ADDR     10'b0000000100;  // 0x10
  `define REG_6_ADDR     10'b0000000101;  // 0x14
  `define REG_7_ADDR     10'b0000000110;  // 0x18
*/

// ----------------------------------------------------------------------
//                  registers
// ----------------------------------------------------------------------



	/**************  RAM registers    ************/
	
 	reg [7:0] ram_address    ;  //0x14
	reg [7:0] ram_data       ;  //0x18
	
	/**************  slave registers    ************/
	reg  [7:0] REG_1 = 8'b0;
	reg  [7:0] REG_2 = 8'b0; 
	reg  [7:0] REG_3 = 8'b0; 
	reg  [7:0] REG_4 = 8'b0; 
	reg  [7:0] REG_5 = 8'b0; 
	reg  [7:0] REG_6 = 8'b0; 
	reg  [7:0] REG_7 = 8'b0;  



	reg   [ 1 : 0 ]    pres_state;                  // to store state changes
	reg   [ 1 : 0 ]    next_state;
	reg   [ 7 : 0 ]    prdata1;
	reg                addr_flag = 1'b0;
	reg   [ 1 : 0 ]    data_flag = 2'b00; /* 00-default 01-write 10-read   */
	reg  done_flag = 1'b0;
	


/**************   registers address   ************/

always @ ( posedge apb_pclk or negedge resetn )

  begin// : fsm_slave

    if ( ! resetn )

      pres_state = IDLE;

    else 

      pres_state = next_state;

  end// : fsm_slave

  

  always @ (*) 

  begin

    prdata1 = 8'b0;
	apb_pready  = 1'b0;
    next_state = 2'b0;     

    case ( pres_state )

      IDLE   :

        begin //: idle_state

			if ( ! apb_penable ) begin
				
				if ( apb_psel == 0 ) begin
	
					next_state = IDLE;
					prdata1 = 8'b0;
					apb_pready  = 1'b0;

                end	

	    

            else if ( ( apb_psel == 1 ) && ( apb_penable == 0 ) )

               next_state = SETUP;

	    
            end  

        end //: idle_state

      

      SETUP  :

        begin //: setup_state

             if( ( apb_psel == 1 ) && ( apb_penable == 1) ) begin

				next_state  = ACCESS;
				apb_pready	= 1'b1;

            end

		end //: setup_state

      

      ACCESS :

        begin //: access_state
			
			
          if ( ( apb_psel == 1 ) && ( apb_penable == 0 ) )

            next_state  = SETUP;

          else begin //: no_transfer

            next_state  = IDLE;

          end //: no_transfer

          

			if(!apb_pwrite)    begin
			
			     if (apb_paddress ==  8'b00000000)
			         prdata1 = REG_1;
			      if (apb_paddress ==  8'b00000001)
			         prdata1 = REG_2; 
			     if ((apb_paddress ==  8'h18)&( addr_flag==1'b1)) begin 
			         data_flag = 2'b10;
			         ram_data = RAM_dataOut;
        
                 end    
		   end
			         
			       
/*			 	case(apb_paddress) 
                  `REG_1_ADDR      : prdata1 = REG_1;                                   
                  `REG_2_ADDR      : prdata1 = REG_2;        
                  `REG_3_ADDR      : prdata1 = REG_3;        
                  `REG_4_ADDR      : prdata1 = REG_4;        
                  `REG_5_ADDR      : prdata1 = REG_5;        
                  `REG_6_ADDR      : prdata1 = REG_6;        
                   default         : prdata1 = REG_7;
               endcase 
          
          
  */
			
				

			if (( apb_psel == 0 ) && ( apb_penable == 0 ))  
				next_state = IDLE;

	    end //: enable_state

      

      default : next_state = IDLE;

    endcase

    state = pres_state; // only for us to check the state machine

  end //: state_change
  
 

    

  /**************   read   ************/


  always @ ( /*posedge apb_pclk or negedge presetn*/ *)

  begin 

    if ( !resetn)

    begin

      prdata = 8'b0;	        
	  apb_pready = 1'b0;


    end  

    else

      if ( ( pres_state == ACCESS ) && ( apb_pwrite == 0 ) ) begin

        prdata = prdata1;

		
	  end
  end


    /**************   write  ************/

  always @ (/*posedge apb_pclk or negedge presetn*/ * )

  begin

    if ( (pres_state == ACCESS) && (apb_pwrite ==1) )

     begin
           if (apb_paddress ==  8'b00000000)
                       REG_1  = apb_pwdata;
           if (apb_paddress ==  8'b00000001)
                       REG_2  = apb_pwdata;
           if ((apb_paddress ==  8'h14)&(data_flag ==  1'b0)) begin
                       ram_address   = apb_pwdata; 
                       addr_flag     = 1'b1;
           end 
           if ((apb_paddress ==  8'h18)&(addr_flag ==  1'b1)) begin
                       ram_data   = apb_pwdata; 
                       data_flag     = 2'b01;        
                      
                     
           end           
/*		case(apb_paddress)	       
			`REG_1_ADDR      : REG_1  = apb_pwdata;                                   
			`REG_2_ADDR      : REG_2  = apb_pwdata;        
			`REG_3_ADDR      : REG_3  = apb_pwdata;        
			`REG_4_ADDR      : REG_4  = apb_pwdata;        
			`REG_5_ADDR      : REG_5  = apb_pwdata;        
			`REG_6_ADDR      : REG_6  = apb_pwdata;        
			default   	     : REG_7  = apb_pwdata;
		endcase 	
	*/

     end 

  end
  
  
    always @ ( posedge apb_pclk or negedge resetn ) begin
        if ((data_flag  == 2'b01)&(addr_flag ==1'b1)) begin
            
            RAM_Addr = ram_address;
            RAM_dataIn = ram_data;
            RAM_CS        = 1'b1;
            RAM_RD        = 1'b0;
            done_flag     = 1'b1;
    
        end
    end
  
  
      always @ ( posedge apb_pclk or negedge resetn ) begin
        if ((data_flag  == 2'b10)&(addr_flag ==1'b1)) begin
            
            RAM_Addr = ram_address;
            RAM_dataIn = ram_data;
            RAM_CS        = 1'b1;
            RAM_RD        = 1'b1;
            done_flag     = 1'b1;
    
        end
    end
  
  always @ ( posedge apb_pclk or negedge resetn ) begin
    if (done_flag ) begin
        
        data_flag = 2'b00;
        addr_flag = 1'b0;
        done_flag = 1'b0;
    end    
  end
    
 
        

endmodule






















