`timescale 1ns / 1ps

module Regs(
    //INPUTS
    input wire clk,
    input wire reset,
    input wire RegWrite,
    input wire [4:0] in_read_register1,      //Entrada proveniente de la etapa
    input wire [4:0] in_read_register2,      //Entrada proveniente de la etapa
    input wire [4:0] in_write_register,      //Entrada proveniente de la etapa
    input wire [31:0] in_wb_write_data,         //Entrada proveniente de la etapa WB
    input wire [4:0] in_registerRd,
    input wire [31:0] in_pc,
    input wire in_jal,
    input wire in_jalr,
    input wire step,
    //OUTPUTS
    output reg [31:0] out_read_data1,     //Salida hacia latch 2 ID/EX
    output reg [31:0] out_read_data2,      //Salida hacia latch 2 ID/EX
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
    
    
    reg [31:0] registers [0:31];
    integer i;

    // Escritura
    always@(posedge clk, posedge reset)
    begin
        if(reset)
            for(i = 0; i<32; i=i+1) begin
                registers[i] <= i; 
                end
        else 
            if(step) begin
                if(RegWrite)
                    registers[in_write_register] <= in_wb_write_data;  
                else if(in_jal)
                    registers[31] <= (in_pc + 2'b10);
                else if(in_jalr)
                    registers[in_registerRd] <= (in_pc + 2'b10); 
            end      
    end
    
    // Lectura
    always@(negedge clk) 
    if(step) begin
        out_read_data1 = registers[in_read_register1];
        out_read_data2 = registers[in_read_register2];
    end	
    
    assign reg_0 = registers[0];
    assign reg_1 = registers[1];
    assign reg_2 = registers[2];
    assign reg_3 = registers[3];
    assign reg_4 = registers[4];
    assign reg_5 = registers[5];
    assign reg_6 = registers[6];
    assign reg_7 = registers[7];
    assign reg_8 = registers[8];
    assign reg_9 = registers[9];
    assign reg_10 = registers[10];
    assign reg_11 = registers[11];
    assign reg_12 = registers[12];
    assign reg_13 = registers[13];
    assign reg_14 = registers[14];
    assign reg_15 = registers[15];
    assign reg_16 = registers[16];
    assign reg_17 = registers[17];
    assign reg_18 = registers[18];
    assign reg_19 = registers[19];
    assign reg_20 = registers[20];
    assign reg_21 = registers[21];
    assign reg_22 = registers[22];
    assign reg_23 = registers[23];
    assign reg_24 = registers[24];
    assign reg_25 = registers[25];
    assign reg_26 = registers[26];
    assign reg_27 = registers[27];
    assign reg_28 = registers[28];
    assign reg_29 = registers[29];
    assign reg_30 = registers[30];
    assign reg_31 = registers[31];
    
endmodule
