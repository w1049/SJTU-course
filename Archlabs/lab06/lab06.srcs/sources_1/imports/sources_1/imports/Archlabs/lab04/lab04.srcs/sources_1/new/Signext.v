`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/29 08:39:55
// Design Name: 
// Module Name: Signext
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


module Signext(
    input extOp,
    input [15:0] inst,
    output [31:0] data
    );

    assign data = extOp ? {{16{inst[15]}}, inst} : {{16{1'b0}}, inst};
endmodule
