`timescale 1ns / 1ps

module HU(
	//INPUTS
	// hazards de datos
	input wire in_IDEX_MemRead,
	input wire in_Branch,
	input wire [4:0] in_IDEX_RegisterRt,
	input wire [4:0] in_IFID_RegisterRs,
	input wire [4:0] in_IFID_RegisterRt,
	
	//OUTPUTS
	output wire out_noStall
   );
	
	// 
	assign out_noStall = ~(
	   (in_IDEX_MemRead)   //Load o Branch
	   && ((in_IDEX_RegisterRt == in_IFID_RegisterRs) 
	   || (in_IDEX_RegisterRt == in_IFID_RegisterRt))
	   );
	

endmodule
