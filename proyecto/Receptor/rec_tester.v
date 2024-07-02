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
    output reg [31:0] MDIO_OUT,
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

initial begin
    // Inicializacion de señales de MDC (clock) y reset
    MDC = 0;

    // Operacion de lectura:    
    MDIO_OUT = 32'h4FFFABCD;
    RD_DATA = 16'hDCBA;
    RESET = 0;
    
    #10
    RESET = 1;
    MDIO_OE = 1;

    #160
    MDIO_OE =0;
    #160

    // Operacion de escritura
    RESET = 1'b0;
    #10
    MDIO_OUT = 32'h5FFFABCD;
    #10 
    RESET = 1;

    MDIO_OE = 1;
    #180
    MDIO_OE = 0;
    
    #10
    RESET = 0;
    
    #100
    $finish;
end
    
endmodule
