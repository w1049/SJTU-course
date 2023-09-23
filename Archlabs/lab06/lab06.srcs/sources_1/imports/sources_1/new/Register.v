`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/29 09:55:52
// Design Name: 
// Module Name: Register
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


module Register#(parameter MSB = 31)(
    input Clk,
    input reset,
    input write,
    input [MSB:0] in,
    output reg [MSB:0] out
    );

    always @(posedge Clk) begin
        if (reset) out <= 0;
        else if (write) out <= in;
    end

endmodule
