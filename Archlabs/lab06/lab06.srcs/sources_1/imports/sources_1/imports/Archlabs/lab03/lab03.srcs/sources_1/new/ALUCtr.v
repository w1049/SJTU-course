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
    input lui,
    output reg aluSrc1,
    output reg [3:0] aluCtrOut
    );
    // aluOp: 000 = add, 001 = sub, 010 = funct
    //        100 = and, 101 = or, 110 = ?
    always @(aluOp or funct or lui) begin
        casex ({aluOp, funct})
        9'b000xxxxxx: begin aluCtrOut = 4'b0010; aluSrc1 = 0; end // addi
        9'b001xxxxxx: begin aluCtrOut = 4'b0110; aluSrc1 = 0; end // subi
        9'b100xxxxxx: begin aluCtrOut = 4'b0000; aluSrc1 = 0; end // andi
        9'b101xxxxxx: begin aluCtrOut = 4'b0001; aluSrc1 = 0; end // ori
        9'b110xxxxxx: begin aluCtrOut = 4'b1101; aluSrc1 = 0; end // xori
        9'b011xxxxxx: begin aluCtrOut = 4'b0111; aluSrc1 = 0; end // slti
        9'b111xxxxxx: begin aluCtrOut = 4'b1000; aluSrc1 = 0; end // sltiu

        9'b010100001: begin aluCtrOut = 4'b0010; aluSrc1 = 0; end // addu
        9'b010100000: begin aluCtrOut = 4'b0010; aluSrc1 = 0; end // add
        9'b010100011: begin aluCtrOut = 4'b0110; aluSrc1 = 0; end // subu
        9'b010100010: begin aluCtrOut = 4'b0110; aluSrc1 = 0; end // sub
        9'b010100100: begin aluCtrOut = 4'b0000; aluSrc1 = 0; end // and
        9'b010100101: begin aluCtrOut = 4'b0001; aluSrc1 = 0; end // or
        9'b010100110: begin aluCtrOut = 4'b1101; aluSrc1 = 0; end // xor
        9'b010100111: begin aluCtrOut = 4'b1100; aluSrc1 = 0; end // nor
        9'b010101011: begin aluCtrOut = 4'b1000; aluSrc1 = 0; end // sltu
        9'b010101010: begin aluCtrOut = 4'b0111; aluSrc1 = 0; end // slt
        9'b010000100: begin aluCtrOut = 4'b0011; aluSrc1 = 0; end // sllv
        9'b010000000: begin aluCtrOut = 4'b0011; aluSrc1 = 1; end // sll
        9'b010000110: begin aluCtrOut = 4'b0100; aluSrc1 = 0; end // srlv
        9'b010000010: begin aluCtrOut = 4'b0100; aluSrc1 = 1; end // srl
        9'b010000111: begin aluCtrOut = 4'b0101; aluSrc1 = 0; end // srav
        9'b010000011: begin aluCtrOut = 4'b0101; aluSrc1 = 1; end // sra
        default: begin aluCtrOut = 4'b0; aluSrc1 = 0; end
        endcase
        if (lui) begin
            aluCtrOut = 4'b1111;
            aluSrc1 = 0; // x
        end
    end

endmodule
