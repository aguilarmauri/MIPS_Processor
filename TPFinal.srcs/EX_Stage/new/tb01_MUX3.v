`timescale 1ns / 1ps

module tb01_MUX3(
    );
    reg [1:0] selector;
    reg [31:0] in_A;
    reg [31:0] in_B;
    reg [31:0] in_C;
    wire [31:0] out;
    
    MUX3 uut(
        selector,in_A,in_B,in_C,
        out
        );
    
    initial begin
        selector = 0;
        
        #100 in_A = 10;
        in_B = 20;
        in_C = 30;
        #300 selector = 1;
        #300 selector = 2;
         
    end
endmodule