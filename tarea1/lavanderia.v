module Lavanderia (
    input clk,
    input rst,
    input intro_moneda,
    input finalizar_pago,
    output reg SECADO,
    output reg LAVADO,
    output reg LAVADO_PESADO,
    output reg insuficiente
);

reg [3:0] count, verificacion_pago;
reg [3:0] pulse_count; 
reg [1:0] modo;
reg internal_rst;

always @(posedge clk) begin
    // Reset or Internal Reset:
    if (rst || internal_rst) begin
        
        count <= 4'b0;
        verificacion_pago <= 4'b0;
        pulse_count <= 4'b0;
        modo <= 2'b0;
        internal_rst = 0;
        SECADO <= 0;
        LAVADO <= 0;
        LAVADO_PESADO <= 0;
        insuficiente <= 0;

    end
    else begin

        // Contar monedas.
        if (intro_moneda) begin 
            count += 1;
        end
        // Finalizar pago.
        else if (finalizar_pago) begin 

            verificacion_pago[3:0] <= count[3:0];
            pulse_count = 3'b0;
            count <= 4'b0;

            // Pago insuficiente/incorrecto:
            if (count != 4'b11 && count != 4'b100 && count != 4'b1001 && count != 0) begin
                insuficiente = 1;
            end

        end
    end

    // Logica para senal de Modo en el flanco positivo:
    if (SECADO) begin
        SECADO = !SECADO;
        pulse_count += 1;
    end
    else if (LAVADO) begin
        LAVADO = !LAVADO;
        pulse_count += 1;
    end
    else if (LAVADO_PESADO) begin
        LAVADO_PESADO = !LAVADO_PESADO;
        pulse_count += 1;
    end

    // Terminar senal de Modo y mandar reset interno.
    if (pulse_count >= 4'b1000) begin
        pulse_count <= 0;
        modo <= 0;
        internal_rst <= 1;
    end
end


always @(negedge clk) begin

    // Pago insuficiente/incompleto:
    if (insuficiente) begin
        internal_rst <= 1;
    end
    // Modo Secado:
    if (verificacion_pago == 4'b0011) begin
        SECADO <= 1;
        modo <= 2'b01; // Almacenar modo SECADO.
        verificacion_pago = 0;  
    end
    // Modo Lavado:
    else if (verificacion_pago == 4) begin
        LAVADO <= 1;
        modo <= 2'b10; // Almacenar modo LAVADO. 
        verificacion_pago = 0;
    end
    // Modo Lavado Pesado:
    else if (verificacion_pago == 9) begin
        LAVADO_PESADO <= 1;
        modo <= 2'b11; // Almacenar modo LAVADO_PESADO.
        verificacion_pago = 0;
    end

    // Logica para senal de Modo en el flanco negativo:
    if (pulse_count > 3'b0) begin
        if (modo == 2'b01) begin
            SECADO = !SECADO;
            pulse_count += 1;
        end
        else if (modo == 2'b10)begin
            LAVADO = !LAVADO;
            pulse_count += 1;
        end
        else if (modo == 2'b11) begin
            LAVADO_PESADO = !LAVADO_PESADO;
            pulse_count += 1;
        end
    end
end

endmodule
