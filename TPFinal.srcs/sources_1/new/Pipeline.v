`timescale 1ns / 1ps

module Pipeline(
    //INPUTS
    input wire clk,             //Clock
    input wire reset,           //Reset
    input wire step,            //Step    
    input wire instruction_ready,
    input wire  [31:0] IM_instruction,
    
    //OUTPUTS
        //IF
    output wire [31:0] out_if_add,                  //Proximo PC
    output wire [31:0] out_instruction,             //Instruccion a ejecutar
        //IF_ID
    output wire [31:0] out_ifid_add,                //Proximo PC
    output wire [31:0] out_ifid_instruction,        //Instruccion a ejecutar
        //ID
    output wire [31:0] out_pc_branch,               //Proximo PC a saltar
    output wire [31:0] out_read_data_1,             //Dato del registro RS
    output wire [31:0] out_read_data_2,             //Dato del registro RT
    output wire [31:0] out_id_sign,                 //Sign_extend de los bits [15:0]
    output wire [4:0]  out_id_register_Rd,          //Registro RD
    output wire [4:0] out_id_register_Rt,           //Registro RT
    output wire [4:0] out_id_register_Rs,           //Registro RS
    output wire [5:0] out_opcode,                   //Opcode   
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
    output wire [31:0] reg_31,            
        //ID_EX
    output wire [31:0] out_idex_read_data_1,        //Dato del registro RS que sale de IDEX
    output wire [31:0] out_idex_read_data_2,        //Dato del registro RT que sale de IDEX
    output wire [31:0] out_idex_sign,               //Sign_extend de los bits [15:0]
    output wire [4:0]  out_idex_register_Rd,        //Registro RD   
    output wire [4:0] out_idex_register_Rt,         //Registro RT
    output wire [4:0] out_idex_register_Rs,         //Registro RS 
    output wire [5:0] out_idex_opcode,              //Opcode
        //EX
    output wire [31:0] out_alu_result,              //Resultado de ALU
    output wire [4:0] out_ex_write_register,        //Write register saliendo de EX
    output wire [31:0] in_ex_read_data_2,           
        //EX_MEM
    output wire [31:0] out_exmem_alu_result,
    output wire [31:0] in_exmem_read_data_2,
    output wire [4:0] out_exmem_write_register,
        //MEM
    output wire [31:0] out_mem_alu_result,
    output wire [31:0] out_read_data,
    output wire [4:0] out_mem_write_register,
    output wire [31:0] ram_0,
    output wire [31:0] ram_1,
    output wire [31:0] ram_2,
    output wire [31:0] ram_3,
    output wire [31:0] ram_4,
    output wire [31:0] ram_5,
    output wire [31:0] ram_6,
    output wire [31:0] ram_7,
    output wire [31:0] ram_8,
    output wire [31:0] ram_9,
    output wire [31:0] ram_10,
    output wire [31:0] ram_11,
    output wire [31:0] ram_12,
    output wire [31:0] ram_13,
    output wire [31:0] ram_14,
    output wire [31:0] ram_15,
    output wire [31:0] ram_16,
    output wire [31:0] ram_17,
    output wire [31:0] ram_18,
    output wire [31:0] ram_19,
    output wire [31:0] ram_20,
    output wire [31:0] ram_21,
    output wire [31:0] ram_22,
    output wire [31:0] ram_23,
    output wire [31:0] ram_24,
    output wire [31:0] ram_25,
    output wire [31:0] ram_26,
    output wire [31:0] ram_27,
    output wire [31:0] ram_28,
    output wire [31:0] ram_29,
    output wire [31:0] ram_30,
    output wire [31:0] ram_31,   
        //MEM_WB
    output wire [31:0] out_memwb_read_data,
    output wire [31:0] out_memwb_alu_result,
    output wire [4:0] out_memwb_write_register,     
        //WB
    output wire [31:0] out_wb_mux,                  //Dato a guardar en write_register
        
        //ClockCounter
    output wire [7:0] counter_clk,
    output wire out_enable_pc,    
    output wire [511:0] out_instructions_all,
    output wire [31:0] pc,
    output wire taken,
    output wire [31:0] out_mux3_A,
    output wire [31:0] out_mux3_B,
    output wire [31:0] out_ex_mux
    );
    
    wire out_zero;
    wire out_RegDst; 
    wire out_Branch;
    wire out_MemRead;
    wire out_MemtoReg;
    wire [5:0] out_ALUOp;
    wire out_MemWrite;
    wire out_ALUSrc;
    wire out_RegWrite;
    wire out_op_shamt;
    wire out_idex_RegDst;
    wire out_idex_MemRead; 
    wire out_idex_MemtoReg;
    wire [5:0] out_idex_ALUOp;
    wire out_idex_MemWrite;
    wire out_idex_ALUSrc; 
    wire out_idex_RegWrite;
    wire out_idex_op_shamt;
    wire out_memwb_MemtoReg;
    wire out_memwb_RegWrite;
    wire out_exmem_MemRead, out_exmem_MemtoReg;
    wire out_exmem_MemWrite, out_exmem_RegWrite;
    wire [1:0] out_forwardA,out_forwardB;
    wire out_noStall;
    wire [31:0] out_id_instruction;
    wire [31:0] out_idex_instruction;
    wire [31:0] out_id_add;
    wire [31:0] out_idex_add;
    wire out_jal;
    wire out_jalr;
        
       
    //Etapa 1 -> Instruction Fetch                                
    IF instruction_fetch(
        clk,reset, out_pc_branch, taken,out_noStall,out_enable_pc, step,instruction_ready,IM_instruction,
        out_instruction, out_if_add,out_instructions_all,pc
        );
    //Registro IF/ID                64bits
    IF_ID reg_if_id(
        clk, reset, out_if_add, out_instruction, out_noStall,taken/*out_Branch*/,step,
        out_ifid_instruction,out_ifid_add
        );
    
    //Etapa 2 -> Instruction Decoder
    ID instruction_decoder(
        clk,reset,out_ifid_instruction,out_ifid_add,out_wb_mux,out_memwb_write_register,
           out_noStall, out_memwb_RegWrite, step,out_jal,out_jalr,
        out_opcode, /*out_pc_branch,*/out_read_data_1,out_read_data_2,out_id_sign,
            out_id_register_Rd,out_id_register_Rt,out_id_register_Rs,taken,out_RegDst, 
            out_Branch, out_MemRead, out_MemtoReg,out_ALUOp, out_MemWrite, out_ALUSrc,
            out_RegWrite,out_op_shamt,out_enable_pc,out_id_instruction,out_id_add,
            reg_0,reg_1,reg_2,reg_3,reg_4,reg_5,reg_6,reg_7,reg_8,reg_9,reg_10,
            reg_11,reg_12,reg_13,reg_14,reg_15,reg_16,reg_17,reg_18,reg_19,reg_20,
            reg_21,reg_22,reg_23,reg_24,reg_25,reg_26,reg_27,reg_28,reg_29,
            reg_30,reg_31 
        );
    //Registro ID/EX                128bits
    ID_EX reg_id_ex(
        clk,reset,out_opcode,out_read_data_1,out_read_data_2,out_id_sign,out_id_register_Rd,
            out_id_register_Rt,out_id_register_Rs, out_RegDst, out_MemRead, out_MemtoReg, 
            out_ALUOp, out_MemWrite, out_ALUSrc, out_RegWrite,out_op_shamt,step,
            out_id_instruction,out_id_add,taken,
        out_idex_opcode,out_idex_read_data_1,out_idex_read_data_2,out_idex_sign,
            out_idex_register_Rd,out_idex_register_Rt,out_idex_register_Rs, out_idex_RegDst,
            out_idex_MemRead,out_idex_MemtoReg, out_idex_ALUOp, out_idex_MemWrite, 
            out_idex_ALUSrc,out_idex_RegWrite,out_idex_op_shamt,out_idex_instruction,
            out_idex_add
        );
    
    //Etapa 3 -> Execution
    EX execution(
        reset, out_idex_opcode, out_idex_read_data_1,out_idex_read_data_2,out_idex_sign,
            out_idex_register_Rd,out_idex_register_Rt, out_idex_RegDst,out_idex_ALUOp,
            out_idex_ALUSrc,out_idex_op_shamt,out_forwardA,out_forwardB,out_wb_mux,
            out_exmem_alu_result,out_idex_instruction,out_idex_add,
        out_alu_result,out_zero,in_ex_read_data_2,out_ex_write_register,taken,
            out_jal,out_jalr,out_pc_branch,out_mux3_A,out_mux3_B,out_ex_mux
        );        
    //Registro EX/MEM               97bits
    EX_MEM reg_ex_mem(
        clk,reset,out_alu_result,in_ex_read_data_2,out_ex_write_register, out_idex_MemRead,
            out_idex_MemtoReg,out_idex_MemWrite, out_idex_RegWrite,step,
        out_exmem_alu_result,in_exmem_read_data_2,out_exmem_write_register, out_exmem_MemRead,
            out_exmem_MemtoReg,out_exmem_MemWrite, out_exmem_RegWrite
        );
    
    //Etapa 4 -> Memory Access
    MEM memory_access(
        clk,reset,out_exmem_alu_result,in_exmem_read_data_2,out_exmem_write_register,
             out_exmem_MemRead, out_exmem_MemWrite,step,
        out_mem_alu_result,out_read_data,out_mem_write_register,ram_0,ram_1,ram_2,ram_3,
            ram_4,ram_5,ram_6,ram_7,ram_8,ram_9,ram_10,ram_11,ram_12,ram_13,ram_14,ram_15,
            ram_16,ram_17,ram_18,ram_19,ram_20,ram_21,ram_22,ram_23,ram_24,ram_25,ram_26,
            ram_27,ram_28,ram_29,ram_30,ram_31
        );
    //Registro MEM/WB               64bits
    MEM_WB reg_mem_wb(
        clk,reset,out_read_data,out_mem_alu_result,out_mem_write_register,out_exmem_MemtoReg,
            out_exmem_RegWrite,step,
        out_memwb_read_data,out_memwb_alu_result,out_memwb_write_register,out_memwb_MemtoReg,
            out_memwb_RegWrite
        );
    
    //Etapa 5 -> Write-Back
    WB write_back(
        out_memwb_read_data,out_memwb_alu_result,out_memwb_MemtoReg,
        out_wb_mux
        );
    
    //Forwarding Unit
    FU forwarding_unit(
        clk,out_idex_register_Rs,out_idex_register_Rt,out_exmem_write_register,
            out_memwb_write_register,out_exmem_RegWrite,out_memwb_RegWrite,
        out_forwardA,out_forwardB
        );
    
    //Hazard Unit
    HU hazard_unit(
        out_idex_MemRead, out_Branch, out_idex_register_Rt, out_ifid_instruction[25:21], 
            out_ifid_instruction[20:16],
		out_noStall
		);
		
    ClockCounter CC(
        clk,reset,step, 
        counter_clk
        );
        
endmodule


