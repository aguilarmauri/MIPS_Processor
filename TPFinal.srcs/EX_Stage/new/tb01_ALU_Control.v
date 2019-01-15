`timescale 1ns / 1ps

module tb01_ALU_Control(
    );
    reg [5:0] funct;
    reg [5:0] ALUOp;
    wire [3:0] operation;
    
    ALU_Control uut(
        funct,ALUOp,
        operation
        );
    
    initial begin
        ALUOp = 6'b000010;
        funct = 6'b000000;
        #80 funct = 6'b000000; //SLL
        #80 funct = 6'b000010; //SRA
        #80 funct = 6'b000011; //SRL
        #80 funct = 6'b100001; //ADDU
        #80 funct = 6'b100100; //ANDU
        #80 funct = 6'b101010; //SLT
        #80 ALUOp = 6'b100011; //ADDI
        #80 ALUOp = 6'b001100; //LW 
        #80 ALUOp = 6'b000100; //SH
        #80 ALUOp = 6'b110011; //ANDI
    end
        
endmodule