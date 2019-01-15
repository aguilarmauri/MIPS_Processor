`timescale 1ns / 1ps

module FU(
    //INPUTS
    input wire clk,
    input wire [4:0] in_registerRs,
    input wire [4:0] in_registerRt,
    input wire [4:0] in_exmem_registerRd,
    input wire [4:0] in_memwb_registerRd,
    input wire in_exmem_RegWrite,
    input wire in_memwb_RegWrite,
    //OUTPUTS
    output wire [1:0] out_forwardA,
    output wire [1:0] out_forwardB
    );
    
    reg [1:0] forwardA;
    reg [1:0] forwardB;
    
    always@(*)
        begin
            //EX
            if( in_exmem_RegWrite &&
                (in_exmem_registerRd == in_registerRs) )
                    forwardA = 2'b10;    
            //MEM
            else if(    in_memwb_RegWrite && 
                        (in_memwb_registerRd == in_registerRs))
                    forwardA = 2'b01;
            else
                forwardA = 2'b00;
            
            //EX            
            if( in_exmem_RegWrite &&
                (in_exmem_registerRd == in_registerRt))
                    forwardB = 2'b10;
            //MEM
            else if(    in_memwb_RegWrite &&  
                        (in_memwb_registerRd == in_registerRt))
                    forwardB = 2'b01;
            else 
                forwardB = 2'b00;
        end
        
    assign out_forwardA = forwardA;
    assign out_forwardB = forwardB;
    
endmodule
