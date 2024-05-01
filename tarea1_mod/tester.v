`timescale 1ns/1ns

module tester(

    output reg clk,
    output reg rst, 
    output reg intro_moneda,
    output reg finalizar_pago,
    input SECADO, LAVADO, LAVADO_PESADO,
    input insuficiente);

    // Instancia del módulo Lavanderia
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

    // Generación de la señal de reloj
    always #5 clk = !clk;

    // Procedimiento de prueba
    initial begin
        //$monitor($time, " clk=%b rst=%b intro_moneda=%b finalizar_pago=%b SECADO=%b LAVADO=%b LAVADO_PESADO=%b insuficiente=%b",
        //         clk, rst, intro_moneda, finalizar_pago, SECADO, LAVADO, LAVADO_PESADO, insuficiente);

        // Inicialización
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

        #50

        // // Test 2: LAVADO (4 monedas)
        // #10
        // repeat (8) begin
        //     #5 intro_moneda = !intro_moneda;
        // end
        // #10 finalizar_pago = 1;
        // #10 finalizar_pago = 0;

        // #50

        // Test 3: LAVADO_PESADO (9 monedas)
        #10
        repeat (18) begin
            #5 intro_moneda = !intro_moneda;
        end
         finalizar_pago = 1;
        #10 finalizar_pago = 0;

        #50

        // Test 4: Monedas insuficientes (2 monedas)
        #10
        repeat (4) begin
            #5 intro_moneda = !intro_moneda;
        end
        finalizar_pago = 1;
        #10 finalizar_pago = 0;

        #50 $finish;
    end
    
endmodule
