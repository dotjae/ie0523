module flipflop_D #(parameter N = 1)
(
    input clk,     // Entrada de reloj
    input reset,   // Entrada de reset asincrónico
    input [N-1:0] d,       // Entrada de datos
    output reg [N-1:0] q   // Salida del flip-flop
);

// Proceso de flip-flop tipo D
always @(posedge clk)
begin
    if (reset)
        q <= 1'b0; // Si se activa el reset, la salida se pone en 0
    else
        q <= d;    // Si no hay reset, la salida sigue el valor de la entrada d en cada flanco de subida del reloj
end

endmodule
