all: assembly

fibonacci:
	dune exec ./assembly.exe "code_assembly_fibonacci.txt"

assembly.exe:
	dune build assembly.exe

assembly: 
	make assembly.exe
	dune exec ./assembly.exe "code_assembly_with_labels.txt"

fast : 
	make assembly.exe
	dune exec ./assembly.exe "code_assembly_with_labels_fast.txt"
clean:
	rm assembly
	dune clean

.PHONY: all clean assembly.exe assembly syntax