`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/29 09:46:29
// Design Name: 
// Module Name: InstMemory
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


module InstMemory(
    input Clk,
    input reset,
    input [31:0] address,
    output [31:0] inst
    );
    
    reg [31:0] instFile[0:63];
    initial begin
        $readmemb("Instruction", instFile);
    end

    always @(posedge Clk) begin
        if (reset) begin
            instFile[0]  <= 32'b10001100011000010000000000000000;
            instFile[1]  <= 32'b10001100011000100000000000000100;
            instFile[2]  <= 32'b00000000000000100010000001000010;
            instFile[3]  <= 32'b00000000000001000010100001000000;
            instFile[4]  <= 32'b00010000101000100000000000000001;
            instFile[5]  <= 32'b00000001000000010100000000100000;
            instFile[6]  <= 32'b00000000000000100001000001000010;
            instFile[7]  <= 32'b00000000000000010000100001000000;
            instFile[8]  <= 32'b00010000010000110000000000000001;
            instFile[9] <= 32'b00001000000000000000000000000010;
            instFile[10] <= 32'b10101100011010000000000000001000;
            instFile[11] <= 32'b00001000000000000000000000001100;
            // instFile[0] <=  32'b00000000000000000000000000000000;
            // instFile[1] <=  32'b10001100011000010000000000000000;
            // instFile[2] <=  32'b10001100011000100000000000000100;
            // instFile[3] <=  32'b00000000000000100010000001000010;
            // instFile[4] <=  32'b00000000000001000010100001000000;
            // instFile[5] <=  32'b00010000101000100000000000000001;
            // instFile[6] <=  32'b00000001000000010100000000100000;
            // instFile[7] <=  32'b00000000000000100001000001000010;
            // instFile[8] <=  32'b00000000000000010000100001000000;
            // instFile[9] <=  32'b00010000010000110000000000000001;
            // instFile[10] <= 32'b00001000000000000000000000000011;
            // instFile[11] <= 32'b10101100011010000000000000001000;
            // instFile[12] <= 32'b00001000000000000000000000001100;
        end
    end
    
    assign inst = instFile[address >> 2];

endmodule
