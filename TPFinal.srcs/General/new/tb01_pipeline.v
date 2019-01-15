`timescale 1ns / 1ps

module tb01_pipeline(
    );
    reg clk;
    reg reset;
    reg step;
    reg instruction_ready;
    reg [31:0] IM_instruction;
    // Instantiate the Unit Under Test (UUT)
    Pipeline uut (
        .clk(clk),
        .reset(reset),
        .step(step),
        .instruction_ready(instruction_ready),
        .IM_instruction(IM_instruction)
    );

    initial begin
        clk = 0;
        reset = 1;
        step=1;
        #40 reset = 0;
        
    end
    always #20 clk = ~clk;
endmodule