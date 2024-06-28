`include "Generador.v"
`include "gen_tester.v"

module testbench;
    wire clk, rst, mdio_start, mdio_in;
    wire [31:0] t_data;
    wire MDC, mdio_oe, mdio_out, data_rdy;
    wire [15:0] rd_data;

    generador DUT(
        .clk(clk),
        .rst(rst),
        .mdio_start(mdio_start),
        .mdio_in(mdio_in),
        .t_data(t_data[31:0]),
        .MDC(MDC),
        .mdio_oe(mdio_oe),
        .mdio_out(mdio_out),
        .data_rdy(data_rdy),
        .rd_data(rd_data[15:0])
    );

    tester test(
        .clk(clk),
        .rst(rst),
        .mdio_start(mdio_start),
        .mdio_in(mdio_in),
        .t_data(t_data[31:0]),
        .MDC(MDC),
        .mdio_oe(mdio_oe),
        .mdio_out(mdio_out),
        .data_rdy(data_rdy),
        .rd_data(rd_data[15:0])
    );

    initial begin
        $dumpfile("gen.vcd");
        $dumpvars;
    end

endmodule