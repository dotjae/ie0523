module tester(
    output reg clk,     // Entrada de reloj
    output reg reset,   // Entrada de reset
    output reg enable,
    input rco,
    input [3:0] count  // Salida del contador de 4 bits
);

always begin
    #2 clk = !clk;
end

initial begin
    reset = 1;
    clk = 0;
    enable = 0;

    #6;

    reset = 0;
    enable = 1;

    #80;

    $finish;
end





endmodule