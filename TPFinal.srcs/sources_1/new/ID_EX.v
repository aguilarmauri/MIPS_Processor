`timescale 1ns / 1ps

module ID_EX(
    //INPUTS
    input wire clk,
    input wire reset,
    input wire [5:0] in_opcode,
    input wire [31:0] in_regs_read_data1,    //Entrada proveniente de la etapa id, modulo Regs
    input wire [31:0] in_regs_read_data2,    //Entrada proveniente de la etapa id, modulo Regs
    input wire [31:0] in_se_sign,           //Entrada proveniente de la etapa id, modulo SE
    input wire [4:0] in_registerRd,   //Entrada proveniente de la etapa id, instruction[15:11]
    input wire [4:0] in_registerRt,   //Entrada proveniente de la etapa id, instruction[20:16]
    input wire [4:0] in_registerRs,   //Entrada proveniente de la etapa id, instruction[25:21]
    input wire in_RegDst, 
    input wire in_MemRead,
    input wire in_MemtoReg,
    input wire [5:0] in_ALUOp,
    input wire in_MemWrite,
    input wire in_ALUSrc,
    input wire in_RegWrite,
    input wire in_op_shamt,
    input wire step,
    input wire [31:0] in_instruction,
    input wire [31:0] in_if_add,
    input wire flush,
    //OUTPUTS
    output reg [5:0] out_opcode,
    output reg [31:0] out_regs_read_data1,   //Salida proveniente de la etapa id, modulo Regs
    output reg [31:0] out_regs_read_data2,   //Salida proveniente de la etapa id, modulo Regs
    output reg [31:0] out_se_sign,           //Salida proveniente de la etapa id, modulo SE
    output reg [4:0] out_registerRd,
    output reg [4:0] out_registerRt,
    output reg [4:0] out_registerRs,
    output reg out_RegDst, 
    output reg out_MemRead,
    output reg out_MemtoReg,
    output reg [5:0] out_ALUOp,
    output reg out_MemWrite,
    output reg out_ALUSrc,
    output reg out_RegWrite,
    output reg out_op_shamt,
    output reg [31:0] out_instruction,
    output reg [31:0] out_if_add
    );
    
    always@(posedge clk)
    begin
        if(reset)
        begin
            out_regs_read_data1 <= 0;
            out_regs_read_data2 <= 0;
            out_se_sign <= 0;
            out_registerRd <= 0;
            out_registerRt <= 0;
            out_registerRs <= 0;
            out_RegDst <= 0;
            //out_Branch <= 0;
            out_MemRead <= 0;
            out_MemtoReg <= 0;
            out_ALUOp <= 0;
            out_MemWrite <= 0;
            out_ALUSrc <= 0;
            out_RegWrite <= 0;
            out_op_shamt <= 0;
            out_opcode <= 0;        // Ver
            out_instruction <= 0;
            out_if_add <= 0;
        end
        
        else
            if(step) begin
                if(flush) begin
                    out_regs_read_data1 <= 0;
                    out_regs_read_data2 <= 0;
                    out_se_sign <= 0;
                    out_registerRd <= 0;
                    out_registerRt <= 0;
                    out_registerRs <= 0;
                    out_RegDst <= 0;
                    out_MemRead <= 0;
                    out_MemtoReg <= 0;
                    out_ALUOp <= 0;
                    out_MemWrite <= 0;
                    out_ALUSrc <= 0;
                    out_RegWrite <= 0;
                    out_op_shamt <= 0;
                    out_opcode <= 0;        // Ver
                    out_instruction <= 0;
                    out_if_add <= 0;
                    end
                else begin
                    out_regs_read_data1 <= in_regs_read_data1;
                    out_regs_read_data2 <= in_regs_read_data2;
                    out_se_sign <= in_se_sign;
                    out_registerRd <= in_registerRd;
                    out_registerRt <= in_registerRt;
                    out_registerRs <= in_registerRs;
                    out_RegDst <= in_RegDst;
                    out_MemRead <= in_MemRead;
                    out_MemtoReg <= in_MemtoReg;
                    out_ALUOp <= in_ALUOp;
                    out_MemWrite <= in_MemWrite;
                    out_ALUSrc <= in_ALUSrc;
                    out_RegWrite <= in_RegWrite;
                    out_op_shamt <= in_op_shamt;
                    out_opcode <= in_opcode;
                    out_instruction <= in_instruction;
                    out_if_add <= in_if_add;
                end
            end
    end
endmodule