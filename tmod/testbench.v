`include "lavanderia.v"
`include "tester.v"

module testbench;

    wire clk, rst, intro_moneda, finalizar_pago;
    wire SECADO, LAVADO, LAVADO_PESADO, insuficiente;

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

    // Instancia del módulo tester
    tester test(
        .clk(clk),
        .rst(rst),
        .intro_moneda(intro_moneda),
        .finalizar_pago(finalizar_pago)
    );

    // Para generar las ondas y visualizar en gtkwave
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars;
    end

    // Mostrar los valores
    always @(posedge clk) begin
        $display("Tiempo: %t,\n SECADO: %b,\n LAVADO: %b,\n LAVADO_PESADO: %b\n, insuficiente: %b\n\n", 
                 $time, SECADO, LAVADO, LAVADO_PESADO, insuficiente);
    end

endmodule
