`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/29 08:43:54
// Design Name: 
// Module Name: signext_tb
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


module signext_tb(

    );

    reg [15:0] inst;
    wire [31:0] data;
    
    signext u0 (inst, data);

    initial begin
        inst = 0;

        #100;
        inst = 1;

        #100;
        inst = -1;

        #100;
        inst = 2;

        #100;
        inst = -2;
    end
endmodule
