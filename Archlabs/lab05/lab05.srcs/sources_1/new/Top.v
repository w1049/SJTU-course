`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/29 08:54:36
// Design Name: 
// Module Name: Top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Top(
    input clk_p,
    input clk_n,
    input [3:0] a,
    input [3:0] b,
    input _reset,
//    input Clk,
//    input reset,
    
    output led_clk,
    output led_do,
    output led_en,
    
    output wire seg_clk,
    output wire seg_en,
    output wire seg_do
    );
    wire CLK_i;
    wire Clk_25M;
    
    IBUFGDS IBUFGDS_inst (
        .O(CLK_i),
        .I(clk_p),
        .IB(clk_n)
    );

    reg [1:0] clkdiv;
    always @(posedge CLK_i) clkdiv <= clkdiv + 1;
    assign Clk_25M = clkdiv[1];
    wire [3:0] aa;
    wire [3:0] bb;
    wire [7:0] sum;
    display DISPLAY (
        .clk(Clk_25M),
        .rst(1'b0),
        .en(8'b01010011),
        .data({4'b0, aa, 4'b0, bb, 8'b0, sum}),
        .dot(8'b0),
        .led(~{aa, bb, sum}),
        .led_clk(led_clk),
        .led_en(led_en),
        .led_do(led_do),
        .seg_clk(seg_clk),
        .seg_en(seg_en),
        .seg_do(seg_do)
    );

    wire Clk;
    wire reset;
    assign Clk = Clk_25M;
    assign reset = !_reset;

    wire [31:0] newpc;
    wire [31:0] pcplus4;
    wire [31:0] pc;
    wire [31:0] inst;

    // reg [5:0] opCode;
    wire [1:0] regDst;
    wire aluSrc;
    wire aluSrc1;
    wire memToReg;
    wire regWrite;
    wire memRead;
    wire memWrite;
    wire branch;
    wire [2:0] aluOp;
    wire [1:0] jump;
    wire extOp;

    // reg [5:0] funct;
    // reg [1:0] aluOp;
    wire [3:0] aluCtrOut;
    
    wire [31:0] input1;
    wire [31:0] input2;
    // reg [3:0] aluCtr;
    wire zero;
    wire [31:0] aluRes;

    // reg Clk;
    // reg [25:21] readReg1;
    // reg [20:16] readReg2;
    wire [4:0] writeReg;
    wire [31:0] writeData;
    // reg regWrite;
    wire [31:0] readData1;
    wire [31:0] readData2;

    // reg Clk;
    // reg [31:0] address;
    // reg [31:0] writeData;
    // reg memWrite;
    // reg memRead;
    wire [31:0] readData;

    wire [31:0] imm;


    Ctr ctr ( // OK
        .opCode(inst[31:26]),
        .funct(inst[5:0]),
        .regDst(regDst),
        .aluSrc(aluSrc),
        .memToReg(memToReg),
        .regWrite(regWrite),
        .memRead(memRead),
        .memWrite(memWrite),
        .branch(branch),
        .aluOp(aluOp),
        .jump(jump),
        .extOp(extOp)
    );

    ALUCtr aluCtr ( // OK
        .funct(inst[5:0]), 
        .aluOp(aluOp),
        .aluSrc1(aluSrc1),
        .aluCtrOut(aluCtrOut)
    );

    ALU alu ( // OK
        .input1(input1),
        .input2(input2),
        .aluCtr(aluCtrOut),
        .zero(zero),
        .aluRes(aluRes)
    );

    Registers registers ( // OK
        .Clk(Clk),
        .reset(reset),
        .readReg1(inst[25:21]),
        .readReg2(inst[20:16]),
        .writeReg(writeReg),
        .writeData(writeData),
        .regWrite(regWrite),
        .readData1(readData1),
        .readData2(readData2)
//        .sum(sum)
    );

    DataMemory dataMemory ( // OK
        .Clk(Clk),
        .reset(reset),
        .a(a),
        .b(b),
        .aa(aa),
        .bb(bb),
        .sum(sum),
        .address(aluRes),
        .writeData(readData2),
        .memWrite(memWrite),
        .memRead(memRead),
        .readData(readData)
    );
    
    Signext signext ( // OK
        .extOp(extOp),
        .inst(inst[15:0]),
        .data(imm)
    );

    InstMemory instMemory ( // OK
        .Clk(Clk),
        .reset(reset),
        .address(pc),
        .inst(inst)
    );

    PC u0 (
        .Clk(Clk),
        .reset(reset),
        .in(newpc),
        .out(pc)
    );

    // Register
    assign writeReg = regDst[1] ? 31 : (regDst[0] ? inst[15:11] : inst[20:16]);
    assign writeData = regDst[1] ? pc + 4 : (memToReg ? readData : aluRes);

    // ALU
    assign input1 = aluSrc1 ? inst[10:6] : readData1;
    assign input2 = aluSrc ? imm : readData2;

    // PC
    assign pcplus4 = pc + 4;
    assign newpc = jump[0] ? {pcplus4[31:28], inst[25:0], 2'b0}
                        : (jump[1] ? readData1 // jr
                        : (branch && zero ? (imm << 2) + pcplus4 : pcplus4));
endmodule
