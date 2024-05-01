/* 
Material Circuitos Digitales 2

Archivo: testbench.v 

Descripcion: Testbench del contador.


    ----------                  -----------
    |           |               |         |
    |   TEST    | <---------->  |   DUT   |
    |           |               |         |
    ----------                  ----------

Autor: Ing. Ana Eugenia Sanchez Villalobos
*/

`include "contador.v"
`include "tester.v" //Tambien conocido como probador.


module testbench;
    wire clk, reset, enable, rco;
    wire [3:0] count;

    contador DUT(
        .clk(clk), 
        .enable(enable),
        .reset(reset), 
        .count(count[3:0]),
        .rco(rco)
    );

    // Instantiate the tester module
    tester test(
        .clk(clk), 
        .enable(enable),
        .reset(reset), 
        .count(count[3:0]),
        .rco(rco)
    );

    /* Para generar las ondas y
    y visualizar en gtkwave
    */
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars;
    end

    //Mostrar los valores
    always @(posedge clk) begin
        $display("Valor del contador: %b", count);
        $display("Valor del contador: %b", rco);
    end

endmodule
