all: assembly

assembly.exe:
	dune build assembly.exe

assembly: assembly.exe

clean:
	rm assembly
	dune clean

.PHONY: all clean assembly.exe assembly syntax