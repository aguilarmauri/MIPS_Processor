`timescale 1ns / 1ps

module RX
    (
    input wire clk, reset,
    input wire rx, s_tick,
    output reg rx_done_tick,
    output wire[7:0] dout
    );

    reg [1:0] state_reg, state_next;
    reg [3:0] s_reg, s_next;//contador para detectar el bit del medio de lo sobremuestrado
    reg [2:0] n_reg, n_next;//contador de datos guardados en el shift register
    reg [7:0] b_reg, b_next;//registo donde vamos guardando
    
    always @(posedge clk,posedge reset)//Memoria
    //con cada ciclo de reloj si el reset esta en 0 entonces va a actualizar los contadores y el siguiente estado que se halla modificado
    //en el bloque always de abajo
        if(reset)
            begin
                state_reg <= 2'b00;
                s_reg <= 0;
                n_reg <= 0;
                b_reg <= 0;
            end
        else
            begin
                state_reg <= state_next;
                s_reg <= s_next;
                n_reg <= n_next;
                b_reg <= b_next;
                //rx_done_tick = 1'b0;
                    
            end
            
    always @*//logica state_next
            begin
            state_next = state_reg;
            rx_done_tick = 1'b0;
            s_next = s_reg;
            n_next = n_reg;
            b_next = b_reg;
        case (state_reg)
            2'b00://espera el 0
                if(~rx)//cuando recivo el primer 0 comienzo	
                    begin
                        state_next = 2'b01;
                        s_next = 0;
                    end
            2'b01://cuenta para obtener el bit de start
                if(s_tick)
                    if(s_reg==7)
                        begin
                            state_next = 2'b10;
                            s_next = 0;
                            n_next = 0;
                        end
                    else
                        s_next = s_reg + 1;
            2'b10://empieza la toma de datos
                if(s_tick)
                    if(s_reg==15)
                        begin
                            s_next = 0;
                            b_next = {rx, b_reg[7:1]};
                            if(n_reg==7)//cuando tomo los 8 datos pasar al estado parar
                                state_next = 2'b11;
                            else
                                n_next = n_reg + 1;
                        end
                    else
                        s_next = s_reg + 1;
            2'b11:
                if(s_tick)
                    if(s_reg == 15)//cuenta hasta 16 para detectar el bit de stop
                        begin
                            state_next = 2'b00;
                            rx_done_tick = 1'b1;
                        end
                    else
                        s_next = s_reg + 1;
            default: state_next = 2'b00;
            endcase
        end
    assign dout = b_reg;
endmodule

