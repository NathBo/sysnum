all:
	dune build
	make netlist_ast
	ocamlfind ocamlopt -O3 -g -o -linkpkg -package graphics graphics.cmxa netlist_ast.o netlist_simulator.ml
	./netlist_simulator.byte -n 400 ../netlists/alu.net

netlist_ast:
	ocamlopt -c netlist_ast.ml

netlist:
	ocamlopt -c netlist.ml

clean:
	rm netlist_simulator.byte
	rm -r _build/