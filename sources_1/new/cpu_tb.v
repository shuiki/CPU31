`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/24 18:37:41
// Design Name: 
// Module Name: cpu_tb
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


module cpu_tb();
reg clk,rst;
reg[31:0] instr;
CPU cpu(
        .clk(clk),.rst(rst), .IM_inst(instr), .DM_rdata(r_data),
        .DM_ena(dena), .DM_W(dw), .DM_R(dr), .DM_wdata(w_data), .PC_out(pc),.alu_out(res)
    );
initial 
begin
clk=0;
rst=1;
instr=32'b0;

#50 rst=0;
#400 instr=32'h2000ffff;
end
always
begin
#10 clk=~clk;
end

endmodule
