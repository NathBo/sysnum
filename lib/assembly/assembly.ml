open Parser
open Ast
open Lexer

exception Wrong_constant_size

let size_reg = 4
let size_const = 16

let input = "code_assembly.txt"
let output = "code_cpu.txt"

let convert_assembly = 
  let channel = open_in input in
  let lb = Lexing.from_channel channel in
  let File(calls) = Parser.file Lexer.next_token lb in
  close_in channel;
  let channel = open_out output in
  List.iter
    (
      fun call -> match call with
        | Stop -> Printf.fprintf channel "00000000000000000000000000000000\n"
        | Add (Reg (r1), Reg(r2)) -> Printf.fprintf  channel "0010%s%s00000000000000000000\n" r1 r2
        | Sub (Reg (r1), Reg (r2)) -> Printf.fprintf channel "0110%s%s00000000000000000000\n" r1 r2
        | Movr (Reg (r1), Reg(r2)) -> Printf.fprintf channel "1010%s%s00000000000000000000\n" r1 r2
        | Movc (Reg (r1), Const (c)) -> 
          if (String.length c) <> size_const then raise (Wrong_constant_size)
          else  Printf.fprintf channel "0011%s%s00000000\n" r1 c
        | Jump (Reg (r1), Reg (r2), Const (c)) -> 
          if (String.length c) <> size_const then raise (Wrong_constant_size)
          else Printf.fprintf channel "0001%s%s%s0000\n" r1 r2 c
        | Getram (Reg (r1), Reg (r2), Const (c)) -> 
          if (String.length c) <> size_const then raise (Wrong_constant_size)
          else Printf.fprintf channel "0101%s%s%s0000\n" r1 r2 c
        | Setram (Reg (r1), Reg (r2), Const (c)) ->
          if (String.length c) <> size_const then raise (Wrong_constant_size)
          else Printf.fprintf channel "1001%s%s%s0000\n" r1 r2 c
        | Rom (Reg (r1), Reg (r2), Const (c)) ->
          if (String.length c) <> size_const then raise (Wrong_constant_size)
          else Printf.fprintf channel "1101%s%s%s0000\n" r1 r2 c
    )
    calls;
