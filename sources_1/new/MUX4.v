`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/22 17:15:37
// Design Name: 
// Module Name: MUX4
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


module MUX4(
input [1:0]index,
input [31:0]a,
input [31:0]b,
input [31:0]c,
input [31:0]d,
output[31:0]result
    );
    
    assign result=(index==2'b00)?a:(index==2'b01)?b:(index==2'b10)?c:(index==2'b11)?d:32'bz;
endmodule
