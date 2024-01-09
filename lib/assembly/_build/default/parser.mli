
(* The type of tokens. *)

type token = 
  | SUBC
  | SUB
  | STOP
  | SETRAM
  | REG of (string)
  | NEWLINE
  | MOVR
  | MOVC
  | JUMP
  | GETRAM
  | EOF
  | CONST of (string)
  | ADDC
  | ADD

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val file: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.file)
