/* 
Material Circuitos Digitales 2

Archivo: sumador_testbench.v 

Descripcion: Testbench del sumador.


    ----------                  -----------
    |           |               |         |
    |   TEST    | <---------->  |   DUT   |
    |           |               |         |
    ----------                  ----------

Autor: Ing. Ana Eugenia Sanchez Villalobos
*/

`include "sumador.v"
`include "sumador_tester.v" //Tambien conocido como probador.


module testbench;
    wire clk, enb, rst;
    wire [3:0] a;
    wire [3:0] b; 
    wire [3:0] c;

    sumador DUT(
        .clk(clk), 
        .enb(enb),
        .rst(rst), 
        .a(a[3:0]),
        .b(b[3:0]),
        .c(c[3:0])
    );

    // Instantiate the tester module
    tester test(
        .clk(clk), 
        .enb(enb),
        .rst(rst), 
        .a(a[3:0]),
        .b(b[3:0]),
        .c(c[3:0])
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
        $display("Valor de suma: %b", c);
    end

endmodule



