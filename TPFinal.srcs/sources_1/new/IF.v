`timescale 1ns / 1ps

module IF(
    //INPUTS
    input wire clk,
    input wire reset,
    input wire [31:0] in_id_add,   //Salida del sumador de la etapa EXECUTION
    // Control Branch:MEM -> Mux:IF
    input wire in_PCSrc,
	input wire PCWrite,
	input wire enable_pc,
    input wire step,
    input wire instruction_ready,
    input wire  [31:0] IM_instruction,
                 
    //OUTPUTS
    output wire [31:0] instruction,  //Salida del Instruction Memory
    output wire [31:0] out_if_add,    //Salida del sumador de la etapa IF
    output wire [511:0] out_instructions_all,
    output wire [31:0] out_pc     //Salida del PC
    );
    
    wire [31:0] out_mux;       //Salida del MUX de la etapa IF
    wire [31:0] out_add;
    
    MUX #(32) if_mux(
        in_PCSrc, out_add, in_id_add, 
        out_mux
        );
    PC pc(
        clk, reset,out_mux,PCWrite,enable_pc, step,
        out_pc
        );
    ADD add(
        out_pc, 32'b1, 
        out_add)
        ;  
    IM instruction_memory(
        clk,reset,out_pc,instruction_ready,IM_instruction,
        instruction,out_instructions_all
        ); 
    
    assign out_if_add = out_add;
    
endmodule
