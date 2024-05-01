/* 
Material Circuitos Digitales 2

Archivo: sumador.v 

Descripcion: Este archivo contiene el tester de un sumador.
Aqui se realizan las pruebas, en este caso, nuestras salidas en el DUT van a ser nuestras entradas, y
nuestras entradas en el DUT seran nuestras salidas. 

Autor: Ing. Ana Eugenia Sanchez Villalobos
*/

`timescale 1ns/1ns // Escala de tiempo

module tester (
    output reg clk   ,
    output reg enb   ,
    output  reg rst       ,
    output  reg [3:0] a     ,
    output  reg [3:0] b     ,
    input [3:0] c
);

/* ALTERNATIVA DE DEFINIR LOS REGS */
//reg clk,enb,a,b;

// Definiendo el clk
always begin 
    #5 clk = !clk; 
end

/* ALTERNATIVA DE HACERLO*/
// always begin
//     clk = 1'b0; 
//     #1;
//     clk = 1'b1; //equivalente a clk = 1;
//     #1;
// end

initial begin
    clk = 0;
    rst = 1'b0;
end

initial begin
    $display("Esto es un mensaje en la terminal");

    // Defino el comportamiento de mis entradas (a y b), para ver que va a pasar con mi salida (c). 
    enb = 1'b1;
    a = 3'b0;
    b = 3'b1;
    #10;

    a = 3'b101;
    b = 3'b010;
    #10;

    enb = 1'b0;
    rst = 1'b1;
    #10;

    $finish;
end
    
endmodule