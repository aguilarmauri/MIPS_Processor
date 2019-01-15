`timescale 1ns / 1ps

module tb01_IF(
    );
    reg clk;
    reg reset;
    reg [31:0] in_id_add;
    reg in_PCSrc;
    reg PCWrite;
    wire [31:0] instruction;
    wire [31:0] out_if_add;
    
    IF uut(
        .clk(clk),
        .reset(reset),
        .in_id_add(in_id_add),
        .in_PCSrc(in_PCSrc),
        .PCWrite(PCWrite),
        .instruction(instruction),
        .out_if_add(out_if_add)
    );
    
    initial begin
        clk = 0;
        reset = 0;
        in_id_add = 0;
        in_PCSrc = 0;
        PCWrite = 0;
        
        #100
        reset = 1;
        #100
        PCWrite = 1;
        #50
        reset = 0;
    end
        
    always #1 clk = ~clk;

endmodule
