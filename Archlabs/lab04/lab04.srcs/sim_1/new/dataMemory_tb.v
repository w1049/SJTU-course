`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/29 08:18:03
// Design Name: 
// Module Name: dataMemory_tb
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


module dataMemory_tb(

    );

    reg Clk;
    reg [31:0] address;
    reg [31:0] writeData;
    reg memWrite;
    reg memRead;
    wire [31:0] readData;

    dataMemory u0 (Clk, address, writeData, memWrite, memRead, readData);
    
    always #(100) Clk = !Clk;
    
    initial begin
        Clk = 0;
        address = 0;
        writeData = 0;
        memWrite = 0;
        memRead = 0;

        #185;
        memWrite = 1;
        address = 32'b111;
        writeData = 32'b11100000000000000000000000000000;

        #100;
        memWrite = 1;
        writeData = 32'hffffffff;
        address = 3'b110;

        #185;
        address = 7;
        memRead = 1;
        memWrite = 0;

        #80;
        memWrite = 1;
        address = 8;
        writeData = 32'haaaaaaaa;
        
        #80;
        address = 6;
        memWrite = 0;
        memRead = 1;
    end
endmodule
