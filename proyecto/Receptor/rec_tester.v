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
    output reg MDIO_OUT,
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
    MDIO_OUT = 0;
    MDIO_OE = 0;
    #10 

    // Coloca los datos de lectura iniciales
    RD_DATA = 16'h8FF1;
    RESET = 1'b1;
    #20
    MDIO_OE = 1;
    MDIO_OUT = 1;
    #10

    // Prueba de Transaccion de Lectura
    #10
    // Enviar datos por MDIO_OUT y verificar MDIO_IN
    MDIO_OUT = 1'b1;    // Envia 1 bit 
    #10
    MDIO_OUT = 1'b0;    // Envia 2 bit 
    #10
    MDIO_OUT = 1'b1;    // Envia 3 bit 
    #10

    #670
    MDIO_OE = 0;        // Deshabilita la salida MDIO

    // Prueba de Transaccion de Escritura
    #20
    MDIO_OE = 1;        // Habilita MDIO para escritura
    MDIO_OUT = 1;       // Envia datos para escritura
    #10
    MDIO_OUT = 0;
    #10
    MDIO_OUT = 1;
    #10

    #670

    #200
    $finish;
end
    
endmodule
