module register #(parameter rsize = 32) 
          (input logic clk,
		   input logic [rsize-1:0] D,
		   output logic [rsize-1:0] Q);
     			
    
    always @(posedge clk) begin
		Q <= D;
    end
endmodule