all:
	dune build
	ocamlbuild netlist_simulator.byte
	./netlist_simulator.byte ../netlists/alu.net

netlist_ast:
	ocamlopt -c netlist_ast.ml

netlist:
	ocamlopt -c netlist.ml

clean:
	rm netlist_simulator.byte
	rm -r _build/