`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2025 18:16:01
// Design Name: 
// Module Name: incrementer_8bit
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


        module incrementer_8bit(
            input  [7:0] Q_in,
            output [7:0] Q_out
        );
        assign Q_out = Q_in + 1;
        endmodule