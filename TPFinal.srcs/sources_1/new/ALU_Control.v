`timescale 1ns / 1ps

module ALU_Control(
    //INPUTS
    input wire [5:0] funct,
    input wire [5:0] ALUOp,
    //OUTPUTS
    output reg [3:0] operation
    );
    
    parameter [3:0] AND =   4'b0000;
    parameter [3:0] OR =    4'b0001;
    parameter [3:0] XOR =   4'b0010;
    parameter [3:0] NOR =   4'b0011;
    parameter [3:0] ADD =   4'b0100;
    parameter [3:0] SUB =   4'b0101;
    parameter [3:0] LUI =   4'b0110;
    parameter [3:0] SLT =   4'b0111;
    parameter [3:0] SLL =   4'b1000;
    parameter [3:0] SRL =   4'b1001;
    parameter [3:0] SRA =   4'b1010;
    parameter [3:0] SLLV =  4'b1011;
    parameter [3:0] SRLV =  4'b1100;
    parameter [3:0] SRAV =  4'b1101;
         
    wire load_or_store;

	// Si no es ni register ni inmediate ni branch (jump no funciona aca), es un Load o un Store
	assign load_or_store = ( ~ALUOp[1] && ~ALUOp[0] );
    always @(*) 
        begin
       
        if( ALUOp == 6'b000010 ) //Si es Type-R
            case(funct)
                6'b000000: operation <= SLL;  
                6'b000011: operation <= SRL;
                6'b000010: operation <= SRA;
                6'b000100: operation <= SLLV;
                6'b000110: operation <= SRLV;
                6'b000111: operation <= SRAV;
                6'b100001: operation <= ADD;
                6'b100011: operation <= SUB;
                6'b100100: operation <= AND;
                6'b100101: operation <= OR;
                6'b100110: operation <= XOR;
                6'b100111: operation <= NOR;
                6'b101010: operation <= SLT;
                default: operation <= 4'b1111; //VER
            endcase
        else if( load_or_store ) 
            begin
                operation <= ADD;
            end
        else
            case(ALUOp) 
                6'b100011: operation <= ADD;
                6'b110011: operation <= AND;
                6'b110111: operation <= OR;
                6'b111011: operation <= XOR;
                6'b111111: operation <= LUI;
                6'b101011: operation <= SLT;
                default: operation <= 4'b1111; //VER
            endcase
        end
endmodule