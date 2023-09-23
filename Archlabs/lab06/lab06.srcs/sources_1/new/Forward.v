`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/18 21:43:12
// Design Name: 
// Module Name: Forward
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


module Forward(
    input EXMEM_regWrite,
    input MEMWB_regWrite,
    input [4:0] EXMEM_rd,
    input [4:0] MEMWB_rd,
    input [4:0] IDEX_rt,
    input [4:0] IDEX_rs,
    output reg [1:0] forwardA,
    output reg [1:0] forwardB
    );

    always @(*) begin
        forwardA = 2'b00;
        forwardB = 2'b00;

        // EX/MEM
        if (EXMEM_regWrite && EXMEM_rd != 0) begin
            if (EXMEM_rd == IDEX_rs)
                forwardA = 2'b10;
            if (EXMEM_rd == IDEX_rt)
                forwardB = 2'b10;
        end

        // MEM/WB
        if (MEMWB_regWrite && MEMWB_rd != 0 && !(EXMEM_regWrite && EXMEM_rd != 0 && EXMEM_rd == IDEX_rs))
            if (MEMWB_rd == IDEX_rs)
                forwardA = 2'b01;
        
        if (MEMWB_regWrite && MEMWB_rd != 0 && !(EXMEM_regWrite && EXMEM_rd != 0 && EXMEM_rd == IDEX_rt))
            if (MEMWB_rd == IDEX_rt)
                forwardB = 2'b01;
    end
endmodule
