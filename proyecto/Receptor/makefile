generador:
	iverilog -o tb.vvp gen_tb.v
	vvp tb.vvp
	gtkwave gen.vcd

receptor:
	iverilog -o tb_receptor.vvp rec_tb.v
	vvp tb_receptor.vvp
	gtkwave tb_receptor.vcd
