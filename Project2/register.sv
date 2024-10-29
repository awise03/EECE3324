/*
- Created by Alexander Wise
- Student ID: 002907473
*/

module register #(parameter rsize = 32) 
          (input logic clk,
		   input logic [rsize-1:0] D,
		   output logic [rsize-1:0] Q);
     			
    
    always @(posedge clk) begin
		Q <= D;
    end
endmodule