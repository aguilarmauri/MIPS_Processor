`timescale 1ns / 1ps

module ClockCounter(
    //INPUTS
    input wire clk,
    input wire reset,
    input wire step,
    //OUTPUTS
    output reg [7:0] contador_clk 
    );
    
        always@(posedge clk, posedge reset)
            begin
            if(reset)
                contador_clk = 0;
            else
                if(step)
                    contador_clk = contador_clk +1;
            end
endmodule
