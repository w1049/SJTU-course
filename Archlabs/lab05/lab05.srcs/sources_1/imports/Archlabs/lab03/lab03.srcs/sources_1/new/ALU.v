`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/22 11:02:51
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] input1,
    input [31:0] input2,
    input [3:0] aluCtr,
    output reg zero,
    output reg [31:0] aluRes
    );

    always @(input1 or input2 or aluCtr) begin
        case (aluCtr)
        4'b0000: aluRes = input1 & input2;
        4'b0001: aluRes = input1 | input2;
        4'b0010: aluRes = input1 + input2;
        4'b0110: aluRes = input1 - input2;
        4'b0111: aluRes = $signed(input1) < $signed(input2) ? 1 : 0;
        4'b1100: aluRes = ~(input1 | input2);
        4'b0011: aluRes = input2 << input1;  // sll
        4'b0100: aluRes = input2 >>> input1; // srl
        endcase
        if (aluRes == 0) zero = 1;
        else zero = 0;
    end

endmodule
