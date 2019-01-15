`timescale 1ns / 1ps

module ALU(
    //INPUTS
    input wire reset,
    input wire [31:0] in_data_read_1,
    input wire [31:0] in_ex_mux,
    input wire [3:0] operation,
    //OUTPUTS
    output wire out_zero,
    output wire [31:0] alu_result
    );
    
    reg [31:0] result;
    reg zero;
    
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
    
    always @(*) 
        begin
        if (reset == 1)
            begin 
                result <= 0;
                zero <= 1;
            end
        else
            begin
            case(operation)
                    // rs AND rt or rs AND inmediate
                AND:    result <= in_data_read_1 & in_ex_mux;   
                    // rs OR rt or rs OR inmediate
                OR:     result <= in_data_read_1 | in_ex_mux;
                    // rs XOR rt or rs XOR inmediate
                XOR:    result <= in_data_read_1 ^ in_ex_mux;
                    // rs NOR rt
                NOR:    result <= ~(in_data_read_1 | in_ex_mux);
                    // load or store or rs+rt
                ADD:    result <= in_data_read_1 + in_ex_mux;
                    // rs - rt or branch equal   
                SUB:    result <= in_data_read_1 - in_ex_mux;
                    // inmediate || 0^16   
                LUI:    result <= in_ex_mux | 16'b0000_0000_0000_0000;
                    // rs < rt
                SLT:    result <= $signed(in_data_read_1) < $signed(in_ex_mux); 
                SLL:    result <= in_data_read_1 << in_ex_mux[10:6];   
                SRL:    result <= in_data_read_1 >> in_ex_mux[10:6];   
                SRA:    result <= in_data_read_1 >>> in_ex_mux[10:6];  
                SLLV:   result <= in_ex_mux << in_data_read_1;
                SRLV:   result <= in_ex_mux >> in_data_read_1;
                SRAV:   result <= in_ex_mux >>> in_data_read_1;
                default : result <= 0;
            endcase
            
            if(alu_result == 0)
                zero <= 1;
            else
                zero <= 0;
            end
        end
    
    assign alu_result = result;
    assign out_zero = zero;
    
endmodule

