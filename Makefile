all :
	make -C assembly/ 
	make -C tp1/



clean :
	dune clean 

.PHONY: all clean