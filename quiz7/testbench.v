`include "modules.v"
`include "tester.v"

module testbench;
    
    wire CLK1, RST, D1, D2;
    wire f, g;

    modulo4 Mod4 (
        .CLK1(CLK1),
        .RST(RST),
        .D1(D1),
        .D2(D2),
        .f(f),
        .g(g)
    );

    tester test (
        .CLK1(CLK1),
        .RST(RST),
        .D1(D1),
        .D2(D2),
        .f(f),
        .g(g)
    );

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, testbench);
    end


endmodule
