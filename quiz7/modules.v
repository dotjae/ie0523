module modulo1 (
    input CLK1, RST,
    input D1,
    output reg Q1, Q1_bar
);
    
    always @(posedge CLK1) begin
        if (RST) begin
            Q1 <= 0;
        end
        else begin
            Q1 <= D1;
            Q1_bar <= ~D1;
        end
    end

endmodule

module modulo2 (
    input CLK1, RST,
    input D2,
    output reg Q2, Q2_bar
);
    
    always @(posedge CLK1) begin
        if (RST) begin
            Q2 <= 0;
        end
        else begin
            Q2 <= D2;
            Q2_bar <= ~D2;
        end
    end

endmodule

module modulo3 (
    input a, b, c, d,
    output reg f, g
);

    always @(*) begin
        f <= a && c;
        g <= b || d;
    end
    
endmodule

module modulo4 (
    input D1, D2, CLK1, RST,
    output wire f, g
);

    wire a, b, c, d;
    
    // always @(posedge CLK1) begin

        modulo1 Mod1 (
            .CLK1(CLK1),
            .RST(RST),
            .D1(D1),
            .Q1(a),
            .Q1_bar(b)
        );


        modulo2 Mod2 (
            .CLK1(CLK1),
            .RST(RST),
            .D2(D2),
            .Q2(c),
            .Q2_bar(d)
        );

        modulo3 Mod3 (
            .a(a),
            .b(b),
            .c(c),
            .d(d),
            .f(f),
            .g(g)
        );

    // end

endmodule