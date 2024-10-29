`timescale 1ns / 1ps

module alu32 (	input logic [31:0] a, b,
				input logic[2:0] ALUop,
				output logic [31:0] d,
				output logic Cout, V, 
				output logic Z);

    assign Z = (d == 0);
  
    always_comb  begin  
        Cout = 0;
        V = 1'bx;
        d = 0;  //default outputs
        // Switch statement for the three op codes
        case (ALUop)
            3'b000: begin 
                d = a + b;
                V = (a[31] & b[31] & !d[31]) | (!a[31] & !b[31] & d[31]); // Checks to see if the last bit is different than the two input bits 
                if(a[31] & b[31] & !d[31]) Cout = 1'b1; end // Carryout if the sign bit doesn't match the two input signs (0)
            3'b001:
                if(b < 31) d = a << b; // Applies the shift if b < 31
                else d = a;
            3'b111:
                d = a & b;  
        endcase
  end
  
endmodule
