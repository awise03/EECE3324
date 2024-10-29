/*
- Created by Alexander Wise
- Student ID: 002907473
*/

module controller (
        input logic [5:0] OpCode, Func,
        output logic [2:0] ALUop,
        output logic ALUsrc
    );

    always_comb begin
        // I Type Instructions
        if(OpCode != 6'b0) begin
            ALUsrc = 1;
            // Switch statement for OpCode
            case(OpCode)
                6'b000011: 
                    ALUop = 3'b0;
                6'b001111: 
                    ALUop = 3'b111; 
            endcase
        end
        // R Type Instructions    
        else begin
            ALUsrc = 0;
            // Switch statment for Func 
            case(Func)
                6'b000011:
                    ALUop = 3'b0;
                6'b000010:
                    ALUop = 3'b001;
                6'b000111:
                    ALUop = 3'b111;                  
            endcase
        end          
        
    end

endmodule
