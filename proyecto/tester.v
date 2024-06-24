`timescale 1ns/1ns

module Tester (
    output reg clk, 
    output reg rst,
    output reg MDIO_START,
    output reg MDIO_IN,
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
    rst = 1'b0;
end

initial begin
    #10 

    T_DATA = 32'h5A5AFFFF;
    MDIO_START  
    rst = 0;
    #10


    #230

    $finish;
end
    
    
endmodule