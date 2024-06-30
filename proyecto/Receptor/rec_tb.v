`include "Receptor.v"
`include "rec_tester.v"

module testbench;
    wire MDC, rst, mdio_oe, mdio_out;
    wire [15:0] rd_data;
    wire mdio_in, mdio_done, wr_stb;
    wire [4:0] addr;
    wire [15:0] wr_data;

    receptor DUT(
        .MDC(MDC),
        .rst(rst),
        .rd_data(rd_data[15:0]),
        .mdio_in(mdio_in),
        .mdio_done(mdio_done),
        .wr_stb(wr_stb),
        .addr(addr[4:0]),
        .wr_data(wr_data[15:0])
    );

    tester test(
        .MDC(MDC),
        .rst(rst),
        .rd_data(rd_data[15:0]),
        .mdio_in(mdio_in),
        .mdio_done(mdio_done),
        .wr_stb(wr_stb),
        .addr(addr[4:0]),
        .wr_data(wr_data[15:0])
    );

endmodule