`timescale 1ns/1ns

module Tester (
    output reg clk, 
    output reg rst,
    output reg MDIO_START,
    output reg [15:0] MDIO_IN,
    output reg [31:0] T_DATA,
    input [15:0] RD_DATA,
    input DATA_RDY,
    input MDC, 
    input MDIO_OE,
    input MDIO_OUT
);

always begin 
    #5 clk = !clk; 
end

initial begin
    clk = 0;
    rst = 1'b1;
end

initial begin
    #10 
    MDIO_START = 0;
    T_DATA = 32'h8A5AFF01;
    MDIO_IN = 16'h8FF1;
    rst = 1'b0;
    #25
    MDIO_START = 1;
    #10
    MDIO_START = 0;

    #670
    MDIO_START = 0;
    #20
    T_DATA = 32'h9A5AFF01;
    #20
    MDIO_START = 1;
    #10
    MDIO_START = 0;

    #670
    MDIO_START = 0;
    rst = 1;

    #200


    $finish;
end
    
    
endmodule