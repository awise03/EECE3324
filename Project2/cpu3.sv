/*
- Created by Alexander Wise
- Student ID: 002907473
*/


`timescale 1ns / 1ps

module cpu3(
    input logic [31:0] ibus,
    input logic clk,
    output logic [31:0] WD
    );
    
    // Initial Value Declarations
    logic [31:0] ID_immv32, ID_RD1, ID_RD2;
    logic [5:0] ID_OpCode, ID_Func; 
    logic [4:0] ID_rd, ID_rt, ID_rs, ID_WR;
    logic [16:0] ID_immv16;
    
    logic [2:0] ID_ALUop;
    logic ID_ALUsrc;
    
    logic [2:0] EX_ALUop;
    logic [31:0] EX_RD1, EX_ALU_B, EX_immv, EX_RD2;
    logic EX_ALUsrc;
    logic [4:0] EX_WR;
    
    logic [31:0] EX_WD;
    
    logic [4:0] WR;
    
    // IF/ID Stage:
    // IF/ID Registers
    register #(6) IFID_code (.clk(clk), .D(ibus[31:26]), .Q(ID_OpCode));
    register #(6) IFID_Func(.clk(clk), .D(ibus[5:0]), .Q(ID_Func));
    register #(5) IFID_rs(.clk(clk), .D(ibus[25:21]), .Q(ID_rs));
    register #(5) IFID_rt(.clk(clk), .D(ibus[20:16]), .Q(ID_rt));
    register #(5) IFID_rd(.clk(clk), .D(ibus[15:11]), .Q(ID_rd));
    register #(16) IFID_immv(.clk(clk), .D(ibus[15:0]), .Q(ID_immv16));
    
    // IFID Control Modules
    controller c1(.OpCode(ID_OpCode), .Func(ID_Func), .ALUop(ID_ALUop), .ALUsrc(ID_ALUsrc));
    mux2to1 #(5) m1(.D0(ID_rd), .D1(ID_rt), .s(ID_ALUsrc), .Y(ID_WR));
    signext16to32 signext(.immv16(ID_immv16), .immv32(ID_immv32));
    regfile rf(.clk(clk), .Read1(ID_rs), .Read2(ID_rt), .Write(WR), .WD(WD), .RD1(ID_RD1), .RD2(ID_RD2));
    
    // ID/EX Stage
    // ID/EX Registers
    register #(3) IDEX_ALUop (.clk(clk), .D(ID_ALUop), .Q(EX_ALUop));
    register #(32) IDEX_RD1 (.clk(clk), .D(ID_RD1), .Q(EX_RD1));
    register #(32) IDEX_RD2 (.clk(clk), .D(ID_RD2), .Q(EX_RD2));
    register #(32) IDEX_immv (.clk(clk), .D(ID_immv32), .Q(EX_immv));
    register #(1) IDEX_ALUsrc (.clk(clk), .D(ID_ALUsrc), .Q(EX_ALUsrc));
    register #(5) IDEX_WR (.clk(clk), .D(ID_WR), .Q(EX_WR));
    
    // ID/EX Control Modules
    mux2to1 m2 (.D1(EX_immv), .D0(EX_RD2), .s(EX_ALUsrc), .Y(EX_ALU_B));
    alu32 alu(.a(EX_RD1), .b(EX_ALU_B), .ALUop(EX_ALUop), .d(EX_WD));
    
    // EX/MEM Stage
    // EX/MEM Registers
    register #(32) EXMEM_WD (.clk(clk), .D(EX_WD), .Q(WD));
    register #(5) EXMEM_WR (.clk(clk), .D(EX_WR),. Q(WR));
    
endmodule
