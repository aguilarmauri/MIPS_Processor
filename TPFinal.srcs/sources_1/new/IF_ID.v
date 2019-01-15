`timescale 1ns / 1ps

module IF_ID(
    //INPUTS
    input wire clk,
    input wire reset,                    
    input wire [31:0] in_if_add,
    input wire [31:0] in_instruction,
	input wire IFDWrite,
	input wire IF_Flush,
	input wire step,
    //OUTPUTS
    output reg [31:0] out_instruction,
    output reg [31:0] out_if_add
    );
    
    reg [31:0] instruction;
    reg [31:0] if_add;
    
    always@(posedge clk)
    begin
        if(reset)
            begin
                out_if_add <= 0;
                out_instruction <= 0;
            end
        else
            if(step) begin
                if(~IFDWrite) //Si no es noSTALL, si es STALL
                    begin
                        out_if_add <= out_if_add;
                        out_instruction <= out_instruction;
                    end
                else if(IF_Flush)
                    begin
                        out_if_add <= out_if_add;
                        out_instruction <= 0;
                    end
                else
                    begin
                        out_if_add <= in_if_add;
                        out_instruction <= in_instruction;
                    end  			
            end
    end    
    
endmodule
