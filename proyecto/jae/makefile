generador:
	iverilog -o tb.vvp testbench.v
	vvp tb.vvp
	gtkwave tb.vcd

receptor:
	iverilog -o tb.vvp rec_tb.v
	vvp tb.vvp
	gtkwave rec.vcd

clean:
	rm .vcd*
