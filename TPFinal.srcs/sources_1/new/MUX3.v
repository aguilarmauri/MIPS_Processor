`timescale 1ns / 1ps

module MUX3 #(parameter BITS=32)
    (
    input wire [1:0] selector,
    input wire [31:0] in_A,
    input wire [31:0] in_B,
    input wire [31:0] in_C,
    //OUTPUTS
    output reg [31:0] out_mux
    );
       
    always@(*) 
        begin
            //mux = mux;
            if(selector == 2'b00)
                out_mux = in_A;
            else
                if(selector == 2'b01)
                    out_mux = in_B;
                else
                    if(selector == 2'b10)
                        out_mux = in_C;
                    else
                        out_mux = 0;
        end
        
endmodule
