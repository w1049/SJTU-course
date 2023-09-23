`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/22 11:33:36
// Design Name: 
// Module Name: Registers
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


module Registers(
    input Clk,
    input [25:21] readReg1,
    input [20:16] readReg2,
    input [4:0] writeReg,
    input [31:0] writeData,
    input regWrite,
    output [31:0] readData1,
    output [31:0] readData2
    );

    reg [31:0] regFile[31:0];
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1)
            regFile[i] <= 0;
    end

    assign readData1 = regFile[readReg1];
    assign readData2 = regFile[readReg2];

//    always @(readReg1 or readReg2 or writeReg) begin
        
//    end

    always @(negedge Clk) begin
        if (regWrite) regFile[writeReg] <= writeData;
    end
endmodule
