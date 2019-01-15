`timescale 1ns / 1ps

module tb01_tpf(
    );
    reg clk;
    reg reset;
    reg boton;
    wire tx;
    wire led1;
    wire led2;
    wire led3;
    wire led4;
    wire led5;
    wire led6;

    // Instantiate the Unit Under Test (UUT)
    TPF uut (
        .clk(clk),
        .reset(reset),
        .boton(boton),
        .tx(tx),
        .led1(led1),
        .led2(led2),
        .led3(led3),
        .led4(led4),
        .led5(led5),
        .led6(led6)
    );

    initial begin
            clk = 0;
            reset = 1;
            step=1;
            #40 reset = 0;
            
        end
    always #20 clk = ~clk;
endmodule