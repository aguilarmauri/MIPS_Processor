`timescale 1ns / 1ps

module tb01_IM(
    );
    reg [31:0] address;
    wire [31:0] instruction;
    
    IM uut(
        address,
        instruction
        );
    
    initial begin
        address = 0;
        
        #200 address = 1;
        #200 address = 2;
        #200 address = 3;
        #200 address = 4;    
    end
    
endmodule
