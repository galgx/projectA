//////////////////////////////////////////////////////////////////////////      
// File name: MBGD_top.v                                                 //
// Creation:                                                            //
// Author: Anna and Gal                                                        //
//                                                                      //
//////////////////////////////////////////////////////////////////////////
// $Last Modified:    Sunday 19/12/2018                                 //


 module MBGD_top(resetn, apb_pclk, apb_pwrite, apb_psel, apb_pwdata, apb_penable, apb_paddress, apb_pready, prdata, state);


// ----------------------------------------------------------------------
//                   reset and clocks
// ----------------------------------------------------------------------
 
 
     input wire         resetn;
 
 // ----------------------------------------------------------------------
 //                  APB Interface Signals
 // ----------------------------------------------------------------------
	
	
	input wire           apb_pclk;                                                       
	input wire          apb_pwrite;                                                     
	input wire  	    apb_psel;
	input wire [7:0]    apb_pwdata;
	input wire          apb_penable;
	input wire [7:0]    apb_paddress;
	output wire			apb_pready;
	output wire [7:0]	prdata;	
	output wire [1:0]    state;   // only for us to check the state machine
	
	
// ----------------------------------------------------------------------
//                  mbgd_regfile Instantiation
// ----------------------------------------------------------------------
	
	 mbgd_regfile mbgd_regfile1( .prdata ( prdata ),
							.apb_pready(apb_pready),
                            .apb_penable (apb_penable ),
                            .apb_pwrite ( apb_pwrite),
                            .apb_psel ( apb_psel),
                            .apb_pclk ( apb_pclk ),
                            .resetn ( resetn ),
                            .apb_paddress ( apb_paddress ),
                            .apb_pwdata ( apb_pwdata ),
                            .state (state)
                             );




 
   
 endmodule
