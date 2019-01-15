`timescale 1ns / 1ps

module tb01_ALU(
    );
    reg reset;
    reg [31:0] in_data_read;
    reg [31:0] in_ex_mux;
    reg [3:0] operation;
    wire zero;
    wire [31:0] result;
    
    ALU uut(
        reset,in_data_read,in_ex_mux,operation,
        zero,result
        );
    
    initial begin
        reset = 1;
        in_data_read = 10;
        in_ex_mux = 3;
        #100 reset = 0;
        operation = 4'b0000; //AND
        #100 operation = 4'b0001;
        #100 operation = 4'b0100;
        #100 operation = 4'b0101;
        #100 operation = 4'b1000;
        #100 operation = 4'b1001;
        #100 operation = 4'b1100;
    end
endmodule