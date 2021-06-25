`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/23 22:07:35
// Design Name: 
// Module Name: regfile
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


module RegFile(
    input RF_ena,
    input RF_rst,
    input RF_clk,
    input [4:0] Rdc,
    input [4:0] Rsc,
    input [4:0] Rtc,
    input [31:0] Rd,
    output [31:0] Rs,
    output [31:0] Rt,
    input RF_W
    );
    reg [31:0] array_reg[31:0];
    always @(posedge RF_clk or posedge RF_rst) begin
        if (RF_rst) begin
            array_reg[0] <= 32'b0;
            array_reg[1] <= 32'b0;
            array_reg[2] <= 32'b0;
            array_reg[3] <= 32'b0;
            array_reg[4] <= 32'b0;
            array_reg[5] <= 32'b0;
            array_reg[6] <= 32'b0;
            array_reg[7] <= 32'b0;
            array_reg[8] <= 32'b0;
            array_reg[9] <= 32'b0;
            array_reg[10] <= 32'b0;
            array_reg[11] <= 32'b0;
            array_reg[12] <= 32'b0;
            array_reg[13] <= 32'b0;
            array_reg[14] <= 32'b0;
            array_reg[15] <= 32'b0;
            array_reg[16] <= 32'b0;
            array_reg[17] <= 32'b0;
            array_reg[18] <= 32'b0;
            array_reg[19] <= 32'b0;
            array_reg[20] <= 32'b0;
            array_reg[21] <= 32'b0;
            array_reg[22] <= 32'b0;
            array_reg[23] <= 32'b0;
            array_reg[24] <= 32'b0;
            array_reg[25] <= 32'b0;
            array_reg[26] <= 32'b0;
            array_reg[27] <= 32'b0;
            array_reg[28] <= 32'b0;
            array_reg[29] <= 32'b0;
            array_reg[30] <= 32'b0;
            array_reg[31] <= 32'b0;
//            array_reg[0] <= 32'h0;
//            array_reg[1] <= 32'h7fffffff;
//            array_reg[2] <= 32'h80000000;
//            array_reg[3] <= 32'hffffffff;
//            array_reg[4] <= 32'h7fffffff;
//            array_reg[5] <= 32'h5;
//            array_reg[6] <= 32'h6;
//            array_reg[7] <= 32'h7;
//            array_reg[8] <= 32'h8;
//            array_reg[9] <= 32'h9;
//            array_reg[10] <= 32'ha;
//            array_reg[11] <= 32'hb;
//            array_reg[12] <= 32'hc;
//            array_reg[13] <= 32'hd;
//            array_reg[14] <= 32'he;
//            array_reg[15] <= 32'hf;
//            array_reg[16] <= 32'h10;
//            array_reg[17] <= 32'h11;
//            array_reg[18] <= 32'h12;
//            array_reg[19] <= 32'h13;
//            array_reg[20] <= 32'h14;
//            array_reg[21] <= 32'h15;
//            array_reg[22] <= 32'h16;
//            array_reg[23] <= 32'h17;
//            array_reg[24] <= 32'h18;
//            array_reg[25] <= 32'h19;
//            array_reg[26] <= 32'h1a;
//            array_reg[27] <= 32'h10010000;
//            array_reg[28] <= 32'h0;
//            array_reg[29] <= 32'h10010004;
//            array_reg[30] <= 32'h0;
//            array_reg[31] <= 32'h00400278;
        end
        else begin
            if (RF_W == 1'b1 && RF_ena && Rdc != 5'b0)
                array_reg[Rdc] <= Rd;
        end
    end

    assign Rs = RF_ena ? array_reg[Rsc] : 32'bz;
    assign Rt = RF_ena ? array_reg[Rtc] : 32'bz;
endmodule