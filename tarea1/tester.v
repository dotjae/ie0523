`timescale 1s/1s

module tester(

    output reg clk,
    output reg rst, 
    output reg intro_moneda,
    output reg finalizar_pago,
    input SECADO, LAVADO, LAVADO_PESADO,
    input insuficiente);

    // Instancia del modulo Lavanderia.
    Lavanderia lavanderia(
        .clk(clk),
        .rst(rst),
        .intro_moneda(intro_moneda),
        .finalizar_pago(finalizar_pago),
        .SECADO(SECADO),
        .LAVADO(LAVADO),
        .LAVADO_PESADO(LAVADO_PESADO),
        .insuficiente(insuficiente)
    );

    // Generacion de la señal de reloj.
    always #5 clk = !clk;

    // Pruebas:
    initial begin
        
        // Inicialización.
        clk = 0;
        rst = 1;
        intro_moneda = 0;
        finalizar_pago = 0;

        #10 rst = 0;  // Fin del reset

        // Test 1: SECADO (3 monedas)
        #10
        repeat (6) begin
            #5 intro_moneda = !intro_moneda;
        end
        finalizar_pago = 1;
        #10 finalizar_pago = 0;

        #100

        // Test 2: LAVADO (4 monedas)
        #10
        repeat (8) begin
            #5 intro_moneda = !intro_moneda;
        end
        finalizar_pago = 1;
        #10 finalizar_pago = 0;

        #100

        // Test 3: LAVADO_PESADO (9 monedas)
        #10
        repeat (18) begin
            #5 intro_moneda = !intro_moneda;
        end
         finalizar_pago = 1;
        #10 finalizar_pago = 0;

        #100

        // Test 4: Monedas insuficientes (5 monedas)
        #10
        repeat (10) begin
            #5 intro_moneda = !intro_moneda;
        end
        finalizar_pago = 1;
        #10 finalizar_pago = 0;

        #50 $finish;
    end
    
endmodule
