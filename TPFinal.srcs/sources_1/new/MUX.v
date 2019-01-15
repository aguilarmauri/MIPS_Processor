`timescale 1ns / 1ps

module MUX #(parameter BITS=32)
    (
    input wire selector,       //Tiene valor 1 o 0
    input wire [BITS-1:0] in_0,    //Entrada 0 del selector
    input wire [BITS-1:0] in_1,    //Entrada 1 del selector
    
    output reg [BITS-1:0] out_mux  
    );
    
    always@(*) 
    begin
        if(selector)
            out_mux = in_1;
        else
            out_mux = in_0;
    end
    
endmodule
