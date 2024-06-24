`include "generador.v"
`include "tester.v"

module testbench;
    wire clk; 
    wire rst;
    wire MDIO_START;
    wire MDIO_IN;
    wire [31:0] T_DATA;
    wire [15:0] RD_DATA;
    wire DATA_RDY;
    wire MDC; 
    wire MDIO_OE;
    wire MDIO_OUT;


Generador generador (
    .clk(clk),
    .rst(rst),
    .MDIO_START(MDIO_START),
    .MDIO_IN(MDIO_IN),
    .T_DATA(T_DATA[31:0]),
    .RD_DATA(RD_DATA[15:0]),
    .DATA_RDY(DATA_RDY),
    .MDC(MDC),
    .MDIO_OE(MDIO_OE),
    .MDIO_OUT(MDIO_OUT)
);

Tester test (
    .clk(clk),
    .rst(rst),
    .MDIO_START(MDIO_START),
    .MDIO_IN(MDIO_IN),
    .T_DATA(T_DATA[31:0]),
    .RD_DATA(RD_DATA[15:0]),
    .DATA_RDY(DATA_RDY),
    .MDC(MDC),
    .MDIO_OE(MDIO_OE),
    .MDIO_OUT(MDIO_OUT)
);


initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end


endmodule