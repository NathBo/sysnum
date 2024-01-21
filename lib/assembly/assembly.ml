open Ast
open Parser
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
  let labels = Hashtbl.create 32 in
  let cpt = ref 0 in
  List.iter
  (
    fun call -> match  call with
    | Label(Labelname(s)) -> Hashtbl.add labels s !cpt
    | _ -> incr cpt
  )
  calls;
  List.iter
    (
      fun call -> match call with
        | Stop -> Printf.fprintf channel "00000000000000000000000000000000\n"
        | Add (Reg (r1), Reg(r2)) -> Printf.fprintf  channel "01101000%s%s0000000000000000\n" r1 r2
        | Addc(Reg(r1),Const(c)) -> Printf.fprintf channel "00101000%s0000%s\n" r1 c
        | Sub (Reg (r1), Reg (r2)) -> Printf.fprintf channel "11101000%s%s0000000000000000\n" r1 r2
        | Subc(Reg(r1),Const(c)) -> Printf.fprintf channel "10101000%s0000%s\n" r1 c
        | Movr (Reg (r1), Reg(r2)) -> Printf.fprintf channel "01001000%s%s0000000000000000\n" r1 r2
        | Movc (Reg (r1), Const (c)) -> 
          if (String.length c) <> size_const then raise (Wrong_constant_size)
          else  Printf.fprintf channel "00001000%s0000%s\n" r1 c
        | Jump (Reg (r1), Reg (r2), Labelname(s)) -> 
          Printf.fprintf channel "11100100%s%s%s\n" r1 r2 (convert_to_base_2 (Hashtbl.find labels s))
        | Compc (Reg (r1), Reg (r2), Labelname(s)) -> 
            Printf.fprintf channel "11100110%s%s%s\n" r1 r2 (convert_to_base_2 (Hashtbl.find labels s))
        | Getram (Reg (r1), Reg (r2), Const (c)) -> 
          if (String.length c) <> size_const then raise (Wrong_constant_size)
          else Printf.fprintf channel "01111000%s%s%s\n" r1 r2 c
        | Setram (Reg (r1), Reg (r2), Const (c)) ->
          if (String.length c) <> size_const then raise (Wrong_constant_size)
          else Printf.fprintf channel "01110000%s%s%s0000\n" r1 r2 c
        | Label(_) -> ()
    )
    calls;
