module regalu (
    input logic clk,
    input logic [4:0] RR1, RR2, WR,
    input logic [2:0] INop,
    output logic [31:0] RD1, RD2, WD
);
    // Wires for pipelined register addresses
    logic [4:0] WRX, WRM;

    
    // Register file instance
    regfile rf (
        .clk(clk),
        .Read1(RR1),
        .Read2(RR2),
        .Write(WRM),
        .WD(WD),
        .RD1(RD1),
        .RD2(RD2)
    );

    // Registers to propagate X and M with input registers
    register #(5) X (.clk(clk), .D(WR), .Q(WRX));
    register #(5) M (.clk(clk), .D(WRX), .Q(WRM));

    // ALU pipe instance
    alupipe alu (
        .RD1(RD1),
        .RD2(RD2),
        .INop(INop),
        .clk(clk),
        .WD(WD)
    );

endmodule
