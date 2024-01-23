all:
	dune build main.exe && dune exec ./main.exe

all2:
	dune build simulator2.exe  && dune exec ./simulator2.exe 

graphics:
	dune build graphics_helper.exe && dune exec ./graphics_helper.exe

digit:
	python3 digit_maker.py && make graphics

clean:
	dune clean

