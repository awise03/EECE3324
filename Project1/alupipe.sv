module alupipe (
    input logic [31:0] RD1, RD2,
    input logic [2:0] INop,
    input logic clk,
    output logic [31:0] WD
);
    logic [31:0] a, b, d;
    logic [2:0] ALUop;
    logic c, v, z;
    
    register #(32) A (.clk(clk), .D(RD1), .Q(a));
    register #(32) B (.clk(clk), .D(RD2), .Q(b));
    register #(3)  C (.clk(clk), .D(INop), .Q(ALUop));
    register #(32) D (.clk(clk), .D(d), .Q(WD));

    alu32 ALU (
        .a(a), 
        .b(b), 
        .ALUop(ALUop), 
        .d(d),
        .Cout(c), 
        .V(v), 
        .Z(z)
    );
endmodule
