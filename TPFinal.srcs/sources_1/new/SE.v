`timescale 1ns / 1ps

module SE(
    input wire [15:0] in_instruction,      //Entrada proveniente del latch 1 IF/ID
    output wire [31:0] out_sign            //Salida hacia latch 2 ID/EX
    );
   
   assign out_sign = $signed(in_instruction);    // La funcion signed extiende el dato CON signo

endmodule


