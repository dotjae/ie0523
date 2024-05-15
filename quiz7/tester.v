`timescale 1ns/1ns

module tester (

    output reg CLK1, RST, D1, D2,
    input f, g

);

    modulo4 Mod4 (
        .CLK1(CLK1),
        .RST(RST),
        .D1(D1),
        .D2(D2),
        .f(f),
        .g(g)
    );

    always #5 CLK1 = !CLK1;

    initial begin
        CLK1 = 0;
        RST = 1;
        D1 = 0;
        D2 = 0;
        #5

        RST = 0;
        #10

        D1 = 0;
        D2 = 0;
        #20
        
        D1= 0;
        D2 = 1;
        #20
        
        D1= 1;
        D2 = 0;
        #20
        
        D1= 1;
        D2 = 1;
        #20
        
        RST = 1;
        #40 $finish;

    end 

endmodule