//////////////////////////////////////////////////////////////////////////      
// File name: MBGD_tb.v                                                 //
// Creation:                                                            //
// Author: Anna and Gal                                                 //
//                                                                      //
//////////////////////////////////////////////////////////////////////////
// $Last Modified:    Sunday 19/12/2018                                 //
//////////////////////////////////////////////////////////////////////////


/*************************************************************************************

  MBGD Test-Bench

*************************************************************************************/





//`timescale 1ns/100ps

module MBGD_tb();
 
// -----------------------------------------------------------       
//                  Reset & Clock
// -----------------------------------------------------------  
  
  reg            clock;
  reg            resetn;
  
// -----------------------------------------------------------       
//                  Registers & Wires
// -----------------------------------------------------------  

  wire [ 7 : 0 ] cpu_apb_rdata;
  wire 			 cpu_apb_ready;
  reg  [ 7 : 0 ] cpu_apb_wdata;
  reg  [ 7 : 0 ] cpu_apb_addr;
  reg            cpu_apb_enable;
  reg            cpu_apb_write;
  reg            cpu_apb_sel;
    
  wire [ 1 : 0 ] state;
 reg             flag_ready ;
  
 //TO DO: check the interface of the the RAM in lab 
 
 /*   wire 	    apb_ram_cs;	
   wire 	    apb_ram_rd;     
   wire [5:0] 	apb_ram_addr;
   wire [31:0]	apb_ram_d_in;	   
   wire [31:0]  ram_apb_d_out; */
   




   MBGD_top MBGD_top1( .prdata ( cpu_apb_rdata ),
							.apb_pready(cpu_apb_ready),
                            .apb_penable ( cpu_apb_enable ),
                            .apb_pwrite ( cpu_apb_write),
                            .apb_psel ( cpu_apb_sel),
                            .apb_pclk ( clock ),
                            .resetn ( resetn ),
                            .apb_paddress ( cpu_apb_addr ),
                            .apb_pwdata ( cpu_apb_wdata ),
                            .state (state)
                             );


/* 
//TO DO: check the RAM in lab
// New Storage-RAM (buffer) - with a retention shell
ram48x32_w ram(   .nreset	(resetn),
                  .clk		(clock),
                  .csn		(tso_ram_cs),
                  .wen		(tso_ram_rd),
                  .a		(tso_ram_addr[5:0]),
                  .i		(tso_ram_d_in[31:0]),
                  .o		(ram_tso_d_out[31:0]),
                  .scan_shift	(misc_tso_scan_act),		  
                  .bist_mode	(1'b0),
                  .bist_in	(60'b0),
                  .bist_out	(),
                  .retention	(1'b1),
                  .scan_ram_bypass  (1'b0),		      		  
                  .amp_adjust	(3'b011)		       
                 );
 */
 
 // ----------------------------------------------------------------------
//                   Test Pattern
// ----------------------------------------------------------------------


initial begin
#1
initiate_all;                                 // Initiates all input signals to '0' and open necessary files
	 
   #100 
   @(posedge clock); 
   cpu_write(8'b00000000,8'b11101110) ;      // CPU WRITE- first parameter is the address, second is the data 
   //#100
   @(posedge clock); 
   cpu_write(8'b00000001,8'b11001100) ; 
   //#100
  

 //return to Idel
    cpu_apb_sel     = 1'b0; 
    flag_ready = 1'b0;
   
   @(posedge clock);
   cpu_read(8'b00000000);                                 // CPU READ transaction 
    //#100
   @(posedge clock);  
    cpu_read(8'b00000001);  
    
     //return to Idel                            
    cpu_apb_sel     = 1'b0; 
    flag_ready = 1'b0;
   
   
//   #100000  $finish;
   
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
	 resetn = 1'b0;   
	
	// cpu_apb_rdata  = 8'b0;
	 cpu_apb_wdata  = 8'b0;
	 cpu_apb_addr   = 8'b0; 
	 cpu_apb_enable = 1'b0; 
	 cpu_apb_write  = 1'b0;
	 cpu_apb_sel    = 1'b0;
	
	 flag_ready = 1'b0;
		  
     #10 resetn = 1'b1;     // Disable Reset signal.	 
	 
        //TO DO: ask if we need to write the configuration file and what exactly it has
		// I changed the tasks to get the input from us
		
      end
 endtask
	

 task cpu_write;
	input [ 7 : 0 ] tmp_cpu_address;
	input [ 7 : 0 ] tmp_cpu_data;
       begin
       
    if(flag_ready != 0)
     cpu_second_write(tmp_cpu_address,tmp_cpu_data);
     else
    begin
        cpu_first_write(tmp_cpu_address,tmp_cpu_data);
        flag_ready = 1'b1;
        end
        
 
       
        end
  endtask

  task cpu_first_write;
	input [ 7 : 0 ] tmp_cpu_address;
	input [ 7 : 0 ] tmp_cpu_data;
       begin
      
        flag_ready = 1'b1;
        cpu_apb_sel     = 1'b1;
        cpu_apb_write   = 1'b1;	
        cpu_apb_addr    = tmp_cpu_address;
        cpu_apb_wdata   = tmp_cpu_data;
        //enable and write operation takes place
      @ (posedge clock)
        cpu_apb_enable  = 1'b1;
          
      @ (posedge clock)
      begin
        cpu_apb_enable  = 1'b0;
        end
        end
  endtask 
  
   task cpu_second_write;
	input [ 7 : 0 ] tmp_cpu_address;
	input [ 7 : 0 ] tmp_cpu_data;
       begin
      //@ (posedge clock)
      begin
     // cpu_apb_sel     = 1'b1;
      cpu_apb_enable  = 1'b1;
        
        end
      @ (posedge clock)
        cpu_apb_addr    = tmp_cpu_address;
        cpu_apb_wdata   = tmp_cpu_data;
        
        cpu_apb_enable  = 1'b0;
        if(cpu_apb_write ==0)
           cpu_apb_sel     = 1'b0; 

        //enable and write operation takes place
      //@ (posedge clock)
     //  cpu_apb_enable  = 1'b0;
       end
  endtask
 
 
  task cpu_read;

	input [ 7 : 0 ] tmp_cpu_address;
  begin
    if(flag_ready != 0)
     cpu_second_read(tmp_cpu_address);
     else
    begin
        cpu_first_read(tmp_cpu_address);
        flag_ready = 1'b1;
        end
     end    
 endtask
 
 //TO DO: ask about the flush memory task 
 
  task cpu_first_read;
	input [ 7 : 0 ] tmp_cpu_address;

       begin
      
      //@ (posedge clock)
      
        flag_ready = 1'b1;
         cpu_apb_sel     = 1'b1;
         cpu_apb_write   = 1'b0;
         cpu_apb_addr    = tmp_cpu_address;
        //enable and write operation takes place
      @ (posedge clock)
        cpu_apb_enable  = 1'b1;
          
      @ (posedge clock)
      begin
        cpu_apb_enable  = 1'b0;
        
      //  cpu_apb_sel     = 1'b0;
        end
        end
  endtask 
  
   task cpu_second_read;
	input [ 7 : 0 ] tmp_cpu_address;
       begin
      //@ (posedge clock)
      begin
     // cpu_apb_sel     = 1'b1;
      cpu_apb_enable  = 1'b1;
      cpu_apb_addr    = tmp_cpu_address;
        
        end
      @ (posedge clock)
        cpu_apb_enable  = 1'b0;
       end
  endtask
 endmodule 