`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/22 11:12:17
// Design Name: 
// Module Name: ALU_tb
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


module ALU_tb(

    );

    reg [31:0] input1;
    reg [31:0] input2;
    reg [3:0] aluCtr;
    wire zero;
    wire [31:0] aluRes;

    Alu alu(input1, input2, aluCtr, zero, aluRes);

    initial begin
        input1 = 0;
        input2 = 0;
        aluCtr = 0;

        #100;
        #100 begin input1 = 15; input2 = 10; aluCtr = 4'b0000; end
        #100 aluCtr = 4'b0001;
        #100 aluCtr = 4'b0010;
        #100 aluCtr = 4'b0110;
        #100 begin input1 = 10; input2 = 15; end
        #100 begin aluCtr = 4'b0111; input1 = 15; input2 = 10; end
        #100 begin input1 = 10; input2 = 15; end
        #100 begin aluCtr = 4'b1100; input1 = 1; input2 = 1; end
        #100 input1 = 16;
    end

endmodule
