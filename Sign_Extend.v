//0713216

//Subject:     CO project 2 - Sign extend
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
`timescale 1ns/1ps
module Sign_Extend(
    data_i,
    data_o
    );
               
//I/O ports
input   [16-1:0] data_i;
output  [32-1:0] data_o;

//Internal Signals
wire     [32-1:0] data_o;

//Sign extended
assign data_o[15:0] = data_i;
assign data_o[31:16] = (data_i[15] == 1'b0) ? 16'b0 : 16'b1111111111111111;
          
endmodule      
     