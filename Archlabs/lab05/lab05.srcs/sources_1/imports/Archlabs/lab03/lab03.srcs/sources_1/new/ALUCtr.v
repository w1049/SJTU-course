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
    input [2:0] aluOp,
    output reg aluSrc1,
    output reg [3:0] aluCtrOut
    );
    // aluOp: 000 = add, 001 = sub, 010 = funct
    //        100 = and, 101 = or, 110 = ?
    always @(aluOp or funct) begin
        casex ({aluOp, funct})
        9'b000xxxxxx: begin aluCtrOut = 4'b0010; aluSrc1 = 0; end
        9'b0x1xxxxxx: begin aluCtrOut = 4'b0110; aluSrc1 = 0; end
        9'b100xxxxxx: begin aluCtrOut = 4'b0000; aluSrc1 = 0; end
        9'b101xxxxxx: begin aluCtrOut = 4'b0001; aluSrc1 = 0; end

        9'b01x100000: begin aluCtrOut = 4'b0010; aluSrc1 = 0; end
        9'b01x100010: begin aluCtrOut = 4'b0110; aluSrc1 = 0; end
        9'b01x100100: begin aluCtrOut = 4'b0000; aluSrc1 = 0; end
        9'b01x100101: begin aluCtrOut = 4'b0001; aluSrc1 = 0; end
        9'b01x101010: begin aluCtrOut = 4'b0111; aluSrc1 = 0; end
        9'b01x000000: begin aluCtrOut = 4'b0011; aluSrc1 = 1; end // sll
        9'b01x000010: begin aluCtrOut = 4'b0100; aluSrc1 = 1; end // srl

        default: begin aluCtrOut = 4'b0; aluSrc1 = 0; end
        endcase
    end

endmodule
