`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/22 09:07:12
// Design Name: 
// Module Name: Ctr
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


module Ctr(
    input [5:0] opCode,
    input [5:0] funct,
    output reg regDst,
    output reg regJal,
    output reg aluSrc,
    output reg lui,
    output reg memToReg,
    output reg regWrite,
    output reg memRead,
    output reg memWrite,
    output reg beq,
    output reg bne,
    output reg [2:0] aluOp,
    output reg jr,
    output reg extOp
    );

    always @(opCode or funct) begin
        case (opCode)
        6'b000000: begin // R type
            if (funct == 6'b001000) begin // jr
                regDst = 1; // x
                regJal = 0; // x
                aluSrc = 0; // x
                lui = 0;
                memToReg = 0; // x
                regWrite = 0;
                memRead = 0; // x
                memWrite = 0;
                beq = 0;
                bne = 0; // x
                aluOp = 3'b010; // x
                jr = 1;
                extOp = 0; // x
            end else begin // others
                regDst = 1;
                regJal = 0;
                aluSrc = 0;
                lui = 0;
                memToReg = 0;
                regWrite = 1;
                memRead = 0;
                memWrite = 0;
                beq = 0;
                bne = 0;
                aluOp = 3'b010;
                jr = 0;
                extOp = 0; // x
            end
        end

        6'b001000: begin // addi
            regDst = 0;
            regJal = 0;
            aluSrc = 1;
            lui = 0;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            beq = 0;
            bne = 0;
            aluOp = 3'b000;
            jr = 0;
            extOp = 1;
        end
        6'b001001: begin // addiu
            regDst = 0;
            regJal = 0;
            aluSrc = 1;
            lui = 0;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            beq = 0;
            bne = 0;
            aluOp = 3'b000;
            jr = 0;
            extOp = 0;
        end
        6'b001100: begin // andi
            regDst = 0;
            regJal = 0;
            aluSrc = 1;
            lui = 0;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            beq = 0;
            bne = 0;
            aluOp = 3'b100;
            jr = 0;
            extOp = 0;
        end
        6'b001101: begin // ori
            regDst = 0;
            regJal = 0;
            aluSrc = 1;
            lui = 0;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            beq = 0;
            bne = 0;
            aluOp = 3'b101;
            jr = 0;
            extOp = 0;
        end
        6'b001110: begin // xori
            regDst = 0;
            regJal = 0;
            aluSrc = 1;
            lui = 0;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            beq = 0;
            bne = 0;
            aluOp = 3'b110;
            jr = 0;
            extOp = 0;
        end
        6'b001111: begin // lui
            regDst = 0;
            regJal = 0;
            aluSrc = 1;
            lui = 1;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            beq = 0;
            bne = 0;
            aluOp = 3'b011;
            jr = 0;
            extOp = 0; // x
        end
        6'b001010: begin // slti
            regDst = 0;
            regJal = 0;
            aluSrc = 1;
            lui = 0;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            beq = 0;
            bne = 0;
            aluOp = 3'b011;
            jr = 0;
            extOp = 1;
        end
        6'b001011: begin // sltiu
            regDst = 0;
            regJal = 0;
            aluSrc = 1;
            lui = 0;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            beq = 0;
            bne = 0;
            aluOp = 3'b111;
            jr = 0;
            extOp = 0;
        end
        6'b100011: begin // lw
            regDst = 0;
            regJal = 0;
            aluSrc = 1;
            lui = 0;
            memToReg = 1;
            regWrite = 1;
            memRead = 1;
            memWrite = 0;
            beq = 0;
            bne = 0;
            aluOp = 3'b000;
            jr = 0;
            extOp = 1;
        end
        6'b101011: begin // sw
            regDst = 0;
            regJal = 0;
            aluSrc = 1;
            lui = 0;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 1;
            beq = 0;
            bne = 0;
            aluOp = 3'b000;
            jr = 0;
            extOp = 1;
        end
        6'b000101: begin // bne
            regDst = 0;
            regJal = 0;
            aluSrc = 0;
            lui = 0;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 0;
            beq = 0;
            bne = 1;
            aluOp = 3'b001; // x
            jr = 0;
            extOp = 0; // x
        end
        6'b000100: begin // beq
            regDst = 0;
            regJal = 0;
            aluSrc = 0;
            lui = 0;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 0;
            beq = 1;
            bne = 0;
            aluOp = 3'b001; // x
            jr = 0;
            extOp = 0; // x
        end
        6'b000010: begin // j
            regDst = 0; // x
            regJal = 0; // x
            aluSrc = 0; // x
            lui = 0;
            memToReg = 0; // x
            regWrite = 0;
            memRead = 0; // x
            memWrite = 0;
            beq = 0;
            bne = 0; // x
            aluOp = 3'b000; // x
            jr = 0;
            extOp = 0; // x
        end
        6'b000011: begin // jal
            regDst = 0;
            regJal = 1;
            aluSrc = 0;
            lui = 0;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            beq = 0;
            bne = 0;
            aluOp = 3'b000;
            jr = 0;
            extOp = 0; // x
        end
        default: begin
            regDst = 0;
            regJal = 0;
            aluSrc = 0;
            lui = 0;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 0;
            beq = 0;
            bne = 0;
            aluOp = 3'b000;
            jr = 0;
            extOp = 0;
        end
        endcase
    end

endmodule
