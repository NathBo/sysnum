all: assembly

assembly.exe:
	dune build assembly.exe

assembly: assembly.exe
	dune exec ./assembly.exe "code_assembly_with_labels.txt"
clean:
	rm assembly
	dune clean

.PHONY: all clean assembly.exe assembly syntax