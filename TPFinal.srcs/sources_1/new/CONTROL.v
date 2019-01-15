`timescale 1ns / 1ps

module CONTROL( 
    //INPUTS
    input wire reset,
    input wire [5:0] in_opcode,
    input wire [3:0] funct,
    input wire [31:0] in_instruction,
    //OUTPUTS
    output reg RegDst, 
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg [5:0] ALUOp,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite,
    output reg out_op_shamt,
    output reg enable_pc
    );
    
    wire load, store, register, branch, inmediate, jump;
    wire op_shamt;
    
    //R-Type
    assign register = (~in_opcode[5]) && (~in_opcode[4]) && (~in_opcode[3]) &&
               (~in_opcode[2]) && (~in_opcode[1]) && (~in_opcode[0]);    //000 000
    assign op_shamt = register && ((~funct[3]) && (~funct[2]) && (~funct[1]) && (~funct[0]));
    //I-Type
    assign load = in_opcode[5] && (~in_opcode[4]) && (~in_opcode[3]);            //100
    assign store = in_opcode[5] && (~in_opcode[4]) && in_opcode[3];            //101
    assign inmediate = (~in_opcode[5]) && (~in_opcode[4]) && in_opcode[3];        //001
    assign branch = (~in_opcode[5]) && (~in_opcode[4]) && (~in_opcode[3]) && 
             in_opcode[2];                                              //000 1
    //J-Type
    assign jump = (~in_opcode[5]) && (~in_opcode[4]) && (~in_opcode[3]) &&
           (~in_opcode[2]) && in_opcode[1];                                //000 01

    
    always@(*)
        begin                        
            if(reset)
                begin
                    RegDst <= 0;
                    Branch <= 0;
                    ALUSrc <= 0;
                    MemtoReg <= 0;
                    RegWrite <= 0;
                    MemRead <= 0;
                    MemWrite <= 0;
                    ALUOp <= 0;
                    out_op_shamt <= 0;
                    enable_pc <= 0; 
                end
            else
                if(in_opcode == 6'b111111)
                    begin
                        RegDst <= 0;
                        Branch <= 0;
                        ALUSrc <= 0;
                        MemtoReg <= 0;
                        RegWrite <= 0;
                        MemRead <= 0;
                        MemWrite <= 0;
                        ALUOp <= 0;   
                        out_op_shamt <= 0;    
                        enable_pc <= 0;         
                    end
                else
                    begin
                        MemRead     <= load;        //La unica instruccion que lee de la memoria
                        Branch      <= (branch || jump);		//Instruccion que realiza un branch
                        MemWrite    <= store;		//La instruccion desencadena una escritura en memoria
                        MemtoReg    <= load;		//La instruccion guarda un dato de memoria en un registro
                        RegDst      <= register;	//Un dato se guardara en el registro
                        RegWrite    <= (load || register || inmediate);	//Se escribira en un registro
                        ALUSrc      <= (load || store || inmediate || op_shamt);    //Multiplexor de segunda entrada de la ALU
                        ALUOp[0]    <= (branch || inmediate);
                        ALUOp[1]    <= (register || inmediate);
                        ALUOp[2]    <= in_opcode[0];
                        ALUOp[3]    <= in_opcode[1];
                        ALUOp[4]    <= in_opcode[2];
                        ALUOp[5]    <= inmediate;
                        out_op_shamt <= op_shamt;
                        enable_pc   <= 1;
                    end
        end
    
endmodule