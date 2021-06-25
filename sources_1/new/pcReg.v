`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/22 17:15:37
// Design Name: 
// Module Name: pcReg
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


module PcReg(
    input clk,
    input rst,
    input ena,
    input [31:0] PR_in,
    output [31:0] PR_out
    );
    reg [31:0] PcRegister;
    always @(negedge clk or posedge rst) begin
        if (ena) begin
            if (rst) begin
                PcRegister <= 32'h00400000;
//                  PcRegister<=32'h004002e4;
            end
            else begin
                PcRegister <= PR_in;
            end
        end
    end

      assign PR_out = rst?32'h00400000:PcRegister;
      //assign PR_out =rst?32'h004002e4:PcRegister;
endmodule
