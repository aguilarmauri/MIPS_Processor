`timescale 1ns / 1ps

module BRG(
    //INPUTS
    input clk,
    //OUTPUTS
	output reg tick
    );
    
    parameter FreqClock = 100000000;	//100Mhz
	parameter BaudRate = 19200;	//Frecuencia de muestreo
	parameter Ticks = 16;			//Muestras por BaudRate
	parameter max=FreqClock/(BaudRate*16);
	reg [8:0] contador = 0;
	
	always @(posedge clk) //Memory
	begin
		contador = contador + 1;
		if(contador > max)
			begin
				tick = 1;
				contador = 0;
			end
		else
			tick = 0;
	end
endmodule
