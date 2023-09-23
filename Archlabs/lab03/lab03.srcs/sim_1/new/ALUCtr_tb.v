`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/22 10:20:31
// Design Name: 
// Module Name: ALUCtr_tb
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


module ALUCtr_tb(

    );

    reg [5:0] Funct;
    reg [1:0] ALUOp;
    wire [3:0] ALUCtrOut;

    ALUCtr aluCtr (
        .funct(Funct),
        .aluOp(ALUOp),
        .aluCtrOut(ALUCtrOut)
    );

    initial begin
        Funct = 0;
        ALUOp = 0;

        #100;
        #100 begin ALUOp = 2'b00; Funct = 8'bxxxxxx; end
        #100 begin ALUOp = 2'b01; Funct = 8'bxxxxxx; end
        #100 begin ALUOp = 2'b10; Funct = 8'bxx0000; end
        #100 begin ALUOp = 2'b10; Funct = 8'bxx0010; end
        #100 begin ALUOp = 2'b10; Funct = 8'bxx0100; end
        #100 begin ALUOp = 2'b10; Funct = 8'bxx0101; end
        #100 begin ALUOp = 2'b10; Funct = 8'bxx1010; end
    end
endmodule
