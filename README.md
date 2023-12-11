# sysnum

Pour la clock if faut :
stop
add r1 r2 fait r1 <- r1 + r2
sub r1 r2 fait r1 <- r1 - r2
movc r1 c fait r1 <- c
movr r1 r2 fait r1 <- r2
jump r1 r2 c fait on va a ligne c si r1 = r2
getram r1 r2 c fait r1 <- RAM(r2+c)
setram r1 r2 c fait RAM(r2+c) <- r1
rom r1 r2 c fait r1 <- ROM(r2+c)
une instruction interrupt (qui est aussi l'intruction pour reprendre le compte)
reset
Nombre de trucs :

8 registres

On fait des calculs sur 16 bits
Instruction fait :
4 bits de code de l'instruction
2*3 bits de registre
6 bits de constance
