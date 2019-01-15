`timescale 1ns / 1ps

module ADD(
    //INPUTS
    input wire [31:0] in_add_1,     //Primera entrada del modulo ADD
    input wire [31:0] in_add_2,     //Segunda entrada del modulo ADD 
    //OUTPUTS
    output wire [31:0] out_add
    );
    
    assign out_add = in_add_1 + in_add_2;
    
endmodule
