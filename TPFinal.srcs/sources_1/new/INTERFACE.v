`timescale 1ns / 1ps

module INTERFACE
    (
    //INPUTS
    input wire clk,
    input wire reset,
    input wire boton,                               //Boton de la placa que habilita la TX
    input wire tx_done_tick,
        //IF
    input wire [31:0] out_if_add,                  //Proximo PC
    input wire [31:0] out_instruction,             //Instruccion a ejecutar
        //IF_ID
    input wire [31:0] out_ifid_add,                //Proximo PC
    input wire [31:0] out_ifid_instruction,        //Instruccion a ejecutar
        //ID
    input wire [31:0] out_pc_branch,               //Proximo PC a saltar
    input wire [31:0] out_read_data_1,             //Dato del registro RS
    input wire [31:0] out_read_data_2,             //Dato del registro RT
    input wire [31:0] out_id_sign,                 //Sign_extend de los bits [15:0]
    input wire [4:0]  out_id_register_Rd,          //Registro RD
    input wire [4:0] out_id_register_Rt,           //Registro RT
    input wire [4:0] out_id_register_Rs,           //Registro RS
    input wire [5:0] out_opcode,                   //Opcode   
    input wire [31:0] reg_0,
    input wire [31:0] reg_1,
    input wire [31:0] reg_2,
    input wire [31:0] reg_3,
    input wire [31:0] reg_4,
    input wire [31:0] reg_5,
    input wire [31:0] reg_6,
    input wire [31:0] reg_7,
    input wire [31:0] reg_8,
    input wire [31:0] reg_9,
    input wire [31:0] reg_10,
    input wire [31:0] reg_11,
    input wire [31:0] reg_12,
    input wire [31:0] reg_13,
    input wire [31:0] reg_14,
    input wire [31:0] reg_15,
    input wire [31:0] reg_16,
    input wire [31:0] reg_17,
    input wire [31:0] reg_18,
    input wire [31:0] reg_19,
    input wire [31:0] reg_20,
    input wire [31:0] reg_21,
    input wire [31:0] reg_22,
    input wire [31:0] reg_23,
    input wire [31:0] reg_24,
    input wire [31:0] reg_25,
    input wire [31:0] reg_26,
    input wire [31:0] reg_27,
    input wire [31:0] reg_28,
    input wire [31:0] reg_29,
    input wire [31:0] reg_30,
    input wire [31:0] reg_31,            
        //ID_EX
    input wire [31:0] out_idex_read_data_1,        //Dato del registro RS que sale de IDEX
    input wire [31:0] out_idex_read_data_2,        //Dato del registro RT que sale de IDEX
    input wire [31:0] out_idex_sign,               //Sign_extend de los bits [15:0]
    input wire [4:0]  out_idex_register_Rd,        //Registro RD   
    input wire [4:0] out_idex_register_Rt,         //Registro RT
    input wire [4:0] out_idex_register_Rs,         //Registro RS 
    input wire [5:0] out_idex_opcode,              //Opcode
        //EX
    input wire [31:0] out_alu_result,              //Resultado de ALU
    input wire [4:0] out_ex_write_register,        //Write register saliendo de EX
    input wire [31:0] in_ex_read_data_2,           
        //EX_MEM
    input wire [31:0] out_exmem_alu_result,
    input wire [31:0] in_exmem_read_data_2,
    input wire [4:0] out_exmem_write_register,
        //MEM
    input wire [31:0] out_mem_alu_result,
    input wire [31:0] out_read_data,
    input wire [4:0] out_mem_write_register,
    input wire [31:0] ram_0,
    input wire [31:0] ram_1,
    input wire [31:0] ram_2,
    input wire [31:0] ram_3,
    input wire [31:0] ram_4,
    input wire [31:0] ram_5,
    input wire [31:0] ram_6,
    input wire [31:0] ram_7,
    input wire [31:0] ram_8,
    input wire [31:0] ram_9,
    input wire [31:0] ram_10,
    input wire [31:0] ram_11,
    input wire [31:0] ram_12,
    input wire [31:0] ram_13,
    input wire [31:0] ram_14,
    input wire [31:0] ram_15,
    input wire [31:0] ram_16,
    input wire [31:0] ram_17,
    input wire [31:0] ram_18,
    input wire [31:0] ram_19,
    input wire [31:0] ram_20,
    input wire [31:0] ram_21,
    input wire [31:0] ram_22,
    input wire [31:0] ram_23,
    input wire [31:0] ram_24,
    input wire [31:0] ram_25,
    input wire [31:0] ram_26,
    input wire [31:0] ram_27,
    input wire [31:0] ram_28,
    input wire [31:0] ram_29,
    input wire [31:0] ram_30,
    input wire [31:0] ram_31,   
        //MEM_WB
    input wire [31:0] out_memwb_read_data,
    input wire [31:0] out_memwb_alu_result,
    input wire [4:0] out_memwb_write_register,     
        //WB
    input wire [31:0] out_wb_mux,                  //Dato a guardar en write_register       
        //ClockCounter
    input wire [7:0] counter_clk,
    
        //RX
    input wire rx_done_tick,
    input wire [7:0] recv_data_reg,
    input wire enable_pc,
    input wire [511:0] out_instructions_all,
    input wire [31:0] pc,
    input wire taken,
    input wire [31:0] out_mux3_A,
    input wire [31:0] out_mux3_B,
    input wire [31:0] out_ex_mux,
    //OUTPUTS
    output reg send_data_reg,
    output reg [7:0] write_data_reg,
    output reg instruction_ready,
    output reg [31:0] IM_instruction,
    output reg led1_reg,
    output reg led2_reg,
    output reg led3_reg,
    output reg led4_reg,
    output reg led5_reg,
    output reg step_reg
    );
    
    // Para transmision
    reg send_data_next;     //Bit para enviar dato por uart 
    reg [7:0] write_data_next;
    integer byteN_reg, byteN_next;  //Contador de Bytes transmitidos
    reg [2:0] state_next,state_reg; //Estados
    reg [7:0] datos[0:429];     //Array para transmitir
    reg transmitir_next,transmitir_reg;     //Para habilitar transmision
    localparam [2:0]
        idle_tx  = 3'b000,
        start_tx = 3'b001,
        transmiting  = 3'b010,
        waiting = 3'b011,
        waiting_for_data = 3'b100,
        finish = 3'b101;
        
    //Para recepcion
    parameter [31:0] HLT = 32'b11111100000000000000000000000000; 
    parameter [7:0] uno = 49;
    parameter [7:0] dos = 50;
    parameter [7:0] tres = 51;
    reg [31:0] instruction_reg,instruction_next;
    reg [7:0] recibido;
    reg [31:0] bit_counter_reg,bit_counter_next;    //Contador de bits de recepcion
    reg led1_next,led2_next,led3_next,led4_next,led5_next;
    reg step_next;
    reg [2:0] state_next_rx,state_reg_rx;
    localparam [2:0]
        decode  = 3'b001,
        receiving_instructions = 3'b010,
        continuos_execution = 3'b011,
        clock_execution = 3'b100,
        checking_hlt = 3'b101,
        create_instructions = 3'b110,
        stop_execution = 3'b111;
    reg first_step_reg, first_step_next;
    reg clock_adicional_reg, clock_adicional_next;
            
    always@(posedge clk, posedge reset)
        begin
            if (reset)
                begin
                    //Para recepcion de datos
                    state_reg_rx <= decode;
                    transmitir_reg <= 0;
                    instruction_reg <= 0;
                    bit_counter_reg <= 0;
                    led1_reg <= 0;
                    led2_reg <= 0;
                    led3_reg <= 0;
                    led4_reg <= 0;
                    led5_reg <= 0;
                    step_reg <= 0;
                    clock_adicional_reg <= 0;
                    //Para envio de datos
                    byteN_reg <= 0;
                    state_reg <= idle_tx;
                    send_data_reg <= 1'b0;
                    write_data_reg <= 0;
                    IM_instruction <= 0;
                    first_step_reg <= 1;
                end
            else
                begin
                    state_reg_rx <= state_next_rx;
                    transmitir_reg <= transmitir_next;
                    instruction_reg <= instruction_next;
                    bit_counter_reg <= bit_counter_next;
                    led1_reg <= led1_next;
                    led2_reg <= led2_next;
                    led3_reg <= led3_next;
                    led4_reg <= led4_next;
                    led5_reg <= led5_next;
                    step_reg <= step_next;
                    clock_adicional_reg <= clock_adicional_next;
                    //Para  envio de datos
                    state_reg <= state_next;
                    byteN_reg <= byteN_next;
                    send_data_reg <= send_data_next;
                    write_data_reg <= write_data_next;
                    IM_instruction <= instruction_next;
                    first_step_reg <= first_step_next;
                end
        end
    
    //Recepcion de datos
    always@(*)
    begin
        led1_next = led1_reg;
        led2_next = led2_reg;
        led4_next = led4_reg;
        led5_next = led5_reg;
        step_next = step_reg;
        instruction_next = instruction_reg;
        state_next_rx = state_reg_rx;
        instruction_ready = 0;
        bit_counter_next = bit_counter_reg;
        transmitir_next = 0;
        first_step_next = first_step_reg;
        clock_adicional_next = clock_adicional_reg;
        
        case(state_reg_rx)
            decode:begin
                led1_next = 1;  //Para test
                if(rx_done_tick)
                begin
                    if(recv_data_reg == dos)    //Para test
                        led4_next = ~led4_next;
                    case(recv_data_reg)
                        uno: state_next_rx = receiving_instructions;                        
                        dos: state_next_rx = clock_execution;
                        tres: state_next_rx = continuos_execution;
                        default: state_next_rx = decode;
                    endcase
                end
            end
             
            receiving_instructions: begin
                led1_next = 0;
                if(rx_done_tick) begin
                    recibido = recv_data_reg;
                    state_next_rx = create_instructions;
                end
                else
                    state_next_rx = receiving_instructions;
            end
            create_instructions: begin
                led1_next = 0;                    
                if(bit_counter_next < 31) begin
                    instruction_next[31-bit_counter_next] = recibido[0];
                    bit_counter_next = bit_counter_reg + 1;
                    state_next_rx = receiving_instructions;
                end
                else begin
                    instruction_next[31-bit_counter_next] = recibido[0];
                    state_next_rx = checking_hlt;
                    bit_counter_next = 0;
                end
            end
            checking_hlt: begin
                led1_next = 0;
                instruction_ready = 1;  // Carga en IM
                if(instruction_next == HLT) begin 
                    led5_next = 1;
                    state_next_rx = decode;                       
                end
                else
                    state_next_rx = receiving_instructions;
            end 
          
            clock_execution: begin
                led1_next = 0;
                if(~first_step_next) begin
                    step_next = 1;
                end
                first_step_next = 0;
                state_next_rx = stop_execution;   
            end         
            stop_execution: begin
                led1_next = 0;
                step_next = 0;
                transmitir_next = 1;
                state_next_rx = decode;
            end                      
            
            continuos_execution: begin
                led1_next = 0;
                step_next = 1;
                if(enable_pc==0) begin
                    if(clock_adicional_next < 1) begin
                        step_next = 1;
                        clock_adicional_next = clock_adicional_reg + 1;
                        state_next_rx = continuos_execution;
                        end
                    else begin
                        step_next = 0;
                        transmitir_next = 1;
                        state_next_rx = decode;
                        end
                    end
                else
                    state_next_rx = continuos_execution;
                    
            end
          endcase
            
   
    end
            
    //Envio de datos
    always@(*)
    begin
        led2_next = led2_reg;
        send_data_next = 1'b0;
        byteN_next = byteN_reg;
        write_data_next = write_data_reg;
        state_next = state_reg;
        case (state_reg)
            idle_tx:
                begin
                    state_next = state_reg;
                    if (transmitir_reg==1)
                        begin
                            led2_next = 1;
                            state_next = waiting_for_data;
                        end
                end
            waiting_for_data:
                begin
                state_next = start_tx;
                end
            start_tx: 
                begin
                //Cargo datos
                
                //reg0
                datos[0] = reg_0[31:24];
                datos[1] = reg_0[23:16];
                datos[2] = reg_0[15:8];
                datos[3] = reg_0[7:0];
                //reg1
                datos[4] = reg_1[31:24];
                datos[5] = reg_1[23:16];
                datos[6] = reg_1[15:8];
                datos[7] = reg_1[7:0];
                //reg2
                datos[8] = reg_2[31:24];
                datos[9] = reg_2[23:16];
                datos[10] = reg_2[15:8];
                datos[11] = reg_2[7:0];
                //reg3
                datos[12] = reg_3[31:24];
                datos[13] = reg_3[23:16];
                datos[14] = reg_3[15:8];
                datos[15] = reg_3[7:0];
                //reg4
                datos[16] = reg_4[31:24];
                datos[17] = reg_4[23:16];
                datos[18] = reg_4[15:8];
                datos[19] = reg_4[7:0];
                //reg5
                datos[20] = reg_5[31:24];
                datos[21] = reg_5[23:16];
                datos[22] = reg_5[15:8];
                datos[23] = reg_5[7:0];
                //reg6
                datos[24] = reg_6[31:24];
                datos[25] = reg_6[23:16];
                datos[26] = reg_6[15:8];
                datos[27] = reg_6[7:0];
                //reg7
                datos[28] = reg_7[31:24];
                datos[29] = reg_7[23:16];
                datos[30] = reg_7[15:8];
                datos[31] = reg_7[7:0];
                //reg8
                datos[32] = reg_8[31:24];
                datos[33] = reg_8[23:16];
                datos[34] = reg_8[15:8];
                datos[35] = reg_8[7:0];
                //reg9
                datos[36] = reg_9[31:24];
                datos[37] = reg_9[23:16];
                datos[38] = reg_9[15:8];
                datos[39] = reg_9[7:0];
                //reg10
                datos[40] = reg_10[31:24];
                datos[41] = reg_10[23:16];
                datos[42] = reg_10[15:8];
                datos[43] = reg_10[7:0];
                //reg11
                datos[44] = reg_11[31:24];
                datos[45] = reg_11[23:16];
                datos[46] = reg_11[15:8];
                datos[47] = reg_11[7:0];
                //reg12
                datos[48] = reg_12[31:24];
                datos[49] = reg_12[23:16];
                datos[50] = reg_12[15:8];
                datos[51] = reg_12[7:0];
                //reg13
                datos[52] = reg_13[31:24];
                datos[53] = reg_13[23:16];
                datos[54] = reg_13[15:8];
                datos[55] = reg_13[7:0];
                //reg14
                datos[56] = reg_14[31:24];
                datos[57] = reg_14[23:16];
                datos[58] = reg_14[15:8];
                datos[59] = reg_14[7:0];
                //reg15
                datos[60] = reg_15[31:24];
                datos[61] = reg_15[23:16];
                datos[62] = reg_15[15:8];
                datos[63] = reg_15[7:0];
                //reg16
                datos[64] = reg_16[31:24];
                datos[65] = reg_16[23:16];
                datos[66] = reg_16[15:8];
                datos[67] = reg_16[7:0];
                //reg17
                datos[68] = reg_17[31:24];
                datos[69] = reg_17[23:16];
                datos[70] = reg_17[15:8];
                datos[71] = reg_17[7:0];
                //reg18
                datos[72] = reg_18[31:24];
                datos[73] = reg_18[23:16];
                datos[74] = reg_18[15:8];
                datos[75] = reg_18[7:0];
                //reg19
                datos[76] = reg_19[31:24];
                datos[77] = reg_19[23:16];
                datos[78] = reg_19[15:8];
                datos[79] = reg_19[7:0];
                //reg20
                datos[80] = reg_20[31:24];
                datos[81] = reg_20[23:16];
                datos[82] = reg_20[15:8];
                datos[83] = reg_20[7:0];
                //reg21
                datos[84] = reg_21[31:24];
                datos[85] = reg_21[23:16];
                datos[86] = reg_21[15:8];
                datos[87] = reg_21[7:0];
                //reg22
                datos[88] = reg_22[31:24];
                datos[89] = reg_22[23:16];
                datos[90] = reg_22[15:8];
                datos[91] = reg_22[7:0];
                //reg23
                datos[92] = reg_23[31:24];
                datos[93] = reg_23[23:16];
                datos[94] = reg_23[15:8];
                datos[95] = reg_23[7:0];
                //reg24
                datos[96] = reg_24[31:24];
                datos[97] = reg_24[23:16];
                datos[98] = reg_24[15:8];
                datos[99] = reg_24[7:0];
                //reg25
                datos[100] = reg_25[31:24];
                datos[101] = reg_25[23:16];
                datos[102] = reg_25[15:8];
                datos[103] = reg_25[7:0];
                //reg26
                datos[104] = reg_26[31:24];
                datos[105] = reg_26[23:16];
                datos[106] = reg_26[15:8];
                datos[107] = reg_26[7:0];
                //reg27
                datos[108] = reg_27[31:24];
                datos[109] = reg_27[23:16];
                datos[110] = reg_27[15:8];
                datos[111] = reg_27[7:0];
                //reg28
                datos[112] = reg_28[31:24];
                datos[113] = reg_28[23:16];
                datos[114] = reg_28[15:8];
                datos[115] = reg_28[7:0];
                //reg29
                datos[116] = reg_29[31:24];
                datos[117] = reg_29[23:16];
                datos[118] = reg_29[15:8];
                datos[119] = reg_29[7:0];
                //reg30
                datos[120] = reg_30[31:24];
                datos[121] = reg_30[23:16];
                datos[122] = reg_30[15:8];
                datos[123] = reg_30[7:0];
                //reg31
                datos[124] = reg_31[31:24];
                datos[125] = reg_31[23:16];
                datos[126] = reg_31[15:8];
                datos[127] = reg_31[7:0];
                
                //outs de IF
                ////PC
                datos[128] = out_if_add[31:24];
                datos[129] = out_if_add[23:16];
                datos[130] = out_if_add[15:8];
                datos[131] = out_if_add[7:0];
                ////Instruction_out
                datos[132] = out_instruction[31:24];
                datos[133] = out_instruction[23:16];
                datos[134] = out_instruction[15:8];
                datos[135] = out_instruction[7:0];
                
                //outs de IF/ID
                ////PC
                datos[136] = out_ifid_add[31:24];
                datos[137] = out_ifid_add[23:16];
                datos[138] = out_ifid_add[15:8];
                datos[139] = out_ifid_add[7:0];
                ////Instruction_out
                datos[140] = out_ifid_instruction[31:24];
                datos[141] = out_ifid_instruction[23:16];
                datos[142] = out_ifid_instruction[15:8];
                datos[143] = out_ifid_instruction[7:0];
                
                //outs de ID 
                ////PC_Branch -> nuevo PC en caso de Branch
                datos[144] = out_pc_branch[31:24];
                datos[145] = out_pc_branch[23:16];
                datos[146] = out_pc_branch[15:8];
                datos[147] = out_pc_branch[7:0];
                ////write address
                datos[148] = {3'b000, out_memwb_write_register};
                ////alu result
                datos[149] = {2'b00,out_opcode};
                datos[150] = {3'b000, out_id_register_Rs};
                datos[151] = {3'b000, out_id_register_Rt};
                datos[152] = {3'b000, out_id_register_Rd};
                ////reg data 1
                datos[153] = out_read_data_1[31:24];
                datos[154] = out_read_data_1[23:16];
                datos[155] = out_read_data_1[15:8];
                datos[156] = out_read_data_1[7:0];
                ////reg data 2
                datos[157] = out_read_data_2[31:24];
                datos[158] = out_read_data_2[23:16];
                datos[159] = out_read_data_2[15:8];
                datos[160] = out_read_data_2[7:0];
                ////sign ext
                datos[161] = out_id_sign[31:24];
                datos[162] = out_id_sign[23:16];
                datos[163] = out_id_sign[15:8];
                datos[164] = out_id_sign[7:0];
                
                //Outs de IDEX
                datos[165] = out_idex_read_data_1[31:24];
                datos[166] = out_idex_read_data_1[23:16];
                datos[167] = out_idex_read_data_1[15:8];
                datos[168] = out_idex_read_data_1[7:0];

                ////pc jump
                datos[169] = out_idex_read_data_2[31:24];
                datos[170] = out_idex_read_data_2[23:16];
                datos[171] = out_idex_read_data_2[15:8];
                datos[172] = out_idex_read_data_2[7:0];
                ////pc branch
                
                datos[173] = out_idex_sign[31:24];
                datos[174] = out_idex_sign[23:16];
                datos[175] = out_idex_sign[15:8];
                datos[176] = out_idex_sign[7:0];

                datos[177] = {2'b00,out_idex_opcode};
                datos[178] = {3'b000,out_idex_register_Rs};
                datos[179] = {3'b000,out_idex_register_Rt};
                datos[180] = {3'b000,out_idex_register_Rd};

                //Out de EX
                datos[181] = out_alu_result[31:24];
                datos[182] = out_alu_result[23:16];
                datos[183] = out_alu_result[15:8];
                datos[184] = out_alu_result[7:0];

                datos[185] = in_ex_read_data_2[31:24];
                datos[186] = in_ex_read_data_2[23:16];
                datos[187] = in_ex_read_data_2[15:8];
                datos[188] = in_ex_read_data_2[7:0];
                
                datos[189] = {3'b000,out_ex_write_register};
                
                //Out de EXMEM                
                datos[190] = out_exmem_alu_result[31:24];
                datos[191] = out_exmem_alu_result[23:16];
                datos[192] = out_exmem_alu_result[15:8];
                datos[193] = out_exmem_alu_result[7:0];

                datos[194] = in_exmem_read_data_2[31:24];
                datos[195] = in_exmem_read_data_2[23:16];
                datos[196] = in_exmem_read_data_2[15:8];
                datos[197] = in_exmem_read_data_2[7:0];
                
                datos[198] = {3'b000, out_exmem_write_register};
                
                //Outs de MEM
                datos[199] = out_mem_alu_result[31:24];
                datos[200] = out_mem_alu_result[23:16];
                datos[201] = out_mem_alu_result[15:8];
                datos[202] = out_mem_alu_result[7:0];

                datos[203] = out_read_data[31:24];
                datos[204] = out_read_data[23:16];
                datos[205] = out_read_data[15:8];
                datos[206] = out_read_data[7:0];

                datos[207] = {3'b000, out_mem_write_register};
                                
                //Outs de MEMWB
                datos[208] = out_memwb_read_data[31:24];
                datos[209] = out_memwb_read_data[23:16];
                datos[210] = out_memwb_read_data[15:8];
                datos[211] = out_memwb_read_data[7:0];

                datos[212] = out_memwb_alu_result[31:24];
                datos[213] = out_memwb_alu_result[23:16];
                datos[214] = out_memwb_alu_result[15:8];
                datos[215] = out_memwb_alu_result[7:0];
                
                //Outs de WB
                datos[216] = out_wb_mux[31:24];
                datos[217] = out_wb_mux[23:16];
                datos[218] = out_wb_mux[15:8];
                datos[219] = out_wb_mux[7:0];
                         
                //ClockCounter
                datos[220] = counter_clk;
                
                //ram0
                datos[221] = ram_0[31:24];
                datos[222] = ram_0[23:16];
                datos[223] = ram_0[15:8];
                datos[224] = ram_0[7:0];
                //ram1
                datos[225] = ram_1[31:24];
                datos[226] = ram_1[23:16];
                datos[227] = ram_1[15:8];
                datos[228] = ram_1[7:0];
                //ram2
                datos[229] = ram_2[31:24];
                datos[230] = ram_2[23:16];
                datos[231] = ram_2[15:8];
                datos[232] = ram_2[7:0];
                //ram3
                datos[233] = ram_3[31:24];
                datos[234] = ram_3[23:16];
                datos[235] = ram_3[15:8];
                datos[236] = ram_3[7:0];
                //ram4
                datos[237] = ram_4[31:24];
                datos[238] = ram_4[23:16];
                datos[239] = ram_4[15:8];
                datos[240] = ram_4[7:0];
                //ram5
                datos[241] = ram_5[31:24];
                datos[242] = ram_5[23:16];
                datos[243] = ram_5[15:8];
                datos[244] = ram_5[7:0];
                //ram6
                datos[245] = ram_6[31:24];
                datos[246] = ram_6[23:16];
                datos[247] = ram_6[15:8];
                datos[248] = ram_6[7:0];
                //ram7
                datos[249] = ram_7[31:24];
                datos[250] = ram_7[23:16];
                datos[251] = ram_7[15:8];
                datos[252] = ram_7[7:0];
                //ram8
                datos[253] = ram_8[31:24];
                datos[254] = ram_8[23:16];
                datos[255] = ram_8[15:8];
                datos[256] = ram_8[7:0];
                //ram9
                datos[257] = ram_9[31:24];
                datos[258] = ram_9[23:16];
                datos[259] = ram_9[15:8];
                datos[260] = ram_9[7:0];
                //ram10
                datos[261] = ram_10[31:24];
                datos[262] = ram_10[23:16];
                datos[263] = ram_10[15:8];
                datos[264] = ram_10[7:0];
                //ram11
                datos[265] = ram_11[31:24];
                datos[266] = ram_11[23:16];
                datos[267] = ram_11[15:8];
                datos[268] = ram_11[7:0];
                //ram12
                datos[269] = ram_12[31:24];
                datos[270] = ram_12[23:16];
                datos[271] = ram_12[15:8];
                datos[272] = ram_12[7:0];
                //ram13
                datos[273] = ram_13[31:24];
                datos[274] = ram_13[23:16];
                datos[275] = ram_13[15:8];
                datos[276] = ram_13[7:0];
                //ram14
                datos[277] = ram_14[31:24];
                datos[278] = ram_14[23:16];
                datos[279] = ram_14[15:8];
                datos[280] = ram_14[7:0];
                //ram15
                datos[281] = ram_15[31:24];
                datos[282] = ram_15[23:16];
                datos[283] = ram_15[15:8];
                datos[284] = ram_15[7:0];
                //ram16
                datos[285] = ram_16[31:24];
                datos[286] = ram_16[23:16];
                datos[287] = ram_16[15:8];
                datos[288] = ram_16[7:0];
                //ram17
                datos[289] = ram_17[31:24];
                datos[290] = ram_17[23:16];
                datos[291] = ram_17[15:8];
                datos[292] = ram_17[7:0];
                //ram18
                datos[293] = ram_18[31:24];
                datos[294] = ram_18[23:16];
                datos[295] = ram_18[15:8];
                datos[296] = ram_18[7:0];
                //ram19
                datos[297] = ram_19[31:24];
                datos[298] = ram_19[23:16];
                datos[299] = ram_19[15:8];
                datos[300] = ram_19[7:0];
                //ram20
                datos[301] = ram_20[31:24];
                datos[302] = ram_20[23:16];
                datos[303] = ram_20[15:8];
                datos[304] = ram_20[7:0];
                //ram21
                datos[305] = ram_21[31:24];
                datos[306] = ram_21[23:16];
                datos[307] = ram_21[15:8];
                datos[308] = ram_21[7:0];
                //ram22
                datos[309] = ram_22[31:24];
                datos[310] = ram_22[23:16];
                datos[311] = ram_22[15:8];
                datos[312] = ram_22[7:0];
                //ram23
                datos[313] = ram_23[31:24];
                datos[314] = ram_23[23:16];
                datos[315] = ram_23[15:8];
                datos[316] = ram_23[7:0];
                //ram24
                datos[317] = ram_24[31:24];
                datos[318] = ram_24[23:16];
                datos[319] = ram_24[15:8];
                datos[320] = ram_24[7:0];
                //ram25
                datos[321] = ram_25[31:24];
                datos[322] = ram_25[23:16];
                datos[323] = ram_25[15:8];
                datos[324] = ram_25[7:0];
                //ram26
                datos[325] = ram_26[31:24];
                datos[326] = ram_26[23:16];
                datos[327] = ram_26[15:8];
                datos[328] = ram_26[7:0];
                //ram27
                datos[329] = ram_27[31:24];
                datos[330] = ram_27[23:16];
                datos[331] = ram_27[15:8];
                datos[332] = ram_27[7:0];
                //ram28
                datos[333] = ram_28[31:24];
                datos[334] = ram_28[23:16];
                datos[335] = ram_28[15:8];
                datos[336] = ram_28[7:0];
                //ram29
                datos[337] = ram_29[31:24];
                datos[338] = ram_29[23:16];
                datos[339] = ram_29[15:8];
                datos[340] = ram_29[7:0];
                //ram30
                datos[341] = ram_30[31:24];
                datos[342] = ram_30[23:16];
                datos[343] = ram_30[15:8];
                datos[344] = ram_30[7:0];
                //ram31
                datos[345] = ram_31[31:24];
                datos[346] = ram_31[23:16];
                datos[347] = ram_31[15:8];
                datos[348] = ram_31[7:0];
                
                //Instruccion0
                datos[349] = out_instructions_all[511:504];
                datos[350] = out_instructions_all[503:496];
                datos[351] = out_instructions_all[495:488];
                datos[352] = out_instructions_all[487:480];
                //Instruccion1
                datos[353] = out_instructions_all[479:472];
                datos[354] = out_instructions_all[471:464];
                datos[355] = out_instructions_all[463:456];
                datos[356] = out_instructions_all[455:448];
                //Instruccion2
                datos[357] = out_instructions_all[447:440];
                datos[358] = out_instructions_all[439:432];
                datos[359] = out_instructions_all[431:424];
                datos[360] = out_instructions_all[423:416];
                //Instruccion3
                datos[361] = out_instructions_all[415:408];
                datos[362] = out_instructions_all[407:400];
                datos[363] = out_instructions_all[399:392];
                datos[364] = out_instructions_all[391:384];               
                //Instruccion4
                datos[365] = out_instructions_all[383:376];
                datos[366] = out_instructions_all[375:368];
                datos[367] = out_instructions_all[367:360];
                datos[368] = out_instructions_all[359:352];
                //Instruccion5
                datos[369] = out_instructions_all[351:344];
                datos[370] = out_instructions_all[343:336];
                datos[371] = out_instructions_all[335:328];
                datos[372] = out_instructions_all[327:320];
                //Instruccion6
                datos[373] = out_instructions_all[319:312];
                datos[374] = out_instructions_all[311:304];
                datos[375] = out_instructions_all[303:296];
                datos[376] = out_instructions_all[295:288];
                //Instruccion7
                datos[377] = out_instructions_all[287:280];
                datos[378] = out_instructions_all[279:272];
                datos[379] = out_instructions_all[271:264];
                datos[380] = out_instructions_all[263:256]; 
                //Instruccion8
                datos[381] = out_instructions_all[255:248];
                datos[382] = out_instructions_all[247:240];
                datos[383] = out_instructions_all[239:232];
                datos[384] = out_instructions_all[231:224];
                //Instruccion9
                datos[385] = out_instructions_all[223:216];
                datos[386] = out_instructions_all[215:208];
                datos[387] = out_instructions_all[207:200];
                datos[388] = out_instructions_all[199:192];
                //Instruccion10
                datos[389] = out_instructions_all[191:184];
                datos[390] = out_instructions_all[183:176];
                datos[391] = out_instructions_all[175:168];
                datos[392] = out_instructions_all[167:160];
                //Instruccion11
                datos[393] = out_instructions_all[159:152];
                datos[394] = out_instructions_all[151:144];
                datos[395] = out_instructions_all[143:136];
                datos[396] = out_instructions_all[135:128];               
                //Instruccion12
                datos[397] = out_instructions_all[127:120];
                datos[398] = out_instructions_all[119:112];
                datos[399] = out_instructions_all[111:104];
                datos[400] = out_instructions_all[103:96];
                //Instruccion13
                datos[401] = out_instructions_all[95:88];
                datos[402] = out_instructions_all[87:80];
                datos[403] = out_instructions_all[79:72];
                datos[404] = out_instructions_all[71:64];
                //Instruccion14
                datos[405] = out_instructions_all[63:56];
                datos[406] = out_instructions_all[55:48];
                datos[407] = out_instructions_all[47:40];
                datos[408] = out_instructions_all[39:32];
                //Instruccion15
                datos[409] = out_instructions_all[31:24];
                datos[410] = out_instructions_all[23:16];
                datos[411] = out_instructions_all[15:8];
                datos[412] = out_instructions_all[7:0];
                //PC
                datos[413] = pc[31:24];
                datos[414] = pc[23:16];
                datos[415] = pc[15:8];
                datos[416] = pc[7:0];
                //Taken
                datos[417] = {7'b0,taken};
                
                //Entrada A ALU y Branch
                datos[418] = out_mux3_A[31:24];
                datos[419] = out_mux3_A[23:16];
                datos[420] = out_mux3_A[15:8];
                datos[421] = out_mux3_A[7:0];
                //Entrada B Branch
                datos[422] = out_mux3_B[31:24];
                datos[423] = out_mux3_B[23:16];
                datos[424] = out_mux3_B[15:8];
                datos[425] = out_mux3_B[7:0];
                //Entrada B ALU
                datos[426] = out_ex_mux[31:24];
                datos[427] = out_ex_mux[23:16];
                datos[428] = out_ex_mux[15:8];
                datos[429] = out_ex_mux[7:0];
                //Comienzo a transmitir
                byteN_next = 0;
                state_next = transmiting;
                end
            transmiting:
                begin
                    write_data_next = datos[byteN_reg];
                    send_data_next = 1'b1;
                    byteN_next = byteN_reg + 1;
                    if (byteN_reg == 429) //ant de datos a transmitir
                        begin
                            led2_next = 0;
                            state_next = idle_tx;
                        end
                    else
                       state_next = waiting;
                end
            waiting:
                begin
                    if (tx_done_tick)
                        state_next = transmiting;
                    else
                        state_next = waiting;
                end
        endcase
    end
    
endmodule
