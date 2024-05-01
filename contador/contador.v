`include "FF.v"

module contador(
    input clk,     // Entrada de reloj
    input reset,   // Entrada de reset
    input enable,
    output rco,
    output [3:0] count  // Salida del contador de 4 bits
);

reg [4:0] intern_count;

// Instanciación del flip-flop tipo D
flipflop_D #(.N(4)) D_FF4(.clk(clk), .reset(reset), .d(intern_count[3:0]), .q(count[3:0]));
flipflop_D DFF1(.clk(clk), .reset(reset), .d(intern_count[4]), .q(rco)); // Esta línea no cambió

// Proceso de conteo
always @(posedge clk or posedge reset)
begin
    if (reset) // Si el reset está activado
        intern_count <= 0;   // Reiniciar el contador a 0
    else if (enable) // Si el enable está activado
        intern_count <= intern_count + 1;   // Incrementar el contador
end

endmodule
