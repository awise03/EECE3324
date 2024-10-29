`timescale 1ns/1ns   
module alu32_testbench();

//Ports interfacing with the DUT
logic [31:0] a, b;       
logic [31:0] d;
logic [2:0] ALUop;

//Input stimulus values to test the DUT
logic [2:0] stmALUop[0:40];
logic [31:0] stma[0:40], stmb[0:40];

//Expected correct outputs from the DUT
logic [31:0] dontcare, Ref[0:40];
logic Cref[0:40], Zref[0:40], Vref[0:40];

integer ntests, error, k, i;  // VARIABLES NOT RELATED TO ALU I/O , BUT REQUIRED FOR TESTBENCH //

alu32 dut(.a(a), .b(b), .d(d), .Cout(Cout), .Z(Z), .V(V), .ALUop(ALUop));  // DECLARES THE MODULE BEING TESTED ALONG WITH ITS I/O PORTS //

   //////////////////////////////////////////  					 //////////////////////////////////////////
  ///////// EXPECTED VALUES ////////////////					//////////    INPUTS TO ALU      /////////
 //////////////////////////////////////////		   	    	   //////////////////////////////////////////

initial begin     //LOADING THE TEST REGISTERS WITH INPUTS AND EXPECTED VALUES//

Ref[0] = 32'hFFFFFFFF;  Cref[0] = 0;	Zref[0] = 0;	Vref[0] = 0; 	 stmALUop[0] = 3'b000;  stma[0] = 32'hFFFFFFFF;  stmb[0] = 32'h00000000;  // Test add  //
Ref[1] = 32'hFFFFFFFF;  Cref[1] = 0;	Zref[1] = 0;	Vref[1] = 0;     stmALUop[1] = 3'b000;  stma[1] = 32'hFFFFFFFF;  stmb[1] = 32'h00000000; 
Ref[2] = 32'h7FFFFFFF;  Cref[2] = 0;	Zref[2] = 0;	Vref[2] = 0;     stmALUop[2] = 3'b000;  stma[2] = 32'h7FFFFFFF;  stmb[2] = 32'h00000000; 
Ref[3] = 32'h80000000;  Cref[3] = 0;	Zref[3] = 0;	Vref[3] = 1;     stmALUop[3] = 3'b000;  stma[3] = 32'h7FFFFFFF;  stmb[3] = 32'h00000001;
Ref[4] = 32'hF0000000;  Cref[4] = 0;	Zref[4] = 0;	Vref[4] = 1'bx;  stmALUop[4] = 3'b001;  stma[4] = 32'h0000000F;  stmb[4] = 32'h0000001C;   //  Test sll   //
Ref[5] = 32'h0000000F;  Cref[5] = 0;	Zref[5] = 0;	Vref[5] = 1'bx;  stmALUop[5] = 3'b001;  stma[5] = 32'h0000000F;  stmb[5] = 32'h00000100; 
Ref[6] = 32'h0000FFFF;  Cref[6] = 1'bx;	Zref[6] = 0;	Vref[6] = 1'bx;  stmALUop[6] = 3'b111;  stma[6] = 32'hFFFFFFFF;  stmb[6] = 32'h0000FFFF;    //  Test and   //
Ref[7] = 32'h64424220;	Cref[7] = 0;    Zref[7] = 0;	Vref[7] = 1'bx;  stmALUop[7] = 3'b000;  stma[7] = 32'h31312020;  stmb[7] = 32'h33112200;   //  Test add   //
Ref[8] = 32'h00000001;	Cref[8] = 0;    Zref[8] = 0;	Vref[8] = 1'bx;  stmALUop[8] = 3'b000;  stma[8] = 32'h00000001;  stmb[8] = 32'h00000000;   
Ref[9] = 32'h0000000F;	Cref[9] = 0;	Zref[9] = 0;	Vref[9] = 1'bx;  stmALUop[9] = 3'b000;  stma[9] = 32'h0000000F;  stmb[9] = 32'h00000000; 
Ref[10] = 32'h00000010;	Cref[10] = 0;	Zref[10] = 0;	Vref[10] = 1'bx; stmALUop[10] = 3'b000; stma[10] = 32'h0000000F; stmb[10] = 32'h00000001; 
Ref[11] = 32'h000000FF;	Cref[11] = 0;	Zref[11] = 0;	Vref[11] = 1'bx; stmALUop[11] = 3'b000; stma[11] = 32'h000000FF; stmb[11] = 32'h00000000; 
Ref[12] = 32'h00000100;	Cref[12] = 0;	Zref[12] = 0;	Vref[12] = 1'bx; stmALUop[12] = 3'b000; stma[12] = 32'h000000FF; stmb[12] = 32'h00000001; 
Ref[13] = 32'h00000FFF;	Cref[13] = 0;	Zref[13] = 0;	Vref[13] = 1'bx; stmALUop[13] = 3'b000; stma[13] = 32'h00000FFF; stmb[13] = 32'h00000000; 
Ref[14] = 32'h00001000;	Cref[14] = 0;	Zref[14] = 0;	Vref[14] = 1'bx; stmALUop[14] = 3'b000; stma[14] = 32'h00000FFF; stmb[14] = 32'h00000001; 
Ref[15] = 32'h0000FFFF;	Cref[15] = 0;	Zref[15] = 0;	Vref[15] = 1'bx; stmALUop[15] = 3'b000; stma[15] = 32'h0000FFFF; stmb[15] = 32'h00000000; 
Ref[16] = 32'h00010000; Cref[16] = 0;	Zref[16] = 0;	Vref[16] = 1'bx; stmALUop[16] = 3'b000; stma[16] = 32'h0000FFFF; stmb[16] = 32'h00000001; 
Ref[17] = 32'h000FFFFF; Cref[17] = 0;	Zref[17] = 0;	Vref[17] = 1'bx; stmALUop[17] = 3'b000; stma[17] = 32'h000FFFFF; stmb[17] = 32'h00000000; 
Ref[18] = 32'h00100000;	Cref[18] = 0;	Zref[18] = 0;	Vref[18] = 1'bx; stmALUop[18] = 3'b000; stma[18] = 32'h000FFFFF; stmb[18] = 32'h00000001; 
Ref[19] = 32'h00FFFFFF;	Cref[19] = 0;	Zref[19] = 0;	Vref[19] = 1'bx; stmALUop[19] = 3'b000; stma[19] = 32'h00FFFFFF; stmb[19] = 32'h00000000; 
Ref[20] = 32'h01000000;	Cref[20] = 0;	Zref[20] = 0;	Vref[20] = 1'bx; stmALUop[20] = 3'b000; stma[20] = 32'h00FFFFFF; stmb[20] = 32'h00000001; 
Ref[21] = 32'h0FFFFFFF;	Cref[21] = 0;	Zref[21] = 0;	Vref[21] = 1'bx; stmALUop[21] = 3'b000; stma[21] = 32'h0FFFFFFF; stmb[21] = 32'h00000000; 
Ref[22] = 32'h10000000;	Cref[22] = 0;	Zref[22] = 0;	Vref[22] = 1'bx; stmALUop[22] = 3'b000; stma[22] = 32'h0FFFFFFF; stmb[22] = 32'h00000001; 
Ref[23] = 32'h00000000; Cref[23] = 1;	Zref[23] = 1;	Vref[23] = 1; 	 stmALUop[23] = 3'b000; stma[23] = 32'h80000000; stmb[23] = 32'h80000000; //  Test V // 
Ref[24] = 32'h80000000; Cref[24] = 0;	Zref[24] = 0;	Vref[24] = 1; 	 stmALUop[24] = 3'b000; stma[24] = 32'h40000000; stmb[24] = 32'h40000000; 
dontcare = 32'hx;
ntests = 25;
 
$timeformat(-9,1,"ns",12);
 
end

initial begin
 error = 0;
    
 for (k=0; k< ntests; k=k+1)   		     // LOOPING THROUGH ALL THE TEST VECTORS AND ASSIGNING IT TO THE ALU INPUTS EVERY 8ns //
    begin
     ALUop = stmALUop[k]; a = stma[k] ; b = stmb[k];
  
    #20       
     if ( ALUop == 3'b000 )
      $display ("-----  TEST FOR A + B  -----");
    
  
     if ( ALUop == 3'b001 )
      $display ("-----  TEST FOR A << B  -----");

     if ( ALUop == 3'b111 )
      $display ("-----  TEST FOR A AND B  -----");


     $display ("Test# %d \n Time=%t \n ALUop=%b \n a=\t\t%b \n b=\t\t%b \n d=\t\t%b \n Ref=\t%b \n V=%b \n Vref=%b \n Z=%b \n Zref=%b \n Cout=%b \n Cref=%b \n", k, $realtime, ALUop, a, b, d, Ref[k], V, Vref[k], Z, Zref[k], Cout, Cref[k]);
    
    
    // THIS CONTROL BLOCK CHECKS FOR ERRORS  BY COMPARING YOUR OUTPUT WITH THE EXPECTED OUTPUTS AND INCREMENTS "error" IN CASE OF ERROR //
    
     if (( (Ref[k] !== d) && (Ref[k] !== dontcare)  ) || 
	     ( (Vref[k] !== V) && (Vref[k] !== 1'bx)    ) || 
	     ( (Zref[k] !== Z) && (Zref[k] !== 1'bx)    ) || 
	     ( (Cref[k] !== Cout) && (Cref[k] !== 1'bx)    )      
		)
      begin
       $display ("-------------ERROR. A Mismatch Has Occured-----------");
       error = error + 1;
      end

  end

    if ( error == 0)
        $display("---------YOU DID IT!! SIMULATION SUCCESFULLY FINISHED----------");
    
    if ( error != 0)
        $display("---------------ERRORS. Mismatches Have Occured, sorry------------------");

    $display(" Number Of Errors = %d", error);
    $display(" Total Test numbers = %d", ntests);
    $display(" Total number of correct operations = %d", (ntests-error));

end
         
        
endmodule
         



