all:
	dune build
	ocamlbuild netlist_simulator.byte
	./netlist_simulator.byte ../netlists/alu.net

fast:
	dune build
	ocamlbuild netlist_simulator.byte
	./netlist_simulator.byte -m 1 ../netlists/alu.net

drunk:
	dune build
	ocamlbuild netlist_simulator.byte
	./netlist_simulator.byte -m 2 ../netlists/alu.net

fibonacci:
	dune build
	ocamlbuild netlist_simulator.byte
	./netlist_simulator.byte -m 4 ../netlists/alu.net

netlist_ast:
	ocamlopt -c netlist_ast.ml

netlist:
	ocamlopt -c netlist.ml

clean:
	rm netlist_simulator.byte
	rm -r _build/