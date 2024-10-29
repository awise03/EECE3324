/*
- Created by Alexander Wise
- Student ID: 002907473
*/

module mux2to1 #(parameter n = 32) (
        input [n-1:0] D0, D1,
        input s,
        output logic [n-1:0] Y);

    assign Y = s ? D1:D0;
    
endmodule