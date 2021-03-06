`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/14 21:48:43
// Design Name: 
// Module Name: CLK_DIV
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


module CLK_DIV(
input clk_in,
input rst,
output clk_out
    );
   reg [2:0]counter;
        always @ (posedge clk_in or posedge rst)begin
            if(rst)begin 
                counter<=0;
            end
            else begin
                counter<=counter+1'b1;
            end
        end
        assign clk_out=counter[2];
endmodule
