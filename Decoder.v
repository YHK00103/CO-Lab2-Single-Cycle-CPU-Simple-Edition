//0713216

//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      Luke
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
`timescale 1ns/1ps
module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
 
//Internal Signals
wire    [3-1:0] ALU_op_o;
wire            ALUSrc_o;
wire            RegWrite_o;
wire            RegDst_o;
wire            Branch_o;

//opcode
//R-type (add, sub, and, or, slt) <= 000 000  
//addi <= 001 000
//slti <= 001 010
//beq <= 000 100

//Set ALU_op
//R-type <=  010
//addi <= 000
//slti <= 011
//beq <= 001

//Parameter
assign RegDst_o = (instr_op_i == 6'b000000) ? 1'b1 : 1'b0;                                                      //R-type : RegDst = 1, otherwise : RegDst = 0
assign RegWrite_o = (instr_op_i != 6'b000100) ? 1'b1 : 1'b0;                                                    //R-type / addi : RegWrite = 1, beq : RegWrite = 0
assign Branch_o = (instr_op_i == 6'b000100) ? 1'b1 : 1'b0;                                                      //beq : Branch = 1, otherwise : Branch = 0
assign ALUSrc_o = (instr_op_i == 6'b001000 || instr_op_i == 6'b001010) ? 1'b1 : 1'b0;           //addi / slti : ALUsrc = 1, otherwise : ALUsrc = 0
assign ALU_op_o = (instr_op_i == 6'b000000) ? 3'b010 :                                                          //R-type <= 010
                                (instr_op_i == 6'b001000) ? 3'b000 :                                                          //addi <= 000
								(instr_op_i == 6'b001010) ? 3'b011 :  3'b001;                                             //slti <= 011
							//	(instr_op_i == 6'b000100) ? 3'b001;                                                           //beq <= 001

//Main function

endmodule





                    
                    