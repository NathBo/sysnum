%{
    open Ast
%}

%token STOP ADD ADDC SUB SUBC MOVR MOVC JUMP GETRAM SETRAM
%token <string> REG
%token <string> CONST
%token NEWLINE
%token EOF

%start file
%type <Ast.file> file

%%

file:
    | list_instructions = separated_list (NEWLINE, instruction) EOF
        { File (list_instructions) }

instruction:
    | STOP
        { Stop }
        
    | ADD r1 = reg r2 = reg
        { Add (r1, r2) }
    
    | ADDC r1 = reg c = constant
        { Addc (r1, c) }

    | SUB r1 = reg r2 = reg
        { Sub (r1, r2) }

    | SUBC r1 = reg c = constant
        { Subc (r1, c) }

    | MOVR r1 = reg r2 = reg
        { Movr (r1, r2) }
    
    | MOVC r = reg c = constant
        { Movc (r, c) }

    | JUMP r1 = reg r2 = reg c = constant
        { Jump (r1, r2, c) }
    
    | GETRAM r1 = reg r2 = reg c = constant
        { Getram (r1, r2, c) }
    
    | SETRAM r1 = reg r2 = reg c = constant
        { Setram (r1, r2, c) }
    

reg:
    | r = REG
        { Reg (r) }

constant:
    | c = CONST
        { Const (c) }

