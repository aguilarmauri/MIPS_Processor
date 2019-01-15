`timescale 1ns / 1ps

module TPF(
    //INPUTS
    input wire clk,
    input wire reset,
    input wire boton,
    input wire rx,
    //OUTPUTS
    output wire tx,
    output wire led1,
    output wire led2,
    output wire led3,
    output wire led4,
    output wire led5,
    output wire led6
    );
    
    assign led1=1;
    wire step;
    wire [31:0] out_if_add;                  //Proximo PC
    wire [31:0] out_instruction;            //Instruccion a ejecutar
        //IF_ID
    wire [31:0] out_ifid_add;                //Proximo PC
    wire [31:0] out_ifid_instruction;        //Instruccion a ejecutar
        //ID
    wire [31:0] out_pc_branch;               //Proximo PC a saltar
    wire [31:0] out_read_data_1;             //Dato del registro RS
    wire [31:0] out_read_data_2;             //Dato del registro RT
    wire [31:0] out_id_sign;                 //Sign_extend de los bits [15:0]
    wire [4:0]  out_id_register_Rd;          //Registro RD
    wire [4:0] out_id_register_Rt;           //Registro RT
    wire [4:0] out_id_register_Rs;           //Registro RS
    wire [5:0] out_opcode;                   //Opcode   
    wire [31:0] reg_0;
    wire [31:0] reg_1;
    wire [31:0] reg_2;
    wire [31:0] reg_3;
    wire [31:0] reg_4;
    wire [31:0] reg_5;
    wire [31:0] reg_6;
    wire [31:0] reg_7;
    wire [31:0] reg_8;
    wire [31:0] reg_9;
    wire [31:0] reg_10;
    wire [31:0] reg_11;
    wire [31:0] reg_12;
    wire [31:0] reg_13;
    wire [31:0] reg_14;
    wire [31:0] reg_15;
    wire [31:0] reg_16;
    wire [31:0] reg_17;
    wire [31:0] reg_18;
    wire [31:0] reg_19;
    wire [31:0] reg_20;
    wire [31:0] reg_21;
    wire [31:0] reg_22;
    wire [31:0] reg_23;
    wire [31:0] reg_24;
    wire [31:0] reg_25;
    wire [31:0] reg_26;
    wire [31:0] reg_27;
    wire [31:0] reg_28;
    wire [31:0] reg_29;
    wire [31:0] reg_30;
    wire [31:0] reg_31;            
        //ID_EX
    wire [31:0] out_idex_read_data_1;        //Dato del registro RS que sale de IDEX
    wire [31:0] out_idex_read_data_2;        //Dato del registro RT que sale de IDEX
    wire [31:0] out_idex_sign;               //Sign_extend de los bits [15:0]
    wire [4:0]  out_idex_register_Rd;        //Registro RD   
    wire [4:0] out_idex_register_Rt;         //Registro RT
    wire [4:0] out_idex_register_Rs;         //Registro RS 
    wire [5:0] out_idex_opcode;              //Opcode
        //EX
    wire [31:0] out_alu_result;              //Resultado de ALU
    wire [4:0] out_ex_write_register;        //Write register saliendo de EX
    wire [31:0] in_ex_read_data_2;           
        //EX_MEM
    wire [31:0] out_exmem_alu_result;
    wire [31:0] in_exmem_read_data_2;
    wire [4:0] out_exmem_write_register;
        //MEM
    wire [31:0] out_mem_alu_result;
    wire [31:0] out_read_data;
    wire [4:0] out_mem_write_register;
    wire [31:0] ram_0;
    wire [31:0] ram_1;
    wire [31:0] ram_2;
    wire [31:0] ram_3;
    wire [31:0] ram_4;
    wire [31:0] ram_5;
    wire [31:0] ram_6;
    wire [31:0] ram_7;
    wire [31:0] ram_8;
    wire [31:0] ram_9;
    wire [31:0] ram_10;
    wire [31:0] ram_11;
    wire [31:0] ram_12;
    wire [31:0] ram_13;
    wire [31:0] ram_14;
    wire [31:0] ram_15;
    wire [31:0] ram_16;
    wire [31:0] ram_17;
    wire [31:0] ram_18;
    wire [31:0] ram_19;
    wire [31:0] ram_20;
    wire [31:0] ram_21;
    wire [31:0] ram_22;
    wire [31:0] ram_23;
    wire [31:0] ram_24;
    wire [31:0] ram_25;
    wire [31:0] ram_26;
    wire [31:0] ram_27;
    wire [31:0] ram_28;
    wire [31:0] ram_29;
    wire [31:0] ram_30;
    wire [31:0] ram_31;   
        //MEM_WB
    wire [31:0] out_memwb_read_data;
    wire [31:0] out_memwb_alu_result;
    wire [4:0] out_memwb_write_register;     
        //WB
    wire [31:0] out_wb_mux;                  //Dato a guardar en write_register
        
        //ClockCounter
    wire [7:0] counter_clk;
    
    // Carga de instrucciones en IM
    wire instruction_ready;
    wire [31:0] IM_instruction;
    wire enable_pc;    
    wire [511:0] out_instructions_all;
    wire [31:0] pc;
    wire taken;
    wire [31:0] out_mux3_A,out_mux3_B,out_ex_mux;

    Pipeline pipe(
        clk,~reset,step,instruction_ready,IM_instruction,
        out_if_add,out_instruction,out_ifid_add,out_ifid_instruction,out_pc_branch,
            out_read_data_1,out_read_data_2,out_id_sign,out_id_register_Rd,out_id_register_Rt,
            out_id_register_Rs,out_opcode,reg_0,reg_1,reg_2,reg_3,reg_4,reg_5,reg_6,reg_7,
            reg_8,reg_9,reg_10,reg_11,reg_12,reg_13,reg_14,reg_15,reg_16,reg_17,reg_18,reg_19,
            reg_20,reg_21,reg_22,reg_23,reg_24,reg_25,reg_26,reg_27,reg_28,reg_29,reg_30,reg_31,
            out_idex_read_data_1,out_idex_read_data_2,out_idex_sign,out_idex_register_Rd,
            out_idex_register_Rt,out_idex_register_Rs,out_idex_opcode,out_alu_result,
            out_ex_write_register,in_ex_read_data_2,out_exmem_alu_result,in_exmem_read_data_2,
            out_exmem_write_register,out_mem_alu_result,out_read_data,out_mem_write_register,
            ram_0,ram_1,ram_2,ram_3,ram_4,ram_5,ram_6,ram_7,ram_8,ram_9,ram_10,ram_11,ram_12,
            ram_13,ram_14,ram_15,ram_16,ram_17,ram_18,ram_19,ram_20,ram_21,ram_22,ram_23,ram_24,
            ram_25,ram_26,ram_27,ram_28,ram_29,ram_30,ram_31,out_memwb_read_data,
            out_memwb_alu_result,out_memwb_write_register,out_wb_mux,counter_clk,
            enable_pc,out_instructions_all,pc,taken,out_mux3_A,out_mux3_B,out_ex_mux
        );
        
    UART uart(
        clk,~reset,boton,out_if_add,out_instruction,out_ifid_add,out_ifid_instruction,out_pc_branch,
            out_read_data_1,out_read_data_2,out_id_sign,out_id_register_Rd,out_id_register_Rt,
            out_id_register_Rs,out_opcode,reg_0,reg_1,reg_2,reg_3,reg_4,reg_5,reg_6,reg_7,
            reg_8,reg_9,reg_10,reg_11,reg_12,reg_13,reg_14,reg_15,reg_16,reg_17,reg_18,reg_19,
            reg_20,reg_21,reg_22,reg_23,reg_24,reg_25,reg_26,reg_27,reg_28,reg_29,reg_30,reg_31,
            out_idex_read_data_1,out_idex_read_data_2,out_idex_sign,out_idex_register_Rd,
            out_idex_register_Rt,out_idex_register_Rs,out_idex_opcode,out_alu_result,
            out_ex_write_register,in_ex_read_data_2,out_exmem_alu_result,in_exmem_read_data_2,
            out_exmem_write_register,out_mem_alu_result,out_read_data,out_mem_write_register,
            ram_0,ram_1,ram_2,ram_3,ram_4,ram_5,ram_6,ram_7,ram_8,ram_9,ram_10,ram_11,ram_12,
            ram_13,ram_14,ram_15,ram_16,ram_17,ram_18,ram_19,ram_20,ram_21,ram_22,ram_23,ram_24,
            ram_25,ram_26,ram_27,ram_28,ram_29,ram_30,ram_31,out_memwb_read_data,
            out_memwb_alu_result,out_memwb_write_register,out_wb_mux,counter_clk,rx,enable_pc,
            out_instructions_all,pc,taken,out_mux3_A,out_mux3_B,out_ex_mux,
        tx,instruction_ready,IM_instruction,led2,led3,led4,led5,led6,step
        );
 
endmodule
