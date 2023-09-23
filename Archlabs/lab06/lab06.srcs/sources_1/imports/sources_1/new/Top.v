`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/29 08:54:36
// Design Name: 
// Module Name: Top
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


module Top(
    input Clk,
    input reset
    );

/*********************************************************************************************/
    // IF
    wire [31:0] IF_newpc;
    wire [31:0] IF_pc;
    wire [31:0] IF_inst;
    wire [31:0] IF_pcplus4;
    assign IF_pcplus4 = IF_pc + 4;

    wire pcSrc;
    wire [31:0] ID_branchpc;
    wire IF_jump;
    assign IF_jump = IF_inst[31:26] == 6'b000010 || IF_inst[31:26] == 6'b000011;
    assign IF_newpc = IF_jump ? {IF_pcplus4[31:28], IF_inst[25:0], 2'b0}
                    : (pcSrc ? ID_branchpc : IF_pc + 4);

    InstMemory instMemory (
        .address(IF_pc),
        .inst(IF_inst)
    );

    wire stall;
    Register#(.MSB(31)) PC (
        .Clk(Clk),
        .reset(reset),
        .write(!stall),
        .in(IF_newpc),
        .out(IF_pc)
    );

////////////////////////////////////////////////
    parameter IFID_MSB = 63;
    wire [IFID_MSB:0] IFID;
    // 31:0 inst 32
    // 63:32 pc+4 32
    Register#(.MSB(IFID_MSB)) IFID_reg (
        .Clk(Clk),
        .reset(reset),
        .write(1),
        .in(pcSrc || stall ? 0 : {IF_pc + 4, IF_inst}),
        .out(IFID)
    );
/*********************************************************************************************/
    // ID
    wire [31:0] ID_inst;
    wire [31:0] ID_pcplus4;
    assign ID_inst = IFID[31:0];
    assign ID_pcplus4 = IFID[63:32];

    wire [31:0] ID_imm;
    wire [31:0] ID_readData1;
    wire [31:0] ID_readData2;

    wire ID_regDst;
    wire ID_regJal;
    wire ID_aluSrc;
    wire ID_lui;
    wire ID_memToReg;
    wire ID_regWrite;
    wire ID_memRead;
    wire ID_memWrite;
    wire ID_beq;
    wire ID_bne;
    wire [2:0] ID_aluOp;
    wire ID_jr;
    wire ID_extOp;
    Ctr ctr (
        .opCode(ID_inst[31:26]),
        .funct(ID_inst[5:0]),
        .regDst(ID_regDst), // EX
        .regJal(ID_regJal), // WB EX
        .aluSrc(ID_aluSrc), // EX
        .lui(ID_lui), // EX
        .memToReg(ID_memToReg), // WB
        .regWrite(ID_regWrite), // WB
        .memRead(ID_memRead), // M
        .memWrite(ID_memWrite), // M
        .beq(ID_beq),
        .bne(ID_bne),
        .aluOp(ID_aluOp), // EX
        .jr(ID_jr),
        .extOp(ID_extOp) // ID
    );

    wire [4:0] WB_writeReg;
    wire WB_regWrite;
    wire [31:0] WB_writeData;
    Registers registers (
        .Clk(Clk),
        .reset(reset),
        .readReg1(ID_inst[25:21]),
        .readReg2(ID_inst[20:16]),
        .writeReg(WB_writeReg),
        .writeData(WB_writeData),
        .regWrite(WB_regWrite),
        .readData1(ID_readData1),
        .readData2(ID_readData2)
    );

    Signext signext (
        .extOp(ID_extOp),
        .inst(ID_inst[15:0]),
        .data(ID_imm)
    );

    wire [1:0] forwardA;
    wire [1:0] forwardB;
    wire [31:0] regData1;
    wire [31:0] regData2;
    wire [31:0] forwardALU;
    wire [31:0] MEM_writeData;
    wire [31:0] EX_pcplus4;
    wire [31:0] EX_aluRes;
    wire IDEX_regJal;
    
    assign forwardALU = IDEX_regJal ? EX_pcplus4 : EX_aluRes; // jal == 1
    assign regData1 = forwardA == 2'b10 ? forwardALU : (forwardA == 2'b01 ? MEM_writeData : ID_readData1);
    assign regData2 = forwardB == 2'b10 ? forwardALU : (forwardB == 2'b01 ? MEM_writeData : ID_readData2);

    wire ID_branch;
    assign ID_branch = (ID_beq && regData1 == regData2) || (ID_bne && regData1 != regData2);
    assign pcSrc = ID_jr || ID_branch;
    assign ID_branchpc = ID_jr ? regData1 :
        (ID_branch ? (ID_imm << 2) + ID_pcplus4 : 0); // 0 is not used

////////////////////////////////////////////////
    parameter IDEX_MSB = 142;
    wire [IDEX_MSB:0] IDEX;
    // 31:0 imm 32
    // 63:32 readData1 32
    // 95:64 readData2 32
    // 127:96 pc+4 32
    // 132:128 ID_inst[15:11] 5
    // 137:133 ID_inst[20:16] 5
    // 142:138 ID_inst[25:21] 5

    Register#(.MSB(IDEX_MSB)) IDEX_reg (
        .Clk(Clk),
        .reset(reset),
        .write(1),
        .in({ID_inst[25:21], ID_inst[20:16], ID_inst[15:11], ID_pcplus4, regData2, regData1, ID_imm}),
        .out(IDEX)
    );

// for control signals
    parameter EX_MSB = 6;
    parameter M_MSB = 2;
    parameter WB_MSB = 2;
    wire [EX_MSB:0] IDEX_EX;
    // [2:0] aluOp 3
    // [3] aluSrc 1
    // [4] regJal 1
    // [5] regDst 1
    // [6] lui 1

    wire [M_MSB:0] IDEX_M;
    // [0] beq 1
    // [1] memWrite 1
    // [2] memRead 1

    wire [WB_MSB:0] IDEX_WB;
    assign IDEX_regJal = IDEX_WB[2];
    // [0] regWrite 1
    // [1] memToReg 1
    // [2] regJal 1

    Register#(.MSB(EX_MSB)) IDEX_EX_reg (
        .Clk(Clk),
        .reset(reset),
        .write(1),
        .in({ID_lui, ID_regDst, ID_regJal, ID_aluSrc, ID_aluOp}),
        .out(IDEX_EX)
    );
    Register#(.MSB(M_MSB)) IDEX_M_reg (
        .Clk(Clk),
        .reset(reset),
        .write(1),
        .in({ID_memRead, ID_memWrite, ID_beq}),
        .out(IDEX_M)
    );
    Register#(.MSB(WB_MSB)) IDEX_WB_reg (
        .Clk(Clk),
        .reset(reset),
        .write(1),
        .in({ID_regJal, ID_memToReg, ID_regWrite}),
        .out(IDEX_WB)
    );
/*********************************************************************************************/
    // EX
    wire [31:0] EX_imm;
    wire [31:0] EX_readData1;
    wire [31:0] EX_readData2;
    assign EX_imm = IDEX[31:0];
    assign EX_readData1 = IDEX[63:32];
    assign EX_readData2 = IDEX[95:64];
    assign EX_pcplus4 = IDEX[127:96];

    wire EX_lui;
    wire EX_regDst;
    wire EX_regJal;
    wire EX_aluSrc;
    wire [2:0] EX_aluOp;
    assign EX_lui = IDEX_EX[6];
    assign EX_regDst = IDEX_EX[5];
    assign EX_regJal = IDEX_EX[4];
    assign EX_aluSrc = IDEX_EX[3];
    assign EX_aluOp  = IDEX_EX[2:0];

    wire [31:0] input1;
    wire [31:0] input2;
    wire EX_zero;
    wire [31:0] EX_branchpc;
    wire [4:0] EX_writeReg;
    assign EX_writeReg = EX_regJal ? 31 : (EX_regDst ? IDEX[132:128] : IDEX[137:133]);
    wire EX_aluSrc1;
    wire [3:0] EX_aluCtrOut;

    ALUCtr aluCtr (
        .funct(EX_imm[5:0]), 
        .aluOp(EX_aluOp),
        .lui(EX_lui),
        .aluSrc1(EX_aluSrc1),
        .aluCtrOut(EX_aluCtrOut)
    );

    ALU alu (
        .input1(input1),
        .input2(input2),
        .aluCtr(EX_aluCtrOut),
        .zero(EX_zero),
        .aluRes(EX_aluRes)
    );
 
    wire [WB_MSB:0] EXMEM_WB;
    wire [31:0] MEM_pcplus4;
    wire [31:0] MEM_aluRes;

    assign input1 = EX_aluSrc1 ? EX_imm[10:6] : EX_readData1;
    assign input2 = EX_aluSrc ? EX_imm : EX_readData2;


////////////////////////////////////////////////
    parameter EXMEM_MSB = 133;
    wire [EXMEM_MSB:0] EXMEM;
    // 31:0 readData2 32
    // 63:32 aluRes 32
    // 64:64 zero 1
    // 96:65 branchpc 32
    // 101:97 writeReg 5
    // 133:102 pc+4 32

    Register#(.MSB(EXMEM_MSB)) EXMEM_reg (
        .Clk(Clk),
        .reset(reset),
        .write(1),
        .in({EX_pcplus4, EX_writeReg, EX_branchpc, EX_zero, EX_aluRes, EX_readData2}),
        .out(EXMEM)
    );

    wire [M_MSB:0] EXMEM_M;

    Register#(.MSB(M_MSB)) EXMEM_M_reg (
        .Clk(Clk),
        .reset(reset),
        .write(1),
        .in(IDEX_M),
        .out(EXMEM_M)
    );
    Register#(.MSB(WB_MSB)) EXMEM_WB_reg (
        .Clk(Clk),
        .reset(reset),
        .write(1),
        .in(IDEX_WB),
        .out(EXMEM_WB)
    );
/*********************************************************************************************/
    // MEM
    wire [31:0] MEM_readData2;
    wire MEM_zero;
    assign MEM_aluRes = EXMEM[63:32];
    assign MEM_readData2 = EXMEM[31:0];
    assign MEM_zero = EXMEM[64];
//    assign MEM_branchpc = EXMEM[96:65];
    assign MEM_pcplus4 = EXMEM[133:102];

    wire MEM_beq;
    wire MEM_memWrite;
    wire MEM_memRead;
    assign MEM_beq   = EXMEM_M[0];
    assign MEM_memWrite = EXMEM_M[1];
    assign MEM_memRead  = EXMEM_M[2];

    wire [31:0] MEM_readData;


    DataMemory dataMemory (
        .Clk(Clk),
        .address(MEM_aluRes),
        .writeData(MEM_readData2),
        .memWrite(MEM_memWrite),
        .memRead(MEM_memRead),
        .readData(MEM_readData)
    );

    wire MEM_memToReg;
    wire MEM_regJal;
//    assign MEM_regWrite = EXMEM_WB[0];
    assign MEM_memToReg = EXMEM_WB[1];
    assign MEM_regJal   = EXMEM_WB[2];

    assign MEM_writeData = MEM_regJal ? MEM_pcplus4 : (MEM_memToReg ? MEM_readData : MEM_aluRes);

////////////////////////////////////////////////
    parameter MEMWB_MSB = 100;
    wire [MEMWB_MSB:0] MEMWB;
    // 31:0 readData 32
    // 63:32 aluRes 32
    // 68:64 writeReg 5
    // 100:69 pc+4 32

    Register#(.MSB(MEMWB_MSB)) MEMWB_reg (
        .Clk(Clk),
        .reset(reset),
        .write(1),
        .in({MEM_pcplus4, EXMEM[101:97], MEM_aluRes, MEM_readData}),
        .out(MEMWB)
    );

    wire [WB_MSB:0] MEMWB_WB;

    Register#(.MSB(WB_MSB)) MEMWB_WB_reg (
        .Clk(Clk),
        .reset(reset),
        .write(1),
        .in(EXMEM_WB),
        .out(MEMWB_WB)
    );
/*********************************************************************************************/
    // WB
    wire [31:0] WB_aluRes;
    wire [31:0] WB_readData;
    wire [31:0] WB_pcplus4;
    assign WB_aluRes = MEMWB[63:32];
    assign WB_readData = MEMWB[31:0];
    assign WB_writeReg = MEMWB[68:64];
    assign WB_pcplus4 = MEMWB[100:69];

    wire WB_memToReg;
    wire WB_regJal;
    assign WB_regWrite = MEMWB_WB[0];
    assign WB_memToReg = MEMWB_WB[1];
    assign WB_regJal   = MEMWB_WB[2];


    assign WB_writeData = WB_regJal ? WB_pcplus4 : (WB_memToReg ? WB_readData : WB_aluRes);
/*********************************************************************************************/
    Forward forward (
        .EXMEM_regWrite(IDEX_WB[0]),
        .MEMWB_regWrite(EXMEM_WB[0]),
        .EXMEM_rd(EX_writeReg),
        .MEMWB_rd(EXMEM[101:97]),
        .IDEX_rt(ID_inst[20:16]), // 20:16
        .IDEX_rs(ID_inst[25:21]), // 25:21
        .forwardA(forwardA),
        .forwardB(forwardB)
    );

    Stall stal (
        .IDEX_memRead(ID_memRead),
        .IDEX_rt(ID_inst[20:16]),
        .IFID_rs(IF_inst[25:21]),
        .IFID_rt(IF_inst[20:16]),
        .stall(stall)
    );

endmodule
