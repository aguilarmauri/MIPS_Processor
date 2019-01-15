`timescale 1ns / 1ps

module PC(
    //INPUTS
    input wire clk,
    input wire reset,
    input wire [31:0] in_mux,   //Proviene del MUX de la etapa IF
	input wire PCWrite,    //Proviene del stall
	input wire enable_pc,  //Habilita el PC en caso de ser una instruccion valida
	input wire step,   //Habilita el PC desde UART
    //OUTPUTS
    output reg [31:0] out_pc   //Salida que va hacia el sumador y hacia el bloque IM
    );
    
    reg [31:0] pc; 
    
    always@(posedge clk)
    begin
        if(reset)
            out_pc <= 0;
        else
            if(enable_pc && step) // step = esta apretado el boton, puede ejecutar
			    if(PCWrite)			
				    out_pc <= $signed(in_mux);
			    else
				    out_pc <= out_pc;
		    else
		        out_pc <= out_pc;
    end
        
endmodule
