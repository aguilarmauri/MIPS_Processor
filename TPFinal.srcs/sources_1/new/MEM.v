`timescale 1ns / 1ps

module MEM(
        // INPUTS
        input wire clk,
        input wire reset,
        input wire [31:0] in_alu_result,            //Entrada proveniente del latch 3 EX/MEM
        input wire [31:0] in_read_data_2,            //Entrada proveniente del latch 3 EX/MEM
        input wire [4:0] in_write_register,           //Entrada proveniente del latch 3 EX/MEM
        input wire in_MemRead,
        input wire in_MemWrite,
        input wire step,
        // OUTPUTS
        output wire [31:0] out_alu_result,          //Salida hacia latch 4 MEM/WB
        output wire [31:0] out_read_data,           //Salida hacia latch 4 MEM/WB
        output wire [4:0] out_write_register,          //Salida hacia latch 4 MEM/WB
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
        output wire [31:0] ram_31
    );
    
    DM data_memory(
        clk,reset,in_alu_result, in_read_data_2, in_MemRead, in_MemWrite,step,
        out_read_data,ram_0,ram_1,ram_2,ram_3,ram_4,ram_5,ram_6,ram_7,ram_8,ram_9,
            ram_10,ram_11,ram_12,ram_13,ram_14,ram_15,ram_16,ram_17,ram_18,ram_19,
            ram_20,ram_21,ram_22,ram_23,ram_24,ram_25,ram_26,ram_27,ram_28,ram_29,
            ram_30,ram_31
        );
              
    assign out_alu_result = in_alu_result;
    assign out_write_register = in_write_register;
       
endmodule
