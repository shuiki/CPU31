`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/22 17:15:37
// Design Name: 
// Module Name: CPU
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


module CPU(
    input clk,
    input rst,
    output DM_ena,
    output DM_W,
    output DM_R,
    input [31:0] IM_inst,
    input [31:0] DM_rdata,
    output [31:0] DM_wdata,
    output [31:0] PC_out,
    output [31:0] alu_out
    );
    
           wire _add, _addu, _sub, _subu, _and, _or, _xor, _nor;
           wire _slt, _sltu, _sll, _srl, _sra, _sllv, _srlv, _srav, _jr;
           wire  _addi, _addiu, _andi, _ori, _xori, _lw, _sw;
           wire _beq, _bne, _slti, _sltiu, _lui, _j, _jal;
           
           //1~17
           assign _add = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b100000)?1'b1:1'b0;
           assign _addu = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b100001)?1'b1:1'b0;
           assign _sub = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b100010)?1'b1:1'b0;
           assign _subu = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b100011)?1'b1:1'b0;
           assign _and = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b100100)?1'b1:1'b0;
           assign _or = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b100101)?1'b1:1'b0;
           assign _xor = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b100110)?1'b1:1'b0;
           assign _nor = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b100111)?1'b1:1'b0;
           
           assign _slt = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b101010)?1'b1:1'b0;
           assign _sltu = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b101011)?1'b1:1'b0;
           assign _sll = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b000000)?1'b1:1'b0;
           assign _srl = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b000010)?1'b1:1'b0;
           assign _sra = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b000011)?1'b1:1'b0;
           assign _sllv = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b000100)?1'b1:1'b0;
           assign _srlv = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b000110)?1'b1:1'b0;
           assign _srav = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b000111)?1'b1:1'b0;
           assign _jr = (IM_inst[31:26]==6'b000000&&IM_inst[5:0]==6'b001000)?1'b1:1'b0;
           
           //18~29
           assign _addi = (IM_inst[31:26]==6'b001000)?1'b1:1'b0;
           assign _addiu = (IM_inst[31:26]==6'b001001)?1'b1:1'b0;
           assign _andi = (IM_inst[31:26]==6'b001100)?1'b1:1'b0;
           assign _ori = (IM_inst[31:26]==6'b001101)?1'b1:1'b0;
           assign _xori = (IM_inst[31:26]==6'b001110)?1'b1:1'b0;
           assign _lw = (IM_inst[31:26]==6'b100011)?1'b1:1'b0;
           assign _sw = (IM_inst[31:26]==6'b101011)?1'b1:1'b0;
           assign _beq = (IM_inst[31:26]==6'b000100)?1'b1:1'b0;
           assign _bne = (IM_inst[31:26]==6'b000101)?1'b1:1'b0;
           assign _slti = (IM_inst[31:26]==6'b001010)?1'b1:1'b0;
           assign _sltiu = (IM_inst[31:26]==6'b001011)?1'b1:1'b0;
           assign _lui = (IM_inst[31:26]==6'b001111)?1'b1:1'b0;
           
           //30 31
           assign _j = (IM_inst[31:26]==6'b000010)?1'b1:1'b0;
           assign _jal = (IM_inst[31:26]==6'b000011)?1'b1:1'b0;
           
           wire [4:0] Rsc,Rdc,Rtc;
           assign Rsc=(_sll||_srl||_sra||_lui||_j||_jal)?5'bz:IM_inst[25:21];
           assign Rtc=(_j||_jal)?5'bz:IM_inst[20:16];
           assign Rdc=(_add|_addu||_sub||_subu||_and||_or||_xor||_nor||_slt||_sltu||_sll||_srl||_sra||_sllv||_srlv||_srav)?IM_inst[15:11]:5'bz;
           
           wire [3:0]ALUC;
           assign ALUC[0]=_sub||_subu||_or||_nor||_slt||_srl||_srlv||_ori||_beq||_bne||_slti;
           assign ALUC[1]=_sub||_xor||_nor||_sll||_sllv||_addi||_xori||_lw||_sw||_beq||_bne||_jal||_slti||_sltiu||_slt||_sltu;
           assign ALUC[2]=_and||_or||_xor||_nor||_sll||_srl||_sra||_sllv||_srlv||_srav||_andi||_ori||_xori;
           assign ALUC[3]=_sll||_srl||_sra||_sllv||_srlv||_srav||_lui||_slti||_sltiu||_slt||_sltu;
           
            wire[1:0] M1,M2,M3,M4,M6;
            wire M5;
            wire zeroFlag,carryFlag,negFlag,overflowFlag;//ALU.Z
           
           wire RF_W;
           assign RF_W=(_add&&!overflowFlag)||_addu||(_sub&&!overflowFlag)||_subu||_and||_or||_xor||_nor||_slt||_sltu||_sll||_srl||_sra||_sllv||_srlv||_srav||(_addi&&!overflowFlag)||_addiu||_andi||_ori||_xori||_lw||_slti||_sltiu||_lui||_jal;
    //_add||_addu||_sub||_subu||_and||_or||_xor||_nor||_slt||_sltu||_sll||_srl||_sra||_sllv||_srlv||_srav||_jr||_addi||_addiu||_andi||_ori||_xori||_lw||_sw||_beq||_bne||_slti||_sltiu||_lui||_j||_jal;       
           wire [31:0]pc,npc,Rs,Rt,Rd,alu_rslt;
           assign PC_out=pc;
           assign npc=pc+32'd4;
           assign alu_out=alu_rslt;
           wire DM_CS;
           assign DM_CS=_lw||_sw;
           assign DM_R=_lw;
           assign DM_W=_sw;
           assign DM_ena=DM_CS;
           assign DM_wdata=DM_W?Rt:32'bz;
           
          
           
           assign M1[1]=_beq||_bne||_j||_jal;
           assign M1[0]=_add||_addu||_sub||_subu||_and||_or||_xor||_nor||_slt||_sltu||_sll||_srl||_sra||_sllv||_srlv||_srav||_addi||_addiu||_andi||_ori||_xori||_lw||_sw||_slti||_sltiu||_lui||_j||_jal;
           assign M2[1]=_lw;
           assign M2[0]=_lw||_lui;
           assign M3[1]=_add||_addu||_sub||_subu||_and||_or||_xor||_nor||_slt||_sltu||_sllv||_srlv||_srav||_addi||_addiu||_andi||_ori||_xori||_lw||_sw||_beq||_bne||_slti||_sltiu;       
           assign M3[0]=_sll||_srl||_sra;
           assign M4[1]=_addi||_addiu||_lw||_sw||_slti||_sltiu||_jal;
           assign M4[0]=_andi||_ori||_xori||_jal;
           assign M6[1]=_jal;
           assign M6[0]=_addi||_addiu||_andi||_ori||_xori||_lw||_slti||_sltiu||_lui||_jal;
           
           assign M5=_beq?zeroFlag:_bne?(!zeroFlag):1'bz;
           
       
           
           wire[31:0] rslt_1,rslt_2,rslt_3,rslt_4,rslt_5,rslt_6;
           
           wire [31:0] EXT18,HEXT16,UEXT16,SEXT16,EXT5,EXT1,combiner,adder;
           
           wire [15:0]imm_16=(_addi||_addiu||_andi||_ori||_xori||_lw||_sw||_beq||_bne||_slti||_sltiu||_lui)?IM_inst[15:0]:16'bz;
           wire [25:0]address=(_j||_jal)?IM_inst[25:0]:26'bz;
           wire [4:0]shamt=(_sll||_srl||_sra)?IM_inst[10:6]:5'bz;
         
           
           assign EXT18=imm_16[15]==1?{14'b11111111111111,imm_16,2'b00}:{14'b0,imm_16,2'b00};
           assign HEXT16={imm_16,16'b0};
           assign UEXT16={16'b0,imm_16};
           assign SEXT16=imm_16[15]==1?{16'b1111111111111111,imm_16}:{16'b0,imm_16};
           assign EXT5={27'b0,shamt};
           assign EXT1={30'b0,negFlag};
           assign combiner={pc[31:28],address,2'b0};
           assign adder=EXT18+npc;
           
           
           
           PcReg pcreg(
               .clk(clk),
               .rst(rst),
               .ena(1),
               .PR_in(rslt_1),
               .PR_out(pc)
               );
           
           alu cpu_alu(
               .a(rslt_3),
               .b(rslt_4),
               .aluc({ALUC}),
               .r(alu_rslt),
               .zero(zeroFlag),
               .carry(carryFlag),
               .negative(negFlag),
               .overflow(overflowFlag)
               );
           
           RegFile cpu_ref(
               .RF_ena(1'b1),
               .RF_rst(rst),
               .RF_clk(clk),
               .Rdc(rslt_6[4:0]),
               .Rsc(Rsc),
               .Rtc(Rtc),
               .Rd(rslt_2),
               .Rs(Rs),
               .Rt(Rt),
               .RF_W(RF_W)
           );
           
           assign rslt_5=(M5==0)?npc:adder;
           
           MUX4 MUX1(
           .index(M1),
           .a(Rs),
           .b(npc),
           .c(rslt_5),
           .d(combiner),
           .result(rslt_1)
           );
           
           MUX4 MUX2(
           .index(M2),
           .a(alu_rslt),
           .b(HEXT16),
           .c(EXT1),
           .d(DM_rdata),
           .result(rslt_2)
           );
           
           MUX4 MUX3(
           .index(M3),
           .a(pc),
           .b(EXT5),
           .c(Rs),
           .d(Rs),
           .result(rslt_3)
           );
           
           MUX4 MUX_4(
           .index(M4),
           .a(Rt),
           .b(UEXT16),
           .c(SEXT16),
           .d(32'd4),
           .result(rslt_4)
           );
           
           MUX4 MUX6(
           .index(M6),
           .a(Rdc),
           .b(Rtc),
           .c(5'd31),
           .d(5'd31),
           .result(rslt_6)
           );
       
endmodule
