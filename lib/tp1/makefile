all:
	dune build
	ocamlbuild netlist_simulator.byte
	./netlist_simulator.byte -n 40 test/alu.net

clean:
	rm netlist_simulator.byte
	dune clean