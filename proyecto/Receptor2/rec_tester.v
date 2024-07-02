/******************************
* Codigo del tester del receptor MDIO
*
*
*
*
*******************************/

`timescale 1ns/1ns

module Tester_Receptor (
    output reg MDC, 
    output reg RESET,
    output reg [31:0] T_DATA,
    output reg MDIO_OE,
    output reg [15:0] RD_DATA,
    input MDIO_DONE,
    input MDIO_IN,
    input [4:0] ADDR,
    input [15:0] WR_DATA,
    input WR_STB //
);

// Generacion de reloj MDC
always begin 
    #5 MDC = !MDC; 
end

// // Inicializacion de señales de MDC (clock) y reset
// initial begin
//     MDC = 0;
//     RESET = 1;
// end

initial begin
    // Inicializacion de señales de MDC (clock) y reset
    MDC = 0;
    RESET = 0;
    T_DATA = 0;
    MDIO_OE = 0;
    #10 

    // Coloca los datos de lectura iniciales
    RD_DATA = 16'h8FF1;
    RESET = 1'b1;
    #20
    MDIO_OE = 1;
    T_DATA = 32'h8A5AFF01;
    
    #670
    MDIO_OE = 0;        // Deshabilita la salida MDIO

    // Prueba de Transaccion de Escritura
    #20
    MDIO_OE = 1;        // Habilita MDIO para escritura
    T_DATA = 32'h9A5AFF01;

    #670
    RESET = 0;
    #200
    $finish;
end
    
endmodule
