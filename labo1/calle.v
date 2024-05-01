module Calle (
    input clk,
    input enb,
    input rst,
    input [1:0] semA, // Semaforo A.
    input [1:0] semB, // Semaforo B.
    output reg A_peatonal, // Peatonal A.
    output reg B_peatonal // Peatonal B.
);


always @(posedge clk) begin

    if (rst) begin
        // Ambos peatonales apagados.
        A_peatonal <= 0;
        B_peatonal <= 0;
        
    end

    if (enb && !rst) begin
        // Semaforo A = Rojo:
        if (semA == 2'b00) begin
            A_peatonal <= 1; // Peatonal A = Verde.
            B_peatonal <= 0; // Paetonal B = Rojo.
        end
        // Semaforo A = Amarillo o Verde:            
        else if (semA == 2'b01 || semA == 2'b10) begin
            A_peatonal <= 0; // Peatonal A = Rojo.
            B_peatonal <= 1; // Peatonal B = Verde.
        end
        // Semaforo B = Rojo:
        else if (semB == 2'b00) begin
            B_peatonal <= 1; // Peatonal B = Verde.
            A_peatonal <= 0; // Peatonal A = Rojo.
        end
        // Semaforo B = Amarillo o Verde:
        else if (semB == 2'b01 || semB == 2'b10) begin
            B_peatonal <= 0; // Peatonal B = Rojo.
            A_peatonal <= 1; // Peatonal A = Verde.
        end

    end
end




endmodule