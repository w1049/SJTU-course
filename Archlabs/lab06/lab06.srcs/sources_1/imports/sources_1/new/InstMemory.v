`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/29 09:46:29
// Design Name: 
// Module Name: InstMemory
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


module InstMemory(
    input [31:0] address,
    output [31:0] inst
    );
    
    reg [31:0] instFile[0:63];
    initial begin
        $readmemb("Instruction", instFile);
    end
    
    assign inst = instFile[address >> 2];

endmodule
