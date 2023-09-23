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
    output reg [1:0] regDst,
    output reg aluSrc,
    output reg memToReg,
    output reg regWrite,
    output reg memRead,
    output reg memWrite,
    output reg branch,
    output reg [2:0] aluOp,
    output reg [1:0] jump,
    output reg extOp
    );

    always @(opCode) begin
        case (opCode)
        6'b000000: begin // R type
            if (funct == 6'b001000) begin // jr
                regDst = 1; // x
                aluSrc = 0; // x
                memToReg = 0; // x
                regWrite = 0;
                memRead = 0; // x
                memWrite = 0;
                branch = 0; // x
                aluOp = 3'b010; // x
                jump = 2'b10;
                extOp = 0; // x
            end else begin // others
                regDst = 1;
                aluSrc = 0;
                memToReg = 0;
                regWrite = 1;
                memRead = 0;
                memWrite = 0;
                branch = 0;
                aluOp = 3'b010;
                jump = 0;
                extOp = 0; // x
            end
        end

        6'b001000: begin // addi
            regDst = 0;
            aluSrc = 1;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            branch = 0;
            aluOp = 3'b000;
            jump = 0;
            extOp = 1;
        end
        6'b001100: begin // andi
            regDst = 0;
            aluSrc = 1;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            branch = 0;
            aluOp = 3'b100;
            jump = 0;
            extOp = 0;
        end
        6'b001101: begin // ori
            regDst = 0;
            aluSrc = 1;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            branch = 0;
            aluOp = 3'b101;
            jump = 0;
            extOp = 0;
        end
        6'b100011: begin // lw
            regDst = 0;
            aluSrc = 1;
            memToReg = 1;
            regWrite = 1;
            memRead = 1;
            memWrite = 0;
            branch = 0;
            aluOp = 3'b000;
            jump = 0;
            extOp = 1;
        end
        6'b101011: begin // sw
            regDst = 0;
            aluSrc = 1;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 1;
            branch = 0;
            aluOp = 3'b000;
            jump = 0;
            extOp = 1;
        end
        6'b000100: begin // beq
            regDst = 0;
            aluSrc = 0;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 0;
            branch = 1;
            aluOp = 3'b001;
            jump = 0;
            extOp = 0; // x
        end
        6'b000010: begin // j
            regDst = 0; // x
            aluSrc = 0; // x
            memToReg = 0; // x
            regWrite = 0;
            memRead = 0; // x
            memWrite = 0;
            branch = 0; // x
            aluOp = 3'b000; // x
            jump = 1;
            extOp = 0; // x
        end
        6'b000011: begin // jal
            regDst = 2'b10;
            aluSrc = 0;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            branch = 0;
            aluOp = 3'b000;
            jump = 1;
            extOp = 0; // x
        end
        default: begin
            regDst = 0;
            aluSrc = 0;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 0;
            branch = 0;
            aluOp = 3'b000;
            jump = 0;
            extOp = 0;
        end
        endcase
    end

endmodule
