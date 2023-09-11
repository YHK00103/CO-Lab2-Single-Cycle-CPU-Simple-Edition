//0713216

//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Simple_Single_CPU(
        clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles
//PC
wire [31:0] pc_out;
wire [31:0] pc_in;

//Adder1
wire [31:0] sum1;

//Instruction_memory
wire [31:0] instruction;

//MUX size5
wire [4:0] Write_Reg;

//Register_File
wire [31:0] RS_data;
wire [31:0] RT_data;

//Decoder
wire RegDst;
wire RegWrite;
wire Branch;
wire ALUSrc;
wire [2:0] ALUop;

//ALU_control
wire [3:0] ALU_control_output;

//sign_extension
wire [31:0] sign_extension_output;

//MUX size32
wire [31:0] MUX_output;

//ALU
wire [31:0] ALU_result;
wire Zero;

//Adder2
wire [31:0] sum2;

//Shifter
wire [31:0] shift_left_output;

//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(pc_in) ,   //32 bits
	    .pc_out_o(pc_out)    // 32 bits
	    );
	
Adder Adder1(
        .src1_i(32'd4),     
	    .src2_i(pc_out),     
	    .sum_o(sum1)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(pc_out),  
	    .instr_o(instruction)    
	    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instruction[20:16]),
        .data1_i(instruction[15:11]),
        .select_i(RegDst),
        .data_o(Write_Reg)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(instruction[25:21]) ,  
        .RTaddr_i(instruction[20:16]) ,  
        .RDaddr_i(Write_Reg) ,  
        .RDdata_i(ALU_result)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(RS_data) ,  
        .RTdata_o(RT_data)   
        );
	
Decoder Decoder(
        .instr_op_i(instruction[31:26]), 
	    .RegWrite_o(RegWrite), 
	    .ALU_op_o(ALUop),   
	    .ALUSrc_o(ALUSrc),   
	    .RegDst_o(RegDst),   
		.Branch_o(Branch)   
	    );

ALU_Ctrl AC(
        .funct_i(instruction[5:0]),   
        .ALUOp_i(ALUop),   
        .ALUCtrl_o(ALU_control_output) 
        );
	
Sign_Extend SE(
        .data_i(instruction[15:0]),
        .data_o(sign_extension_output)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(RT_data),
        .data1_i(sign_extension_output),
        .select_i(ALUSrc),
        .data_o(MUX_output)
        );	
		
ALU  ALU(
         .src1_i(RS_data),
         .src2_i(MUX_output),
         .ctrl_i(ALU_control_output),
         .result_o(ALU_result),
         .zero_o(Zero)
         );
		
Adder Adder2(
        .src1_i(sum1),     
	    .src2_i(shift_left_output),     
	    .sum_o(sum2)      
	    );
		
Shift_Left_Two_32 Shifter(
        .data_i(sign_extension_output),
        .data_o(shift_left_output)
        ); 		
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(sum1),
        .data1_i(sum2),
        .select_i(Branch & Zero),
        .data_o(pc_in)
        );	

endmodule