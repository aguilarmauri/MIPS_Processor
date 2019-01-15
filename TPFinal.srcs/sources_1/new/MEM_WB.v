`timescale 1ns / 1ps

module MEM_WB(
    
    // INPUTS
    input wire clk,
    input wire reset,
    input wire [31:0] in_read_data,          //Entrada proveniente de la etapa MEM
    input wire [31:0] in_alu_result,         //Entrada proveniente del latch 3 EX/MEM
    input wire [4:0] in_write_register,        //Entrada proveniente del latch 3 EX/MEM
    // Control WB
    input wire in_MemtoReg,
    input wire in_RegWrite,
    input wire step,
    
    // OUTPUTS
    output reg [31:0] out_read_data,         //Salida hacia etapa WB
    output reg [31:0] out_alu_result,        //Salida hacia etapa WB
    output reg [4:0] out_write_register,        //Salida hacia etapa ID
    // Control WB
    output reg out_MemtoReg,
    output reg out_RegWrite
    );
    
    always@(posedge clk)
        if(reset)
        begin
            out_read_data <= 0;
            out_alu_result <= 0;
            out_write_register <= 0;
            // Control WB
            out_MemtoReg <= 0;
            out_RegWrite <= 0;
        end
        else
        if(step) begin
            out_read_data <= in_read_data;
            out_alu_result <= in_alu_result;
            out_write_register <= in_write_register;
            // Control WB
            out_MemtoReg <= in_MemtoReg;
            out_RegWrite <= in_RegWrite;
        end

    
endmodule