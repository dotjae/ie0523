`timescale 1ns/1ns

module tester (
    output reg clk, rst, mdio_in, mdio_start,
    output reg [31:0] t_data,
    input MDC, mdio_oe, mdio_out, data_rdy,
    input [15:0] rd_data
);

always begin
    #100 clk = !clk;
end

initial begin
    clk = 0;
    rst = 0;

    #400;

    rst = 1;
    mdio_start = 0;
    mdio_in = 0;
    #2400;

    $finish;
end
endmodule