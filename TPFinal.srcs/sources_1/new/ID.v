`timescale 1ns / 1ps

module ID(
    // INPUTS
    input wire clk,
    input wire reset,
    input wire [31:0] in_instruction,        //Entrada proveniente del latch 1 IF/ID
    input wire [31:0] in_if_add,             //Entrada proveniente del latch 1 IF/ID
    input wire [31:0] in_wb_mux,             //Entrada proveniente de la etapa WB
    input wire [4:0] in_write_register,
	input wire in_noStall,
    // Control WB
    input wire in_RegWrite,
    input wire step,
    input wire in_jal,
    input wire in_jalr,
	
    // OUTPUTS
    output wire [5:0] out_opcode,          
    output wire [31:0] out_read_data1,   //Salida de la etapa id, modulo Regs
    output wire [31:0] out_read_data2,   //Salida de la etapa id, modulo Regs
    output wire [31:0] out_sign,
    output wire [4:0] ID_RegisterRd,
    output wire [4:0] ID_RegisterRt,
    output wire [4:0] ID_RegisterRs,
    output wire taken,
	output reg out_RegDst, 
    output wire out_Branch,
    output reg out_MemRead,
    output reg out_MemtoReg,
    output reg [5:0] out_ALUOp,
    output reg out_MemWrite,
    output reg out_ALUSrc,
    output reg out_RegWrite,
    output reg out_op_shamt,
    output reg out_enable_pc,
    output wire [31:0] out_instruction,
    output wire [31:0] out_if_add,
    output wire [31:0] reg_0,
    output wire [31:0] reg_1,
    output wire [31:0] reg_2,
    output wire [31:0] reg_3,
    output wire [31:0] reg_4,
    output wire [31:0] reg_5,
    output wire [31:0] reg_6,
    output wire [31:0] reg_7,
    output wire [31:0] reg_8,
    output wire [31:0] reg_9,
    output wire [31:0] reg_10,
    output wire [31:0] reg_11,
    output wire [31:0] reg_12,
    output wire [31:0] reg_13,
    output wire [31:0] reg_14,
    output wire [31:0] reg_15,
    output wire [31:0] reg_16,
    output wire [31:0] reg_17,
    output wire [31:0] reg_18,
    output wire [31:0] reg_19,
    output wire [31:0] reg_20,
    output wire [31:0] reg_21,
    output wire [31:0] reg_22,
    output wire [31:0] reg_23,
    output wire [31:0] reg_24,
    output wire [31:0] reg_25,
    output wire [31:0] reg_26,
    output wire [31:0] reg_27,
    output wire [31:0] reg_28,
    output wire [31:0] reg_29,
    output wire [31:0] reg_30,
    output wire [31:0] reg_31
    );
    
	wire RegDst, MemRead, MemtoReg;
    wire [5:0] ALUOp;
    wire MemWrite, ALUSrc, RegWrite, op_shamt, enable_pc;
    wire [31:0] out_filtro;    
	
    Regs registers(
        clk, reset, in_RegWrite, in_instruction[25:21], in_instruction[20:16],
            in_write_register,out_filtro,in_instruction[15:11],in_if_add,in_jal,
            in_jalr,step,
        out_read_data1, out_read_data2,reg_0,reg_1,reg_2,reg_3,reg_4,reg_5,reg_6,reg_7,
            reg_8,reg_9,reg_10,reg_11,reg_12,reg_13,reg_14,reg_15,reg_16,reg_17,reg_18,
            reg_19,reg_20,reg_21,reg_22,reg_23,reg_24,reg_25,reg_26,reg_27,reg_28,reg_29,
            reg_30,reg_31 
        );
    SE sign_extend(
        in_instruction[15:0], 
        out_sign
        );
    CONTROL control(
        reset, in_instruction[31:26], in_instruction[5:2], in_instruction,
        RegDst, out_Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite,
            op_shamt,enable_pc
        );

    FiltroLoad filtro_load(
        in_instruction[5:0],in_wb_mux,
        out_filtro
        );
        
	// MUX
	always@(*) 
    begin
        if(in_noStall) begin
            out_RegDst <= RegDst;
			out_MemRead <= MemRead;
			out_MemtoReg <= MemtoReg;
			out_ALUOp <= ALUOp;
			out_MemWrite <= MemWrite;
			out_ALUSrc <= ALUSrc;
			out_RegWrite <= RegWrite;
			out_op_shamt <= op_shamt;
			out_enable_pc <= enable_pc;
			end
        else begin
            out_RegDst <= 0;
			out_MemRead <= 0;
			out_MemtoReg <= 0;
			out_ALUOp <= 0;
			out_MemWrite <= 0;
			out_ALUSrc <= 0;
			out_RegWrite <= 0;
			out_op_shamt <= 0;
			out_enable_pc <= 1;
			end
    end
    
    assign out_opcode = in_instruction[31:26];
    assign ID_RegisterRd = in_instruction[15:11];
    assign ID_RegisterRt = in_instruction[20:16];
    assign ID_RegisterRs = in_instruction[25:21];
    
    assign out_instruction = in_instruction;
    assign out_if_add = in_if_add;
	
endmodule
