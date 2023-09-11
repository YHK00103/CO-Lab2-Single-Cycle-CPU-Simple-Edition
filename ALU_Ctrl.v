//0713216

//Subject:     CO project 2 - ALU Controller
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
module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
wire        [4-1:0] ALUCtrl_o;

//Parameter
       
//Select exact operation

//opcode
//R-type (add, sub, and, or, slt) <= 000 000  
//addi <= 001 000
//slti <= 001 010
//beq <= 000 100

//Set ALU_op
//R-type <=  010
//addi <= 000
//slti  <= 011
//beq <=001

//function field
//add <= 100 000
//sub <= 100 010
//and <= 100 100
//or <= 100 101
//slt <= 101 010

assign ALUCtrl_o = (ALUOp_i == 3'b010 && funct_i == 6'b100000) ? 4'b0010 :      //add = 2
                                (ALUOp_i == 3'b010 && funct_i == 6'b100010) ? 4'b0110 :      //sub = 6
                                (ALUOp_i == 3'b010 && funct_i == 6'b100100) ? 4'b0000 :      //and = 0
                                (ALUOp_i == 3'b010 && funct_i == 6'b100101) ? 4'b0001 :      //or = 1
                                (ALUOp_i == 3'b010 && funct_i == 6'b101010) ? 4'b0111 :      //slt = 7
                                (ALUOp_i == 3'b000) ? 4'b1000 :                                              //addi = 8
                                (ALUOp_i == 3'b011) ? 4'b0101 :                                              //slti = 5
                                (ALUOp_i == 3'b001) ? 4'b1010 : 4'b0000;                               //beq = 10

endmodule     





                    
                    