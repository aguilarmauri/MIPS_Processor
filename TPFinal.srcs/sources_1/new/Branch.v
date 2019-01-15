`timescale 1ns / 1ps

module Branch(
    input reset,
    input [5:0] opcode,
    input [5:0] funct,
    input [31:0] in_read_data1,
    input [31:0] in_read_data2,
    input [31:0] pc_next,
    input [31:0] in_sign_extend,
    input [25:0] instr_index,
    output reg taken,
    output reg [31:0] pc_branch,
    output reg out_jal,
    output reg out_jalr
    );
     
    localparam BEQ = 6'b000100;
    localparam BNE = 6'b000101;
    localparam J = 6'b000010;
    localparam JAL = 6'b000011;
    localparam REG = 6'b000000;
    localparam JR = 6'b001000;
    localparam JALR = 6'b001001;

	always @(*) begin
		if (reset)
		  begin
            pc_branch <= 0;
			taken <= 0;
			out_jal <= 0;
			out_jalr <= 0;
		  end
		else 
		  begin
			case(opcode)
				BEQ: begin
                    if(in_read_data1 == in_read_data2) begin
                        pc_branch <= $signed(pc_next) + $signed(in_sign_extend);
                        taken <= 1;
                        out_jal <= 0;
                        out_jalr <= 0;
                    end
                    else begin
                        pc_branch <= 0; //Indistinto. El taken dice que toma el PC del IF, no del ID
                        taken <= 0;
                        out_jal <= 0;
                        out_jalr <= 0;
                        end
                    end
				BNE: begin
                    if(in_read_data1 != in_read_data2) begin
                        pc_branch <= $signed(pc_next) + $signed(in_sign_extend);
                        taken <= 1;
                        out_jal <= 0;
                        out_jalr <= 0;
                    end
                    else begin
                        pc_branch <= 0;
                        taken <= 0;
                        out_jal <= 0;
                        out_jalr <= 0;
                    end
                end
				J: begin
                        pc_branch <= {pc_next[31:28],2'b00,instr_index}; 
                        taken <= 1;
                        out_jal <= 0;
                        out_jalr <= 0;
                    end
                JAL: begin 
                        pc_branch <= {pc_next[31:28],2'b00,instr_index};
                        taken <= 1;
                        out_jal <= 1;   //guarda el PC+1 en Regs[31]
                        out_jalr <= 0;
                    end
                REG:
                    case(funct)
                        JR: begin
                                pc_branch <= in_read_data1; //Reg RS
                                taken <= 1;
                                out_jal <= 0;
                                out_jalr <= 0; 
                            end
                        JALR: begin
                                pc_branch <= in_read_data1; //Reg RS
                                taken <= 1; 
                                out_jalr <= 1;
                                out_jal <= 0;
                            end
                        default: begin
                                pc_branch <= 0;
                                taken <= 0;
                                out_jalr <= 0;
                                out_jal <= 0;
                            end
                    endcase
				default: begin
                            pc_branch <= 0;
                            taken <= 0;
                            out_jal <= 0;
                            out_jalr <= 0;
						end
			endcase
		end
	end
	
endmodule

