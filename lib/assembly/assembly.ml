open Ast
open Parser
open Lexer

exception Wrong_constant_size

exception LabelNotDefined of string


let file = ref "code_assembly_with_labels.txt"


let hashtblfind h s =
  if Hashtbl.mem h s
  then Hashtbl.find h s
  else raise (LabelNotDefined s)

let size_reg = 4
let size_const = 16

let input = !file
let output = "code_cpu.txt"




let convert_assembly filename = (
  let input = filename in
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
    | Call _ -> cpt := !cpt + 2
    | Callc _ -> cpt := !cpt + 2
    | _ -> incr cpt
  )
  calls;
  cpt := 0;
  List.iter
    (
      fun call -> match call with
        | Add (Reg (r1), Reg(r2)) -> Printf.fprintf  channel "01101000%s%s0000000000000000\n" r1 r2;incr cpt
        | Addc(Reg(r1),Const(c)) -> Printf.fprintf channel "00101000%s0000%s\n" r1 c;incr cpt
        | Sub (Reg (r1), Reg (r2)) -> Printf.fprintf channel "11101000%s%s0000000000000000\n" r1 r2;incr cpt
        | Subc(Reg(r1),Const(c)) -> Printf.fprintf channel "10101000%s0000%s\n" r1 c;incr cpt
        | Movr (Reg (r1), Reg(r2)) -> Printf.fprintf channel "01001000%s%s0000000000000000\n" r1 r2;incr cpt;incr cpt
        | Movc (Reg (r1), Const (c)) -> 
          if (String.length c) <> size_const then raise (Wrong_constant_size)
          else  Printf.fprintf channel "00001000%s0000%s\n" r1 c;incr cpt
        | Jump (Reg (r1), Reg (r2), Labelname(s)) -> 
          Printf.fprintf channel "11101100%s%s%s\n" r1 r2 (convert_to_base_2 (Hashtbl.find labels s));incr cpt
        | Compc (Reg (r1), Reg (r2), Labelname(s)) -> 
            Printf.fprintf channel "11101110%s%s%s\n" r1 r2 (convert_to_base_2 (Hashtbl.find labels s));incr cpt
        | Call(Labelname(s)) ->
          incr cpt;
          Printf.fprintf channel "0000100011110000%s\n" (convert_to_base_2 !cpt);
          Printf.fprintf channel "1110110000000000%s\n" (convert_to_base_2 (Hashtbl.find labels s));incr cpt
        | Callc(Reg (r1), Reg (r2), Labelname(s)) ->
          incr cpt;
          Printf.fprintf channel "0000100011110000%s\n" (convert_to_base_2 !cpt);
          Printf.fprintf channel "11101100%s%s%s\n" r1 r2 (convert_to_base_2 (Hashtbl.find labels s));incr cpt
        | Return -> Printf.fprintf channel "00000101111100000000000000000000\n";incr cpt
        | Getram (Reg (r1), Reg (r2), Const (c)) -> 
          if (String.length c) <> size_const then raise (Wrong_constant_size)
          else Printf.fprintf channel "01111000%s%s%s\n" r1 r2 c;incr cpt
        | Setram (Reg (r1), Reg (r2), Const (c)) ->
          if (String.length c) <> size_const then raise (Wrong_constant_size)
          else Printf.fprintf channel "01110000%s%s%s\n" r1 r2 c;incr cpt
        | Goreg(Reg(r1)) ->
          Printf.fprintf channel "00000101%s00000000000000000000\n" r1;incr cpt
        | Label(_) -> ()
        | Mod4(Reg(r1),Reg(r2)) ->
          Printf.fprintf channel "11000001%s%s0000000000000000\n" r1 r2;incr cpt
    )
    calls;
)

let charger () =
  Arg.parse
      [] convert_assembly "";;
     
charger();
