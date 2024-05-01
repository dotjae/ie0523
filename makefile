verilog:
	iverilog -o tb.vvp sumador_testbench.v 
	vvp tb.vvp
	gtkwave tb.vcd

clean:
	rm -rf tb.vcd tb.vvp