`timescale 1ns / 1ps

module IM(
    //INPUTS
    input wire clk,
    input wire reset,
    input wire [31:0] address,       //Es de 5 bits porque supuse que son 32 instrucciones nada mas.
    input wire instruction_ready,   //Se pone en 1 cuando se recibe una instruccion por UART
    input wire  [31:0] IM_instruction, //Instruccion proveniente de UART
    //OUTPUTS
    output wire [31:0] instruction, //Para enviar a siguiente etapa
    output wire [511:0] out_instructions_all    //Para transmision
    );
    
    reg [31:0] instruction_temp;
    reg [31:0] instructions [0:15];
    reg start = 0;
    integer counter = 0;
    reg state_next, state_reg;
    
    localparam [31:0] HLT = 32'b111111_00000000000000000000000000; 
    localparam
        loading = 0,
        execute = 1;
    
    always@(posedge clk, posedge reset)
    begin
        if(reset) begin
            state_reg <= loading;
        end
        else begin
            state_reg <= state_next;
        end
    end
          
    always@(negedge clk)
    begin
      state_next = state_reg;
      case(state_reg)
          
          loading:begin
            if(instruction_ready) begin
              instructions[counter] = IM_instruction;
              counter = counter + 1;
              if(IM_instruction == HLT) begin
                  counter = 0;
                  state_next = execute;
              end
            end
          end
          
          execute: begin
              instruction_temp = instructions[address];
              if(instruction_temp == HLT) begin
                  state_next = loading;
              end
          end
          
       endcase
    end
            
//    always@(posedge clk)
//    begin
////        if(start)
////            instruction_temp = instructions[address];
////            if(IM_instruction == HLT) begin
////                start = 0;
////            end
      
//        case(address)     
////            Programa 1
////            0: instruction_temp=32'b000000_00001_00010_00001_00000_100001;        //ADDU $1,$1,$2 
////            1: instruction_temp=32'b000000_00100_00001_00011_00000_100011;        //SUBU $3,$4,$1
////            2: instruction_temp=32'b000000_00001_00011_00001_00000_100001;        //ADDU $1,$1,$3
////            3: instruction_temp=32'b111111_00000_00000_00000_00000_000000;        //HLT
            
////            Programa 2
////            0: instruction_temp=32'b000000_00001_00010_00001_00000_100001;        //ADDU $1,$1,$2
////            1: instruction_temp=32'b000000_00001_00011_00001_00000_100001;        //ADDU $1,$1,$3
////            2: instruction_temp=32'b000000_00001_00100_00001_00000_100001;        //ADDU $1,$1,$4
////            3: instruction_temp=32'b000000_00001_00101_00001_00000_100001;        //ADDU $1,$1,$5
////            4: instruction_temp=32'b111111_00000_00000_00000_00000_000000;        //HLT
            
////            Programa 3 - Pagina 297
////            0: instruction_temp=32'b100011_00100_01010_0000000000000001;          //lw $10, 1($4)
////            1: instruction_temp=32'b000000_00011_00010_01011_00000_100011;        //subu $11, $3, $2
////            2: instruction_temp=32'b000000_00011_00100_01100_00000_100001;        //addu $12, $3, $4
////            3: instruction_temp=32'b100011_00101_01101_0000000000000001;          //lw $13, 1($5)
////            4: instruction_temp=32'b000000_00101_00110_01110_00000_100001;        //add $14, $5, $6
////            5: instruction_temp=32'b111111_00000_00000_00000_00000_000000;        //hlt

////            Programa 4 - Pagina 304
////            0: instruction_temp=32'b000000_00011_00001_00010_00000_100011;        //sub $2, $3,$1
////            1: instruction_temp=32'b000000_00010_00101_01100_00000_100100;        //and $12,$2,$5
////            2: instruction_temp=32'b000000_00110_00010_01101_00000_100101;        //or $13,$6,$2 
////            3: instruction_temp=32'b000000_00010_00010_01110_00000_100001;        //add $14,$2,$2 
////            4: instruction_temp=32'b101011_00010_01100_0000000000001010;          //sw $12,10($2)
////            5: instruction_temp=32'b111111_00000_00000_00000_00000_000000;        //hlt

////              Programa 5  
////            0: instruction_temp = 32'b000000_01000_00100_01010_00000_100011;      //subU $10, $8, $4
////            1: instruction_temp = 32'b000100_00001_00001_0000000000000100;        //beq  $1,  $1, 4        1 + 4 + 1 = 6
////            2: instruction_temp = 32'b000000_00010_00101_01100_00000_100100;      //and  $12, $2, $5
////            3: instruction_temp = 32'b000000_00010_00110_01101_00000_100101;      //or   $13, $2, $6
////            4: instruction_temp = 32'b000000_00100_00010_01110_00000_100001;      //addU $14, $4, $2
////            5: instruction_temp = 32'b000000_00110_00111_01111_00000_101010;      //slt  $15, $6, $7       6 < 7
////            6: instruction_temp = 32'b100011_00111_00100_0000000000000001;        //lw   $4,  1($7)
////            7: instruction_temp = 32'b111111_00000_00000_00000_00000_000000;      //hlt

////            Programa 6 - Usa instrucciones type-J
////            0: instruction_temp = 32'b000000_00011_00100_00101_00000_100001;        // ADDU $5,$3,$4
////            1: instruction_temp = 32'b000010_00000000000000000000000101;			  // J 5
////            2: instruction_temp = 32'b100011_00101_00110_0000000000000010;         // LW $6,2($5)
////            3: instruction_temp = 32'b101011_00001_00010_0000000000000111;         // SW $2, 7($1)
////            4: instruction_temp = 32'b001000_00011_00101_0000000000001000;         // ADDI $5,$3,8
////            5: instruction_temp = 32'b101011_00010_01001_0000000000000110;         // SW $9, 6($2)
////            6: instruction_temp = 32'b001101_00011_00111_0000000000010101;         // ORI $7,$3,21
////            7: instruction_temp = 32'b100011_00111_01110_0000000000000011;         // LW $14,3($7)
////            8: instruction_temp = 32'b111111_00000_00000_00000_00000_000000;    	  // HLT
        
            
        
//            0: instruction_temp = 32'b100011_00101_00010_0000000000000100;	      // LW $2,4($5) 	$2 = 9
//            1: instruction_temp = 32'b001000_00010_00010_0000000000000001;         // ADDI $2,$2,1
//            2: instruction_temp = 32'b000101_00010_01100_1111111111111110;         // BNE $2,$12,-2
//            3: instruction_temp = 32'b000010_00000000000000000000000110;			  // J 6
//            4: instruction_temp = 32'b001101_00011_00111_0000000000010101;         // ORI $7,$3,21
//            5: instruction_temp = 32'b000000_00011_00100_00101_00000_100001;       // ADDU $5,$3,$4
//            6: instruction_temp = 32'b101011_00001_00010_0000000000000000;         // SW $2, 0($1)
//            7: instruction_temp = 32'b111111_00000_00000_00000_00000_000000;    	 // HLT

//            default: instruction_temp=32'b111111_00000_00000_00000_00000_000000;
//        endcase
//    end
    
    assign instruction = instruction_temp;
    assign out_instructions_all = {
        instructions[0],instructions[1],instructions[2],instructions[3],
        instructions[4],instructions[5],instructions[6],instructions[7],
        instructions[8],instructions[9],instructions[10],instructions[11],
        instructions[12],instructions[13],instructions[14],instructions[15]
        };
endmodule
