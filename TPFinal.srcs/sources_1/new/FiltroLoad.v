`timescale 1ns / 1ps

module FiltroLoad(
    //INPUTS
    input wire [5:0] in_opcode,
    input wire [31:0] in_wb_mux,
    //OUTPUTS
    output wire [31:0] out_write_data
    );
    
    reg [31:0] write_data;
    
    parameter [5:0] LB = 6'b100000;
    parameter [5:0] LH = 6'b100001;
    parameter [5:0] LW = 6'b100011;
    parameter [5:0] LBU = 6'b100100;
    parameter [5:0] LHU = 6'b100101;
    parameter [5:0] LWU = 6'b100111;
    
    always@(*)
        begin
            case(in_opcode) 
                LB: write_data = $signed(in_wb_mux[7:0]);
                LH: write_data = $signed(in_wb_mux[15:0]);
                LW: write_data = $signed(in_wb_mux);
                LBU: write_data = in_wb_mux[7:0];
                LHU: write_data = in_wb_mux[15:0];
                LWU: write_data = in_wb_mux;
                default: write_data = in_wb_mux;   //El resto de las instrucciones
                                                            //entran en el default   
            endcase
        end
    
    assign out_write_data = write_data;
endmodule
