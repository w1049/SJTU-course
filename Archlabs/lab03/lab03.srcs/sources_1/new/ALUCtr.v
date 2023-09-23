`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/22 10:05:52
// Design Name: 
// Module Name: ALUCtr
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


module ALUCtr(
    input [5:0] funct,
    input [1:0] aluOp,
    output reg [3:0] aluCtrOut
    );

    always @(aluOp or funct) begin
        casex ({aluOp, funct})
        8'b00xxxxxx: aluCtrOut = 4'b0010;
        8'bx1xxxxxx: aluCtrOut = 4'b0110;
        8'b1xxx0000: aluCtrOut = 4'b0010;
        8'b1xxx0010: aluCtrOut = 4'b0110;
        8'b1xxx0100: aluCtrOut = 4'b0000;
        8'b1xxx0101: aluCtrOut = 4'b0001;
        8'b1xxx1010: aluCtrOut = 4'b0111;
        default: aluCtrOut = 4'b0;
        endcase
    end

endmodule
