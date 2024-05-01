`include "lavanderia.v"
`include "tester.v"

module testbench;

    wire clk, rst, intro_moneda, finalizar_pago;
    wire SECADO, LAVADO, LAVADO_PESADO, insuficiente;

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

    // Instancia del modulo tester.
    tester test(
        .clk(clk),
        .rst(rst),
        .intro_moneda(intro_moneda),
        .finalizar_pago(finalizar_pago),
        .SECADO(SECADO),
        .LAVADO(LAVADO),
        .LAVADO_PESADO(LAVADO_PESADO),
        .insuficiente(insuficiente)
        
    );

    // Generar las ondas y visualizar en gtkwave.
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars;
    end

    // Mostrar salidas en la terminal.
    always @(posedge clk) begin
       if (SECADO || LAVADO || LAVADO_PESADO || insuficiente) begin
            $display("SECADO: %b,\n LAVADO: %b,\n LAVADO_PESADO: %b\n, insuficiente: %b\n\n",SECADO, LAVADO, LAVADO_PESADO, insuficiente);
       end 
    end

endmodule
