`timescale 1s/1s

module tester (
    output reg clk,
    output reg enb,
    output reg rst,
    output reg [1:0] semA,
    output reg [1:0] semB,
    input A_peatonal,
    input B_peatonal);



always #4 clk = !clk;


initial begin
    rst = 0;
    clk = 0;
    enb = 1;
    #8
    // Caso: A->Rojo, B->Verde:
    semA <= 2'b00;
    semB <= 2'b10;
    #32
    // Caso: A->Rojo, B->Amarillo:
    semA <= 2'b00;
    semB <= 2'b01;
    #8
    // Caso: A->Verde, B->Rojo:
    semA <= 2'b10;
    semB <= 2'b00;
    #16
    // Caso: A->Verde, B->Rojo:
    semA <= 2'b10;
    semB <= 2'b00;
    #16
    // Caso: A->Amarillo, B->Rojo:
    semA <= 2'b01;
    semB <= 2'b00;
    #8
    // Caso: A->Rojo, B->Verde:
    semA <= 2'b00;
    semB <= 2'b10;
    #16
    // Caso: A->Rojo, B->Verde:
    semA <= 2'b00;
    semB <= 2'b10;  
    #16
    // Reset.
    rst = 1;
    #32

    $finish;

end
    
endmodule