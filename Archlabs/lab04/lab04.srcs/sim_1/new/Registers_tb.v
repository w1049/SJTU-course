`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/22 11:42:11
// Design Name: 
// Module Name: Registers_tb
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


module Registers_tb(

    );

    reg Clk;
    reg [4:0] readReg1;
    reg [4:0] readReg2;
    reg [4:0] writeReg;
    reg [31:0] writeData;
    reg regWrite;
    wire [31:0] readData1;
    wire [31:0] readData2;

    Registers registers (
        Clk,
        readReg1,
        readReg2,
        writeReg,
        writeData,
        regWrite,
        readData1,
        readData2
    );

    always #(100) Clk = !Clk;
    
    initial begin
        Clk = 1;
        readReg1 = 0;
        readReg2 = 0;
        writeReg = 0;
        writeData = 0;
        regWrite = 0;

        #285;
        regWrite = 1'b1;
        writeReg = 5'b10101;
        writeData = 32'b11111111111111110000000000000000;

        #200;
        writeReg = 5'b01010;
        writeData = 32'b00000000000000001111111111111111;

        #200;
        regWrite = 1'b0;
        writeReg = 5'b0;
        writeData = 32'b0;

        #50;
        readReg1 = 5'b10101;
        readReg2 = 5'b01010;
    end
endmodule
