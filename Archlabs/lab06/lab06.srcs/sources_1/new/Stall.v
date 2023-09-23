`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/18 23:50:08
// Design Name: 
// Module Name: Stall
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


module Stall(
    input IDEX_memRead,
    input [4:0] IDEX_rt,
    input [4:0] IFID_rs,
    input [4:0] IFID_rt,
    output reg stall
    );

    always @(*) begin
        if (IDEX_memRead && (IDEX_rt == IFID_rs || IDEX_rt == IFID_rt))
            stall = 1;
        else
            stall = 0;
    end
endmodule
