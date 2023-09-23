`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/29 08:03:03
// Design Name: 
// Module Name: dataMemory
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


module dataMemory(
    input Clk,
    input [31:0] address,
    input [31:0] writeData,
    input memWrite,
    input memRead,
    output [31:0] readData
    );
    
    reg [31:0] memFile[0:63];
    integer i;
    initial begin
        for (i = 0; i < 64; i = i + 1)
            memFile[i] <= 0;
    end
    
    assign readData = memRead && !memWrite ? memFile[address] : 0;
    
    always @(negedge Clk) begin
        if (memWrite)
            memFile[address] = writeData;
    end
    
endmodule
