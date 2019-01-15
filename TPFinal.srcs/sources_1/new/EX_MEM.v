`timescale 1ns / 1ps

module EX_MEM(
    //INPUTS
    input wire clk,
    input wire reset,
    input wire [31:0] in_alu_result,
    input wire [31:0] in_read_data_2,
    input wire [4:0] in_write_register,
    // Control MEM
    input wire in_MemRead,
    input wire in_MemWrite,
    // Control WB
    input wire in_MemtoReg,
    input wire in_RegWrite,
    input wire step,
    
    //OUTPUTS
    output reg [31:0] out_alu_result,
    output reg [31:0] out_read_data_2,
    output reg [4:0] out_write_register,
    // Control MEM
    output reg out_MemRead,
    output reg out_MemWrite,
    // Control WB
    output reg out_MemtoReg,
    output reg out_RegWrite
    );
    
    always@(posedge clk) 
    begin
        if(reset)
        begin
            out_alu_result <= 0;
            out_read_data_2 <= 0;
            out_write_register <= 0;
            // Control MEM
            out_MemRead <= 0;
            out_MemWrite <= 0;
            // Control WB
            out_MemtoReg <= 0;
            out_RegWrite <= 0;
        end
        else
            if(step) begin
                out_alu_result <= in_alu_result;
                out_read_data_2 <= in_read_data_2;
                out_write_register <= in_write_register;
                // Control MEM
                out_MemRead <= in_MemRead;
                out_MemWrite <= in_MemWrite;
                // Control WB
                out_MemtoReg <= in_MemtoReg;
                out_RegWrite <= in_RegWrite;
            end
    end
endmodule
