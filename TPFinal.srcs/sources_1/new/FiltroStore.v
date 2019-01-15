`timescale 1ns / 1ps

module FiltroStore(
    input wire [5:0] in_opcode,
    input wire [31:0] out_mux3_B,
    output wire [31:0] out_read_data_2
      );

    reg [31:0] read_data_2;
    
    always @(*) 
    begin  
        case(in_opcode)
             6'b101000: read_data_2 <= out_mux3_B[7:0];        // SB
             6'b101001: read_data_2 <= out_mux3_B[15:0];       // SH
             default: read_data_2 <= out_mux3_B;
         endcase
    end
    
    assign out_read_data_2 = read_data_2;
    
endmodule


  