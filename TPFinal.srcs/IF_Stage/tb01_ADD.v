`timescale 1ns / 1ps

module tb01_ADD(
    );
    reg [31:0] in_add_1;
    reg [31:0] in_add_2;
    wire [31:0] out_add;
    
    ADD uut(
        in_add_1,in_add_2,
        out_add
        );
    
    initial begin
        in_add_1 = 0;
        in_add_2 = 0;
        
        #100
        in_add_1 = 4;
        in_add_2 = 5;
        #100 in_add_1 = 9;
        #100 in_add_2 = 53;
        #100 in_add_2 = 8;
    end
endmodule
