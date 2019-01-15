`timescale 1ns / 1ps

module UART(
    //INPUTS
    input wire clk,
    input wire reset,
    input wire boton,
    input wire [31:0] out_if_add,                  //Proximo PC
    input wire [31:0] out_instruction,             //Instruccion a ejecutar
        //IF_ID
    input wire [31:0] out_ifid_add,                //Proximo PC
    input wire [31:0] out_ifid_instruction,        //Instruccion a ejecutar
        //ID
    input wire [31:0] out_pc_branch,               //Proximo PC a saltar
    input wire [31:0] out_read_data_1,             //Dato del registro RS
    input wire [31:0] out_read_data_2,             //Dato del registro RT
    input wire [31:0] out_id_sign,                 //Sign_extend de los bits [15:0]
    input wire [4:0]  out_id_register_Rd,          //Registro RD
    input wire [4:0] out_id_register_Rt,           //Registro RT
    input wire [4:0] out_id_register_Rs,           //Registro RS
    input wire [5:0] out_opcode,                   //Opcode   
    input wire [31:0] reg_0,
    input wire [31:0] reg_1,
    input wire [31:0] reg_2,
    input wire [31:0] reg_3,
    input wire [31:0] reg_4,
    input wire [31:0] reg_5,
    input wire [31:0] reg_6,
    input wire [31:0] reg_7,
    input wire [31:0] reg_8,
    input wire [31:0] reg_9,
    input wire [31:0] reg_10,
    input wire [31:0] reg_11,
    input wire [31:0] reg_12,
    input wire [31:0] reg_13,
    input wire [31:0] reg_14,
    input wire [31:0] reg_15,
    input wire [31:0] reg_16,
    input wire [31:0] reg_17,
    input wire [31:0] reg_18,
    input wire [31:0] reg_19,
    input wire [31:0] reg_20,
    input wire [31:0] reg_21,
    input wire [31:0] reg_22,
    input wire [31:0] reg_23,
    input wire [31:0] reg_24,
    input wire [31:0] reg_25,
    input wire [31:0] reg_26,
    input wire [31:0] reg_27,
    input wire [31:0] reg_28,
    input wire [31:0] reg_29,
    input wire [31:0] reg_30,
    input wire [31:0] reg_31,            
        //ID_EX
    input wire [31:0] out_idex_read_data_1,        //Dato del registro RS que sale de IDEX
    input wire [31:0] out_idex_read_data_2,        //Dato del registro RT que sale de IDEX
    input wire [31:0] out_idex_sign,               //Sign_extend de los bits [15:0]
    input wire [4:0]  out_idex_register_Rd,        //Registro RD   
    input wire [4:0] out_idex_register_Rt,         //Registro RT
    input wire [4:0] out_idex_register_Rs,         //Registro RS 
    input wire [5:0] out_idex_opcode,              //Opcode
        //EX
    input wire [31:0] out_alu_result,              //Resultado de ALU
    input wire [4:0] out_ex_write_register,        //Write register saliendo de EX
    input wire [31:0] in_ex_read_data_2,           
        //EX_MEM
    input wire [31:0] out_exmem_alu_result,
    input wire [31:0] in_exmem_read_data_2,
    input wire [4:0] out_exmem_write_register,
        //MEM
    input wire [31:0] out_mem_alu_result,
    input wire [31:0] out_read_data,
    input wire [4:0] out_mem_write_register,
    input wire [31:0] ram_0,
    input wire [31:0] ram_1,
    input wire [31:0] ram_2,
    input wire [31:0] ram_3,
    input wire [31:0] ram_4,
    input wire [31:0] ram_5,
    input wire [31:0] ram_6,
    input wire [31:0] ram_7,
    input wire [31:0] ram_8,
    input wire [31:0] ram_9,
    input wire [31:0] ram_10,
    input wire [31:0] ram_11,
    input wire [31:0] ram_12,
    input wire [31:0] ram_13,
    input wire [31:0] ram_14,
    input wire [31:0] ram_15,
    input wire [31:0] ram_16,
    input wire [31:0] ram_17,
    input wire [31:0] ram_18,
    input wire [31:0] ram_19,
    input wire [31:0] ram_20,
    input wire [31:0] ram_21,
    input wire [31:0] ram_22,
    input wire [31:0] ram_23,
    input wire [31:0] ram_24,
    input wire [31:0] ram_25,
    input wire [31:0] ram_26,
    input wire [31:0] ram_27,
    input wire [31:0] ram_28,
    input wire [31:0] ram_29,
    input wire [31:0] ram_30,
    input wire [31:0] ram_31,   
        //MEM_WB
    input wire [31:0] out_memwb_read_data,
    input wire [31:0] out_memwb_alu_result,
    input wire [4:0] out_memwb_write_register,     
        //WB
    input wire [31:0] out_wb_mux,                  //Dato a guardar en write_register       
        //ClockCounter
    input wire [7:0] counter_clk,
    
    input wire rx,
    input wire enable_pc,
    input wire [511:0] out_instructions_all,
    input wire [31:0] pc,
    input wire taken,
    input wire [31:0] out_mux3_A,
    input wire [31:0] out_mux3_B,
    input wire [31:0] out_ex_mux,
    //OUTPUTS
    output wire tx,
    output wire instruction_ready,
    output wire [31:0] IM_instruction,
    output wire led1,
    output wire led2,
    output wire led3,
    output wire led4,
    output wire led5,
    output wire step    
    );
    
    wire tick;
    wire tx_done_tick;
    wire tx_start;
    wire [7:0] data_tx;
    wire rx_done_tick;
    wire [7:0] dout;    

    BRG brg(
        clk,
        tick
        );
    INTERFACE interface(
        clk,reset,boton,tx_done_tick,out_if_add,out_instruction,out_ifid_add,out_ifid_instruction,
            out_pc_branch,out_read_data_1,out_read_data_2,out_id_sign,out_id_register_Rd,
            out_id_register_Rt,out_id_register_Rs,out_opcode,reg_0,reg_1,reg_2,reg_3,reg_4,
            reg_5,reg_6,reg_7,reg_8,reg_9,reg_10,reg_11,reg_12,reg_13,reg_14,reg_15,reg_16,
            reg_17,reg_18,reg_19,reg_20,reg_21,reg_22,reg_23,reg_24,reg_25,reg_26,reg_27,
            reg_28,reg_29,reg_30,reg_31,out_idex_read_data_1,out_idex_read_data_2,
            out_idex_sign,out_idex_register_Rd,out_idex_register_Rt,out_idex_register_Rs,
            out_idex_opcode,out_alu_result,out_ex_write_register,in_ex_read_data_2,
            out_exmem_alu_result,in_exmem_read_data_2,out_exmem_write_register,
            out_mem_alu_result,out_read_data,out_mem_write_register,ram_0,ram_1,ram_2,ram_3,
            ram_4,ram_5,ram_6,ram_7,ram_8,ram_9,ram_10,ram_11,ram_12,ram_13,ram_14,ram_15,
            ram_16,ram_17,ram_18,ram_19,ram_20,ram_21,ram_22,ram_23,ram_24,ram_25,ram_26,
            ram_27,ram_28,ram_29,ram_30,ram_31,out_memwb_read_data,out_memwb_alu_result,
            out_memwb_write_register,out_wb_mux,counter_clk,rx_done_tick,dout,enable_pc,
            out_instructions_all,pc,taken,out_mux3_A,out_mux3_B,out_ex_mux,
        tx_start,data_tx,instruction_ready,IM_instruction,led1,led2,led3,led4,led5,step
        );
    RX rx_unit(
        clk,reset,rx,tick,
        rx_done_tick,dout
        );
    TX tx_unit(
        clk,reset,tx_start,tick,data_tx,
        tx_done_tick,tx
        );
        
endmodule
