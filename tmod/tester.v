
`timescale 1ns/1ns

module tester(

    output reg clk,
    output reg rst, 
    output reg intro_moneda,
    output reg finalizar_pago,
    input SECADO, LAVADO, LAVADO_PESADO,
    input insuficiente);

    // Initialize Lavanderia module
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

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test scenarios
    initial begin
        // Reset
        rst = 1; #10;
        rst = 0; #10;

        // Test SECADO mode
        intro_moneda = 1; #10;
        intro_moneda = 0; #10;
        intro_moneda = 1; #10;
        intro_moneda = 0; #10;
        intro_moneda = 1; #10;
        finalizar_pago = 1; #10;
        finalizar_pago = 0; #10;

        // Reset
        rst = 1; #10;
        rst = 0; #10;

        // Test LAVADO mode
        // [Similar logic for LAVADO mode]

        // Reset
        // [Reset logic]

        // Test LAVADO_PESADO mode
        // [Similar logic for LAVADO_PESADO mode]

        // Reset
        // [Reset logic]

        // Test insufficient coins scenario
        // [Similar logic for insufficient coins scenario]
    end
endmodule
