%{
    open Ast
%}

%token ADD ADDC SUB SUBC MOVR MOVC JUMP GETRAM SETRAM LABEL COMPC GOREG CALL CALLC RETURN
%token <string> REG LABELNAME
%token <string> CONST
%token NEWLINE
%token EOF

%start file
%type <Ast.file> file

%%

file:
    | NEWLINE*; list_instructions = separated_list (NEWLINE+,instruction);  EOF
        { File (list_instructions) }

instruction:
        
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

    | JUMP r1 = reg r2 = reg l = labelname
        { Jump (r1, r2, l) }

    | COMPC r1 = reg r2 = reg l = labelname
        { Compc (r1, r2, l) }

    | CALL l = labelname
        { Call(l) }
    
    | CALLC r1 = reg r2 = reg l =labelname
        { Callc (r1, r2, l) }

    | RETURN
        { Return }
    
    | GETRAM r1 = reg r2 = reg c = constant
        { Getram (r1, r2, c) }
    
    | SETRAM r1 = reg r2 = reg c = constant
        { Setram (r1, r2, c) }

    | LABEL s = labelname
        { Label (s) }

    | GOREG r1 = reg
        { Goreg(r1) }
    

reg:
    | r = REG
        { Reg (r) }

constant:
    | c = CONST
        { Const (c) }


labelname:
    | s = LABELNAME
        { Labelname (s) }
