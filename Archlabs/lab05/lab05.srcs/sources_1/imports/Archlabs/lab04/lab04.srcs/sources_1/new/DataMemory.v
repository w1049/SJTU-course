`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/29 08:03:03
// Design Name: 
// Module Name: DataMemory
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


module DataMemory(
    input Clk,
    input reset,
    input [3:0] a,
    input [3:0] b,
    input [31:0] address,
    input [31:0] writeData,
    input memWrite,
    input memRead,
    output [31:0] readData,
    output [7:0] sum,
    output [3:0] aa,
    output [3:0] bb
    );
    
    reg [31:0] memFile[0:63];
    initial begin
        $readmemh("Data", memFile);
    end
    
    assign readData = memRead && !memWrite ? memFile[address >> 2] : 0;
    assign aa = memFile[0][3:0];
    assign bb = memFile[1][3:0];
    assign sum = memFile[2][7:0];

    always @(negedge Clk) begin
        if (reset) begin
            memFile[0] <= a;
            memFile[1] <= b;
            memFile[2] <= 0;
        end
        else if (memWrite)
            memFile[address >> 2] <= writeData;
    end
    
endmodule
