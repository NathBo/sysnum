all: assembly

assembly.exe:
	dune build assembly.exe

assembly: assembly.exe
	cp assembly.exe assembly

clean:
	rm assembly
	dune clean

.PHONY: all clean assembly.exe assembly syntax