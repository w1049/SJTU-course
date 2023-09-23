`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/18 19:56:40
// Design Name: 
// Module Name: Top_tb
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


module Top_tb(

    );
    
    reg Clk;
    reg reset;

    always #(100) Clk = !Clk;
    
    Top u0 (.Clk(Clk), .reset(reset));
    
    initial begin
        Clk = 1;
        reset = 0;
        
        #100;
        reset = 1;
        #150;
        reset = 0;
    end
endmodule
