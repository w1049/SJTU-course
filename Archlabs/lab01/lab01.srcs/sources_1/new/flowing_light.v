`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/15 08:42:40
// Design Name: 
// Module Name: flowing_light
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


module flowing_light (
//    input clock_p,
//    input clock_n,
    input clock,
    input reset,
    output [7:0] led
    );
//    reg [23:0] cnt_reg;
    reg [1:0] cnt_reg;
    reg [7:0] light_reg;

//    IBUFGDS IBUFGDS_inst (
//        .O(CLK_i),
//        .I(clock_p),
//        .IB(clock_n)
//        );

//    always @(posedge CLK_i) begin
    always @(posedge clock) begin
//        if (!reset)
        if (reset)
            cnt_reg <= 0;
        else
            cnt_reg <= cnt_reg + 1;
    end
    
//    always @(posedge CLK_i) begin
    always @(posedge clock) begin
//        if (!reset)
        if (reset)
            light_reg <= 8'h01;
//        else if (cnt_reg == 24'hffffff) begin
        else if (cnt_reg == 2'h3) begin
            if (light_reg == 8'h80)
                light_reg <= 8'h01;
            else
                light_reg <= light_reg << 1;
        end
    end

    assign led = light_reg;
endmodule
