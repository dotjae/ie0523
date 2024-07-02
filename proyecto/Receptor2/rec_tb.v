/******************************
* Codigo del testbench del receptor MDIO
*
*
*
*
*******************************/

`timescale 1ns/1ns

`include "Receptor.v"
`include "rec_tester.v"

module tb_Receptor;
    wire MDC;
    wire RESET;
    wire [31:0] MDIO_OUT;
    wire MDIO_OE;
    wire MDIO_DONE;
    wire MDIO_IN;
    wire [4:0] ADDR;
    wire [15:0] WR_DATA;
    wire [15:0] RD_DATA;
    wire WR_STB;

    // Instancia del modulo Receptor
    receptor_mdio receptor (
        .MDC(MDC),
        .RESET(RESET),
        .MDIO_OUT(MDIO_OUT[31:0]),
        .MDIO_OE(MDIO_OE),
        .MDIO_DONE(MDIO_DONE),
        .MDIO_IN(MDIO_IN),
        .ADDR(ADDR),
        .WR_DATA(WR_DATA),
        .RD_DATA(RD_DATA),
        .WR_STB(WR_STB)
    );

    // Instancia del modulo Tester
    Tester_Receptor prueba (
        .MDC(MDC),
        .RESET(RESET),
        .MDIO_OUT(MDIO_OUT[31:0]),
        .MDIO_OE(MDIO_OE),
        .MDIO_DONE(MDIO_DONE),
        .MDIO_IN(MDIO_IN),
        .ADDR(ADDR),
        .WR_DATA(WR_DATA),
        .RD_DATA(RD_DATA),
        .WR_STB(WR_STB)
    );

    initial begin
        
        $dumpfile("tb_receptor.vcd");
        $dumpvars;
    end


endmodule
