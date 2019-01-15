`timescale 1ns / 1ps

module WB(
    //INPUTS
    input wire [31:0] in_read_data,
    input wire [31:0] in_alu_result,    
    // Control WB
    input wire in_MemtoReg,
    
    //OUTPUTS
    output wire [31:0] out_mux
    );
    
    // Cuanto in_MemtoReg==1, es un LOAD, y leo el dato de memoria: in_read_data
    MUX wb_mux(
        in_MemtoReg, in_alu_result, in_read_data,
        out_mux
        );
    
endmodule
