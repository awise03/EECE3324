/*
- Created by Alexander Wise
- Student ID: 002907473
*/

`timescale 1ns / 1ps



module signext16to32(
    input logic [15:0] immv16,
    output logic [32:0] immv32
    );
    
    // Takes the last bit in the 16 bit number, reprints it 16 times, and adds the remaining 16 bits back to the front. 
    assign immv32 = {{16{immv16[15]}}, immv16};
endmodule
