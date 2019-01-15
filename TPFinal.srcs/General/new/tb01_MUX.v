`timescale 1ns / 1ps

module tb01_MUX(
    );
    reg selector;
    reg [32-1:0] in_0;
    reg [32-1:0] in_1;
    wire [32-1:0] out_mux;
    
    MUX uut(
        selector,in_0,in_1,
        out_mux
        );
    
    initial begin
        selector = 0;
        in_0 = 0;
        in_1 = 0;
        
        #100
        in_0 = 4;
        in_1 = 9;
        #100
        selector = 1;
        #100
        in_0 = 33;
        #50
        selector = 0;
        #200
        selector = 1;
    end
endmodule
