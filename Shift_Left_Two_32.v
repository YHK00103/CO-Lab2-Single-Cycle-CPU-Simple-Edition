//0713216

//Subject:      CO project 2 - Shift_Left_Two_32
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
`timescale 1ns/1ps
module Shift_Left_Two_32(
    data_i,
    data_o
    );

//I/O ports                    
input [32-1:0] data_i;
output [32-1:0] data_o;

wire [32-1:0] data_o;

//shift left 2
assign data_o[31:2] = data_i[29:0];
assign data_o[1:0] = 2'b0;
     
endmodule
