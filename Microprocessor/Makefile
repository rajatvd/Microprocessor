alu.out: ALUtester.v ALUmodule.v
	iverilog $? -o $@

cu.out: CUtester.v ALUmodule.v CUmodule.v RAMblock.v
	iverilog $? -o $@

ram.out: RAMtester.v RAMblock.v
	iverilog $? -o $@

all: alu.out ram.out cu.out


alu: ALUtester.v ALUmodule.v
	iverilog $? -o $@.out
	vvp $@.out
	gtkwave $@.vcd

cu: CUtester.v ALUmodule.v CUmodule.v RAMblock.v
	iverilog $? -o $@.out
	vvp $@.out
	gtkwave $@.vcd

ram: RAMtester.v RAMblock.v
	iverilog $? -o $@.out
	vvp $@.out
	gtkwave $@.vcd

.PHONY: clean, all

clean:
	rm -f *.out
	rm -f *.vcd
