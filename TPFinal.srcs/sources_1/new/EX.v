`timescale 1ns / 1ps

module EX(
    //INPUTS                 
    input wire reset,
    input wire [5:0] in_opcode,
    input wire [31:0] in_read_data_1,      //Registro#1 que proviene del modulo de Registros
    input wire [31:0] in_read_data_2,      //Registro#2 que proviene del modulo de Registros
    input wire [31:0] in_sign_extend,   //Entrada proveniendo del extensor de signo
    input wire [4:0] in_registerRd,
    input wire [4:0] in_registerRt,
    input wire RegDst, 
    input wire [5:0] ALUOp,
    input wire ALUSrc,
    input wire in_op_shamt,
    input wire [1:0] forwardA,
    input wire [1:0] forwardB,
    input wire [31:0] in_wb_mux,
    input wire [31:0] in_exmem_address,
    input wire [31:0] in_instruction,
    input wire [31:0] in_if_add,
    //OUTPUTS
    output wire [31:0] alu_result,      //Salida de la ALU
    output wire out_zero,               //Flag ZERO de la ALU
    output wire [31:0] out_read_data_2,        //Salida que indicará la DIRECCION DE MEMORIA
    output wire [4:0] out_write_register,
    output wire taken,
    output wire out_jal,
    output wire out_jalr,
    output wire [31:0] out_pc_branch,
    output wire [31:0] out_mux3_A,
    output wire [31:0] out_mux3_B,
    output wire [31:0] out_ex_mux
    );
                          
    wire [3:0] operation;
    wire [31:0] out_ex_mux_shamt;
    
    MUX ex_mux_shamt(
        in_op_shamt, in_read_data_1, in_read_data_2,
        out_ex_mux_shamt
        );
    MUX3 #(32) ex_mux_alu_A(
        forwardA,out_ex_mux_shamt,in_wb_mux,in_exmem_address,
        out_mux3_A
        );
    MUX3 #(32) ex_mux_alu_B(
        forwardB,in_read_data_2,in_wb_mux,in_exmem_address,
        out_mux3_B
        );     
    MUX ex_mux_in_alu(
        ALUSrc, out_mux3_B, in_sign_extend,
        out_ex_mux
        );
    ALU alu(
        reset,out_mux3_A,out_ex_mux,operation,
        out_zero,alu_result
        );
    ALU_Control aluC(
        in_sign_extend[5:0],ALUOp,
        operation
        );
    MUX #(5) ex_mux_write_register(
        RegDst,in_registerRt,in_registerRd,
        out_write_register    
            ); 
    Branch branch(
        reset,in_instruction[31:26],in_instruction[5:0],out_mux3_A, 
            out_mux3_B,in_if_add,in_sign_extend,in_instruction[25:0],
        taken,out_pc_branch,out_jal,out_jalr
        );
        
    // Filtro para SB y SH
    FiltroStore filtro_store(
           in_opcode, out_mux3_B,
           out_read_data_2
           );  
                      
  
endmodule
