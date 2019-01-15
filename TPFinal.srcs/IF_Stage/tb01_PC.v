`timescale 1ns / 1ps

module tb01_PC(
    );
    reg clk;
    reg reset;
    reg [31:0] in_mux;
    reg PCWrite;
    wire [31:0] out_pc;
    
    PC uut(
        clk,reset,in_mux,PCWrite,
        out_pc
        );
    
    initial begin
        clk = 0;
        reset = 0;
        in_mux = 0;
        PCWrite = 0;
        
        #100 reset = 1;
        #100 PCWrite = 1;
        #100 in_mux = 1;
        #100 reset = 0;
        #100 in_mux = 2;
        
    end
    
    always #1 clk = ~clk;
endmodule
