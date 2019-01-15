`timescale 1ns / 1ps

module tb01_EX(
    );
    reg reset;
    reg [31:0] in_read_data_1;
    reg [31:0] in_read_data_2; 
    reg [31:0] in_sign_extend;
    reg [4:0] in_registerRd;
    reg [4:0] in_registerRt;
    reg RegDst; 
    reg [5:0] ALUOp;
    reg ALUSrc;
    reg [1:0] forwardA;
    reg [1:0] forwardB;
    reg [31:0] in_wb_mux;
    reg [31:0] in_exmem_address;
    wire [31:0] alu_result;
    wire out_zero;
    wire [31:0] out_read_data_2;
    wire [4:0] out_write_register;
    
    EX uut(
        .reset(reset),.in_read_data_1(in_read_data_1),.in_read_data_2(in_read_data_2),
            .in_sign_extend(in_sign_extend),.in_registerRd(in_registerRd),
            .in_registerRt(in_registerRt),.RegDst(RegDst),.ALUOp(ALUOp),.ALUSrc(ALUSrc),
            .forwardA(forwardA),.forwardB(forwardB),.in_exmem_address(in_exmem_address),
        .alu_result(alu_result),.out_zero(out_zero),.out_read_data_2(out_read_data_2),
            .out_write_register(out_write_register)
        );
        
    initial begin
        reset = 0;
        #100
        reset = 1;
        in_read_data_1 = 10;    //Dato1 = 10
        in_read_data_2 = 3;     //Dato2 = 3
        in_sign_extend = 32'b100001;    //funct ADDU
        in_registerRd = 6;      //Indistinto -> Registro $6 
        in_registerRt = 7;      //Indistinto -> Registro $7
        RegDst = 0;             //Elige $6
        ALUOp = 6'b000010;              //Tipo-R
        ALUSrc = 0;             //Elige Dato2 en lugar de Sign_extend
        forwardA = 0;           //Elige Dato1 en lugar de in_wb_mux o in_exmem_address
        forwardB = 0;           //Elige Dato2 en lugar de in_wb_mux o in_exmem_address
        in_wb_mux = 0;          //Indistinto
        in_exmem_address = 0;   //Indistinto
        #100 reset = 0;
        //NO ENTIENDOOOOOO POR QUEEE ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ!!!!!!!!
    end
endmodule