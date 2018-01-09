# Author: Rajat Vadiraj Dwaraknath EE16B033
# Dated: 29 Oct 2017

cu: CPU.v ALUmodule.v CUmodule.v RAMblock.v
	iverilog $? -o $@.out
	vvp $@.out
	gtkwave $@.vcd


alu.out: ALUtester.v ALUmodule.v
	iverilog $? -o $@

cu.out: CPU.v ALUmodule.v CUmodule.v RAMblock.v
	iverilog $? -o $@

ram.out: RAMtester.v RAMblock.v
	iverilog $? -o $@

all: alu.out ram.out cu.out


alu: ALUtester.v ALUmodule.v
	iverilog $? -o $@.out
	vvp $@.out
	gtkwave $@.vcd


ram: RAMtester.v RAMblock.v
	iverilog $? -o $@.out
	vvp $@.out
	gtkwave $@.vcd

factorial: factorial.myasm
	python pythonAssembleV3.py factorial.myasm
	make

pi: findpi2.myasm
	python pythonAssembleV3.py findpi2.myasm
	make

.PHONY: clean, all

clean:
	rm -f *.out
	rm -f *.vcd
