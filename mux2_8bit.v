`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2025 18:08:59
// Design Name: 
// Module Name: mux2_8bit
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


                module mux2_8bit(
                    input  [7:0] A,
                    input  [7:0] B,
                    input        Sel,
                    output [7:0] Y
                );
                assign Y = (Sel) ? B : A;
                endmodule 
