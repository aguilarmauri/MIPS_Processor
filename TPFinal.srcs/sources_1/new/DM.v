`timescale 1ns / 1ps

module DM(
    // INPUTS
    input wire clk,
    input wire reset,
    input wire [31:0] in_address,    //Entrada proveniente del latch 3 EX/MEM
    input wire [31:0] in_write_data, //Entrada proveniente del latch 3 EX/MEM
    // Control MEM
    input wire in_MemRead,
    input wire in_MemWrite,
    input wire step,
    
    // OUTPUTS
    output reg [31:0] out_read_data, //Entrada proveniente del latch 3 EX/
    output wire [31:0] ram_0,
    output wire [31:0] ram_1,
    output wire [31:0] ram_2,
    output wire [31:0] ram_3,
    output wire [31:0] ram_4,
    output wire [31:0] ram_5,
    output wire [31:0] ram_6,
    output wire [31:0] ram_7,
    output wire [31:0] ram_8,
    output wire [31:0] ram_9,
    output wire [31:0] ram_10,
    output wire [31:0] ram_11,
    output wire [31:0] ram_12,
    output wire [31:0] ram_13,
    output wire [31:0] ram_14,
    output wire [31:0] ram_15,
    output wire [31:0] ram_16,
    output wire [31:0] ram_17,
    output wire [31:0] ram_18,
    output wire [31:0] ram_19,
    output wire [31:0] ram_20,
    output wire [31:0] ram_21,
    output wire [31:0] ram_22,
    output wire [31:0] ram_23,
    output wire [31:0] ram_24,
    output wire [31:0] ram_25,
    output wire [31:0] ram_26,
    output wire [31:0] ram_27,
    output wire [31:0] ram_28,
    output wire [31:0] ram_29,
    output wire [31:0] ram_30,
    output wire [31:0] ram_31
    );
    
	parameter DATA_BITS = 32;
	parameter ADDR_BITS = 32;
	
	//-- Memoria
    reg [DATA_BITS-1:0] ram [0:31];	// Memoria de 2K. 
	integer i;
	
	//Escritura
	always@(posedge clk)
	   if(reset) begin
	       for(i = 0; i<32; i=i+1)
               ram[i] <= i; 
	       end    
	   else 
	       if(step) begin
               if(in_MemWrite) begin
                   ram[in_address] <= in_write_data; 	     // Escribe el dato entrante en la RAM.
               end
           end
        
    //Lectura
    always @(negedge clk)    
        if(step) begin
           if(in_MemRead) begin
               out_read_data <= ram[in_address];         // Lee la RAM y envia el dato a la salida.       
               end
           end

	assign ram_0 = ram[0];
	assign ram_1 = ram[1];
	assign ram_2 = ram[2];
	assign ram_3 = ram[3];
	assign ram_4 = ram[4];
	assign ram_5 = ram[5];
	assign ram_6 = ram[6];
	assign ram_7 = ram[7];
	assign ram_8 = ram[8];
	assign ram_9 = ram[9];
	assign ram_10 = ram[10];
	assign ram_11 = ram[11];
	assign ram_12 = ram[12];
	assign ram_13 = ram[13];
	assign ram_14 = ram[14];
	assign ram_15 = ram[15];
	assign ram_16 = ram[16];
	assign ram_17 = ram[17];
	assign ram_18 = ram[18];
	assign ram_19 = ram[19];
	assign ram_20 = ram[20];
	assign ram_21 = ram[21];
	assign ram_22 = ram[22];
	assign ram_23 = ram[23];
	assign ram_24 = ram[24];
	assign ram_25 = ram[25];
	assign ram_26 = ram[26];
	assign ram_27 = ram[27];
	assign ram_28 = ram[28];
	assign ram_29 = ram[29];
	assign ram_30 = ram[30];
	assign ram_31 = ram[31];
	
endmodule
