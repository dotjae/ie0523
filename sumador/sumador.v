/* 
Material Circuitos Digitales 2

Archivo: sumador.v 

Descripcion: Este archivo contiene el DUT de un sumador.

Autor: Ing. Ana Eugenia Sanchez Villalobos
*/


/* ALTERNATIVA DE REALIZARLO */
// module sumador (
//     clk ,
//     enb ,    
//     a   ,
//     b   ,
//     c
// );

// input clk ;
// input enb ;
// input a   ;
// input b   ;
// output c  ;


module sumador (
    input clk   ,
    input enb   ,
    input rst   ,
    input [3:0] a     ,
    input [3:0] b     ,
    output [3:0] c
);

reg c;

always @(posedge clk ) begin
    if(enb) begin
        //Definimos el comportamiento que quiero en mi salida, con las entradas que tengo.
        c <= a + b;
    end //Begin y end no es necesario siempre y cuando sea solo una linea de codigo.
    else if (rst) begin
        c <= 0;
    end
end
    
endmodule