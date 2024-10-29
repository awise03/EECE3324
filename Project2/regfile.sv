/*
- Created by Alexander Wise
- Student ID: 002907473
*/

`timescale 1ns / 1ps



module regfile (
    input logic clk,
    input logic [4:0] Read1, Read2, Write,
    input logic [31:0] WD,
    output logic [31:0] RD1, RD2
);
    // Register file array
    logic [31:0] registers [31:0];

    // Initialize the register file
    initial begin
        integer i;
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] = i;
        end
    end

    always_ff @(negedge clk) begin
        // Write operation
	// Will only write if the value of Write is not 0
        if(Write != 5'd0) begin
	       registers[Write] = WD;
        end
        
    end

    // Read operations
    always_ff @(negedge clk) begin
	// Ensures that the 0 register will always return 0
        RD1 = (Read1 == 5'd0) ? 32'd0 : registers[Read1]; 
        RD2 = (Read2 == 5'd0) ? 32'd0 : registers[Read2];
    end
endmodule

