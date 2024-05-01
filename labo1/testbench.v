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

`include "calle.v"
`include "tester.v" //Tambien conocido como probador.


module testbench;
    wire clk, rst, enb;
    wire [1:0] semA, semB;
    wire A_peatonal, B_peatonal;

    Calle calle(
        .clk(clk), 
        .enb(enb),
        .rst(rst), 
        .semA(semA[1:0]),
        .semB(semB[1:0]),
        .A_peatonal(A_peatonal),
        .B_peatonal(B_peatonal)
    );

    // Instantiate the tester module
    tester test(
        .clk(clk), 
        .enb(enb),
        .rst(rst), 
        .semA(semA[1:0]),
        .semB(semB[1:0]),
        .A_peatonal(A_peatonal),
        .B_peatonal(B_peatonal)
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

        if (semA == 2'b00 & semB == 2'b10) begin
            $display("Semaforo A: %b = ROJO", semA);
            $display("Semaforo B: %b = VERDE\n", semB);
        end
        else if (semA == 2'b00 & semB == 2'b01) begin
            $display("Semaforo A: %b = ROJO", semA);
            $display("Semaforo B: %b = AMARILLO\n", semB);
        end
        else if (semA == 2'b10 & semB == 2'b00) begin
            $display("Semaforo A: %b = VERDE", semA);
            $display("Semaforo B: %b = ROJO\n", semB);
        end
        else if (semA == 2'b00 & semB == 2'b10) begin
            $display("Semaforo A: %b = AMARILLO", semA);
            $display("Semaforo B: %b = ROJO\n", semB);
        end

        

        
    end

endmodule
