`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/29 09:55:52
// Design Name: 
// Module Name: PC
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


module PC(
    input Clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
    );

    always @(posedge Clk) begin
        if (!reset) out <= in;
        else out <= 0;
    end

endmodule
