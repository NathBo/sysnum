all:
	dune build
	ocamlbuild netlist_simulator.byte
	./netlist_simulator.byte -n 400 ../netlists/alu.net

clean:
	rm netlist_simulator.byte
	rm -r _build/
	dune clean