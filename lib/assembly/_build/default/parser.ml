
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | SUBC
    | SUB
    | STOP
    | SETRAM
    | REG of (
# 6 "parser.mly"
       (string)
# 19 "parser.ml"
  )
    | NEWLINE
    | MOVR
    | MOVC
    | JUMP
    | GETRAM
    | EOF
    | CONST of (
# 7 "parser.mly"
       (string)
# 30 "parser.ml"
  )
    | ADDC
    | ADD
  
end

include MenhirBasics

# 1 "parser.mly"
  
    open Ast

# 43 "parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState00 : ('s, _menhir_box_file) _menhir_state
    (** State 00.
        Stack shape : .
        Start symbol: file. *)

  | MenhirState01 : (('s, _menhir_box_file) _menhir_cell1_SUBC, _menhir_box_file) _menhir_state
    (** State 01.
        Stack shape : SUBC.
        Start symbol: file. *)

  | MenhirState03 : ((('s, _menhir_box_file) _menhir_cell1_SUBC, _menhir_box_file) _menhir_cell1_reg, _menhir_box_file) _menhir_state
    (** State 03.
        Stack shape : SUBC reg.
        Start symbol: file. *)

  | MenhirState06 : (('s, _menhir_box_file) _menhir_cell1_SUB, _menhir_box_file) _menhir_state
    (** State 06.
        Stack shape : SUB.
        Start symbol: file. *)

  | MenhirState07 : ((('s, _menhir_box_file) _menhir_cell1_SUB, _menhir_box_file) _menhir_cell1_reg, _menhir_box_file) _menhir_state
    (** State 07.
        Stack shape : SUB reg.
        Start symbol: file. *)

  | MenhirState10 : (('s, _menhir_box_file) _menhir_cell1_SETRAM, _menhir_box_file) _menhir_state
    (** State 10.
        Stack shape : SETRAM.
        Start symbol: file. *)

  | MenhirState11 : ((('s, _menhir_box_file) _menhir_cell1_SETRAM, _menhir_box_file) _menhir_cell1_reg, _menhir_box_file) _menhir_state
    (** State 11.
        Stack shape : SETRAM reg.
        Start symbol: file. *)

  | MenhirState12 : (((('s, _menhir_box_file) _menhir_cell1_SETRAM, _menhir_box_file) _menhir_cell1_reg, _menhir_box_file) _menhir_cell1_reg, _menhir_box_file) _menhir_state
    (** State 12.
        Stack shape : SETRAM reg reg.
        Start symbol: file. *)

  | MenhirState14 : (('s, _menhir_box_file) _menhir_cell1_MOVR, _menhir_box_file) _menhir_state
    (** State 14.
        Stack shape : MOVR.
        Start symbol: file. *)

  | MenhirState15 : ((('s, _menhir_box_file) _menhir_cell1_MOVR, _menhir_box_file) _menhir_cell1_reg, _menhir_box_file) _menhir_state
    (** State 15.
        Stack shape : MOVR reg.
        Start symbol: file. *)

  | MenhirState17 : (('s, _menhir_box_file) _menhir_cell1_MOVC, _menhir_box_file) _menhir_state
    (** State 17.
        Stack shape : MOVC.
        Start symbol: file. *)

  | MenhirState18 : ((('s, _menhir_box_file) _menhir_cell1_MOVC, _menhir_box_file) _menhir_cell1_reg, _menhir_box_file) _menhir_state
    (** State 18.
        Stack shape : MOVC reg.
        Start symbol: file. *)

  | MenhirState20 : (('s, _menhir_box_file) _menhir_cell1_JUMP, _menhir_box_file) _menhir_state
    (** State 20.
        Stack shape : JUMP.
        Start symbol: file. *)

  | MenhirState21 : ((('s, _menhir_box_file) _menhir_cell1_JUMP, _menhir_box_file) _menhir_cell1_reg, _menhir_box_file) _menhir_state
    (** State 21.
        Stack shape : JUMP reg.
        Start symbol: file. *)

  | MenhirState22 : (((('s, _menhir_box_file) _menhir_cell1_JUMP, _menhir_box_file) _menhir_cell1_reg, _menhir_box_file) _menhir_cell1_reg, _menhir_box_file) _menhir_state
    (** State 22.
        Stack shape : JUMP reg reg.
        Start symbol: file. *)

  | MenhirState24 : (('s, _menhir_box_file) _menhir_cell1_GETRAM, _menhir_box_file) _menhir_state
    (** State 24.
        Stack shape : GETRAM.
        Start symbol: file. *)

  | MenhirState25 : ((('s, _menhir_box_file) _menhir_cell1_GETRAM, _menhir_box_file) _menhir_cell1_reg, _menhir_box_file) _menhir_state
    (** State 25.
        Stack shape : GETRAM reg.
        Start symbol: file. *)

  | MenhirState26 : (((('s, _menhir_box_file) _menhir_cell1_GETRAM, _menhir_box_file) _menhir_cell1_reg, _menhir_box_file) _menhir_cell1_reg, _menhir_box_file) _menhir_state
    (** State 26.
        Stack shape : GETRAM reg reg.
        Start symbol: file. *)

  | MenhirState28 : (('s, _menhir_box_file) _menhir_cell1_ADDC, _menhir_box_file) _menhir_state
    (** State 28.
        Stack shape : ADDC.
        Start symbol: file. *)

  | MenhirState29 : ((('s, _menhir_box_file) _menhir_cell1_ADDC, _menhir_box_file) _menhir_cell1_reg, _menhir_box_file) _menhir_state
    (** State 29.
        Stack shape : ADDC reg.
        Start symbol: file. *)

  | MenhirState31 : (('s, _menhir_box_file) _menhir_cell1_ADD, _menhir_box_file) _menhir_state
    (** State 31.
        Stack shape : ADD.
        Start symbol: file. *)

  | MenhirState32 : ((('s, _menhir_box_file) _menhir_cell1_ADD, _menhir_box_file) _menhir_cell1_reg, _menhir_box_file) _menhir_state
    (** State 32.
        Stack shape : ADD reg.
        Start symbol: file. *)

  | MenhirState38 : (('s, _menhir_box_file) _menhir_cell1_instruction, _menhir_box_file) _menhir_state
    (** State 38.
        Stack shape : instruction.
        Start symbol: file. *)


and ('s, 'r) _menhir_cell1_instruction = 
  | MenhirCell1_instruction of 's * ('s, 'r) _menhir_state * (Ast.instruction)

and ('s, 'r) _menhir_cell1_reg = 
  | MenhirCell1_reg of 's * ('s, 'r) _menhir_state * (Ast.reg)

and ('s, 'r) _menhir_cell1_ADD = 
  | MenhirCell1_ADD of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_ADDC = 
  | MenhirCell1_ADDC of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_GETRAM = 
  | MenhirCell1_GETRAM of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_JUMP = 
  | MenhirCell1_JUMP of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_MOVC = 
  | MenhirCell1_MOVC of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_MOVR = 
  | MenhirCell1_MOVR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_SETRAM = 
  | MenhirCell1_SETRAM of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_SUB = 
  | MenhirCell1_SUB of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_SUBC = 
  | MenhirCell1_SUBC of 's * ('s, 'r) _menhir_state

and _menhir_box_file = 
  | MenhirBox_file of (Ast.file) [@@unboxed]

let _menhir_action_01 =
  fun c ->
    (
# 58 "parser.mly"
        ( Const (c) )
# 203 "parser.ml"
     : (Ast.const))

let _menhir_action_02 =
  fun xs ->
    let list_instructions = 
# 229 "<standard.mly>"
    ( xs )
# 211 "parser.ml"
     in
    (
# 18 "parser.mly"
        ( File (list_instructions) )
# 216 "parser.ml"
     : (Ast.file))

let _menhir_action_03 =
  fun () ->
    (
# 22 "parser.mly"
        ( Stop )
# 224 "parser.ml"
     : (Ast.instruction))

let _menhir_action_04 =
  fun r1 r2 ->
    (
# 25 "parser.mly"
        ( Add (r1, r2) )
# 232 "parser.ml"
     : (Ast.instruction))

let _menhir_action_05 =
  fun c r1 ->
    (
# 28 "parser.mly"
        ( Addc (r1, c) )
# 240 "parser.ml"
     : (Ast.instruction))

let _menhir_action_06 =
  fun r1 r2 ->
    (
# 31 "parser.mly"
        ( Sub (r1, r2) )
# 248 "parser.ml"
     : (Ast.instruction))

let _menhir_action_07 =
  fun c r1 ->
    (
# 34 "parser.mly"
        ( Subc (r1, c) )
# 256 "parser.ml"
     : (Ast.instruction))

let _menhir_action_08 =
  fun r1 r2 ->
    (
# 37 "parser.mly"
        ( Movr (r1, r2) )
# 264 "parser.ml"
     : (Ast.instruction))

let _menhir_action_09 =
  fun c r ->
    (
# 40 "parser.mly"
        ( Movc (r, c) )
# 272 "parser.ml"
     : (Ast.instruction))

let _menhir_action_10 =
  fun c r1 r2 ->
    (
# 43 "parser.mly"
        ( Jump (r1, r2, c) )
# 280 "parser.ml"
     : (Ast.instruction))

let _menhir_action_11 =
  fun c r1 r2 ->
    (
# 46 "parser.mly"
        ( Getram (r1, r2, c) )
# 288 "parser.ml"
     : (Ast.instruction))

let _menhir_action_12 =
  fun c r1 r2 ->
    (
# 49 "parser.mly"
        ( Setram (r1, r2, c) )
# 296 "parser.ml"
     : (Ast.instruction))

let _menhir_action_13 =
  fun () ->
    (
# 139 "<standard.mly>"
    ( [] )
# 304 "parser.ml"
     : (Ast.instruction list))

let _menhir_action_14 =
  fun x ->
    (
# 141 "<standard.mly>"
    ( x )
# 312 "parser.ml"
     : (Ast.instruction list))

let _menhir_action_15 =
  fun r ->
    (
# 54 "parser.mly"
        ( Reg (r) )
# 320 "parser.ml"
     : (Ast.reg))

let _menhir_action_16 =
  fun x ->
    (
# 238 "<standard.mly>"
    ( [ x ] )
# 328 "parser.ml"
     : (Ast.instruction list))

let _menhir_action_17 =
  fun x xs ->
    (
# 240 "<standard.mly>"
    ( x :: xs )
# 336 "parser.ml"
     : (Ast.instruction list))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | ADD ->
        "ADD"
    | ADDC ->
        "ADDC"
    | CONST _ ->
        "CONST"
    | EOF ->
        "EOF"
    | GETRAM ->
        "GETRAM"
    | JUMP ->
        "JUMP"
    | MOVC ->
        "MOVC"
    | MOVR ->
        "MOVR"
    | NEWLINE ->
        "NEWLINE"
    | REG _ ->
        "REG"
    | SETRAM ->
        "SETRAM"
    | STOP ->
        "STOP"
    | SUB ->
        "SUB"
    | SUBC ->
        "SUBC"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37"]
  
  let _menhir_goto_loption_separated_nonempty_list_NEWLINE_instruction__ : type  ttv_stack. ttv_stack -> _ -> _menhir_box_file =
    fun _menhir_stack _v ->
      let xs = _v in
      let _v = _menhir_action_02 xs in
      MenhirBox_file _v
  
  let _menhir_run_34 : type  ttv_stack. ttv_stack -> _ -> _menhir_box_file =
    fun _menhir_stack _v ->
      let x = _v in
      let _v = _menhir_action_14 x in
      _menhir_goto_loption_separated_nonempty_list_NEWLINE_instruction__ _menhir_stack _v
  
  let rec _menhir_goto_separated_nonempty_list_NEWLINE_instruction_ : type  ttv_stack. ttv_stack -> _ -> (ttv_stack, _menhir_box_file) _menhir_state -> _menhir_box_file =
    fun _menhir_stack _v _menhir_s ->
      match _menhir_s with
      | MenhirState38 ->
          _menhir_run_39 _menhir_stack _v
      | MenhirState00 ->
          _menhir_run_34 _menhir_stack _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_39 : type  ttv_stack. (ttv_stack, _menhir_box_file) _menhir_cell1_instruction -> _ -> _menhir_box_file =
    fun _menhir_stack _v ->
      let MenhirCell1_instruction (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_17 x xs in
      _menhir_goto_separated_nonempty_list_NEWLINE_instruction_ _menhir_stack _v _menhir_s
  
  let rec _menhir_run_01 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_file) _menhir_state -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_SUBC (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState01 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | REG _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_02 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_file) _menhir_state -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let r = _v in
      let _v = _menhir_action_15 r in
      _menhir_goto_reg _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_reg : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState32 ->
          _menhir_run_33 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState31 ->
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState28 ->
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState25 ->
          _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState24 ->
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState21 ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState20 ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState17 ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState15 ->
          _menhir_run_16 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState14 ->
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState11 ->
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState10 ->
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState07 ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState06 ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState01 ->
          _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_33 : type  ttv_stack. ((ttv_stack, _menhir_box_file) _menhir_cell1_ADD, _menhir_box_file) _menhir_cell1_reg -> _ -> _ -> _ -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_reg (_menhir_stack, _, r1) = _menhir_stack in
      let MenhirCell1_ADD (_menhir_stack, _menhir_s) = _menhir_stack in
      let r2 = _v in
      let _v = _menhir_action_04 r1 r2 in
      _menhir_goto_instruction _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_instruction : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | NEWLINE ->
          let _menhir_stack = MenhirCell1_instruction (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState38 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | SUBC ->
              _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | SUB ->
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STOP ->
              _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | SETRAM ->
              _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MOVR ->
              _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MOVC ->
              _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | JUMP ->
              _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | GETRAM ->
              _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ADDC ->
              _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ADD ->
              _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | EOF ->
          let x = _v in
          let _v = _menhir_action_16 x in
          _menhir_goto_separated_nonempty_list_NEWLINE_instruction_ _menhir_stack _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_06 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_file) _menhir_state -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_SUB (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState06 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | REG _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_09 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_file) _menhir_state -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_03 () in
      _menhir_goto_instruction _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_10 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_file) _menhir_state -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_SETRAM (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState10 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | REG _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_14 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_file) _menhir_state -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_MOVR (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState14 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | REG _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_17 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_file) _menhir_state -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_MOVC (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState17 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | REG _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_20 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_file) _menhir_state -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_JUMP (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState20 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | REG _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_24 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_file) _menhir_state -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_GETRAM (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState24 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | REG _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_28 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_file) _menhir_state -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_ADDC (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState28 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | REG _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_31 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_file) _menhir_state -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_ADD (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState31 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | REG _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_32 : type  ttv_stack. ((ttv_stack, _menhir_box_file) _menhir_cell1_ADD as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_reg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | REG _v_0 ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState32
      | _ ->
          _eRR ()
  
  and _menhir_run_29 : type  ttv_stack. ((ttv_stack, _menhir_box_file) _menhir_cell1_ADDC as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_reg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | CONST _v_0 ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState29
      | _ ->
          _eRR ()
  
  and _menhir_run_04 : type  ttv_stack. ((ttv_stack, _menhir_box_file) _menhir_cell1_reg as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_file) _menhir_state -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let c = _v in
      let _v = _menhir_action_01 c in
      _menhir_goto_constant _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_constant : type  ttv_stack. ((ttv_stack, _menhir_box_file) _menhir_cell1_reg as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState29 ->
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState26 ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState22 ->
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState18 ->
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState12 ->
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState03 ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_30 : type  ttv_stack. ((ttv_stack, _menhir_box_file) _menhir_cell1_ADDC, _menhir_box_file) _menhir_cell1_reg -> _ -> _ -> _ -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_reg (_menhir_stack, _, r1) = _menhir_stack in
      let MenhirCell1_ADDC (_menhir_stack, _menhir_s) = _menhir_stack in
      let c = _v in
      let _v = _menhir_action_05 c r1 in
      _menhir_goto_instruction _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_27 : type  ttv_stack. (((ttv_stack, _menhir_box_file) _menhir_cell1_GETRAM, _menhir_box_file) _menhir_cell1_reg, _menhir_box_file) _menhir_cell1_reg -> _ -> _ -> _ -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_reg (_menhir_stack, _, r2) = _menhir_stack in
      let MenhirCell1_reg (_menhir_stack, _, r1) = _menhir_stack in
      let MenhirCell1_GETRAM (_menhir_stack, _menhir_s) = _menhir_stack in
      let c = _v in
      let _v = _menhir_action_11 c r1 r2 in
      _menhir_goto_instruction _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_23 : type  ttv_stack. (((ttv_stack, _menhir_box_file) _menhir_cell1_JUMP, _menhir_box_file) _menhir_cell1_reg, _menhir_box_file) _menhir_cell1_reg -> _ -> _ -> _ -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_reg (_menhir_stack, _, r2) = _menhir_stack in
      let MenhirCell1_reg (_menhir_stack, _, r1) = _menhir_stack in
      let MenhirCell1_JUMP (_menhir_stack, _menhir_s) = _menhir_stack in
      let c = _v in
      let _v = _menhir_action_10 c r1 r2 in
      _menhir_goto_instruction _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_19 : type  ttv_stack. ((ttv_stack, _menhir_box_file) _menhir_cell1_MOVC, _menhir_box_file) _menhir_cell1_reg -> _ -> _ -> _ -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_reg (_menhir_stack, _, r) = _menhir_stack in
      let MenhirCell1_MOVC (_menhir_stack, _menhir_s) = _menhir_stack in
      let c = _v in
      let _v = _menhir_action_09 c r in
      _menhir_goto_instruction _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_13 : type  ttv_stack. (((ttv_stack, _menhir_box_file) _menhir_cell1_SETRAM, _menhir_box_file) _menhir_cell1_reg, _menhir_box_file) _menhir_cell1_reg -> _ -> _ -> _ -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_reg (_menhir_stack, _, r2) = _menhir_stack in
      let MenhirCell1_reg (_menhir_stack, _, r1) = _menhir_stack in
      let MenhirCell1_SETRAM (_menhir_stack, _menhir_s) = _menhir_stack in
      let c = _v in
      let _v = _menhir_action_12 c r1 r2 in
      _menhir_goto_instruction _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_05 : type  ttv_stack. ((ttv_stack, _menhir_box_file) _menhir_cell1_SUBC, _menhir_box_file) _menhir_cell1_reg -> _ -> _ -> _ -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_reg (_menhir_stack, _, r1) = _menhir_stack in
      let MenhirCell1_SUBC (_menhir_stack, _menhir_s) = _menhir_stack in
      let c = _v in
      let _v = _menhir_action_07 c r1 in
      _menhir_goto_instruction _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_26 : type  ttv_stack. (((ttv_stack, _menhir_box_file) _menhir_cell1_GETRAM, _menhir_box_file) _menhir_cell1_reg as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_reg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | CONST _v_0 ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState26
      | _ ->
          _eRR ()
  
  and _menhir_run_25 : type  ttv_stack. ((ttv_stack, _menhir_box_file) _menhir_cell1_GETRAM as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_reg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | REG _v_0 ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState25
      | _ ->
          _eRR ()
  
  and _menhir_run_22 : type  ttv_stack. (((ttv_stack, _menhir_box_file) _menhir_cell1_JUMP, _menhir_box_file) _menhir_cell1_reg as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_reg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | CONST _v_0 ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState22
      | _ ->
          _eRR ()
  
  and _menhir_run_21 : type  ttv_stack. ((ttv_stack, _menhir_box_file) _menhir_cell1_JUMP as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_reg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | REG _v_0 ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState21
      | _ ->
          _eRR ()
  
  and _menhir_run_18 : type  ttv_stack. ((ttv_stack, _menhir_box_file) _menhir_cell1_MOVC as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_reg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | CONST _v_0 ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState18
      | _ ->
          _eRR ()
  
  and _menhir_run_16 : type  ttv_stack. ((ttv_stack, _menhir_box_file) _menhir_cell1_MOVR, _menhir_box_file) _menhir_cell1_reg -> _ -> _ -> _ -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_reg (_menhir_stack, _, r1) = _menhir_stack in
      let MenhirCell1_MOVR (_menhir_stack, _menhir_s) = _menhir_stack in
      let r2 = _v in
      let _v = _menhir_action_08 r1 r2 in
      _menhir_goto_instruction _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_15 : type  ttv_stack. ((ttv_stack, _menhir_box_file) _menhir_cell1_MOVR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_reg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | REG _v_0 ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState15
      | _ ->
          _eRR ()
  
  and _menhir_run_12 : type  ttv_stack. (((ttv_stack, _menhir_box_file) _menhir_cell1_SETRAM, _menhir_box_file) _menhir_cell1_reg as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_reg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | CONST _v_0 ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState12
      | _ ->
          _eRR ()
  
  and _menhir_run_11 : type  ttv_stack. ((ttv_stack, _menhir_box_file) _menhir_cell1_SETRAM as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_reg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | REG _v_0 ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState11
      | _ ->
          _eRR ()
  
  and _menhir_run_08 : type  ttv_stack. ((ttv_stack, _menhir_box_file) _menhir_cell1_SUB, _menhir_box_file) _menhir_cell1_reg -> _ -> _ -> _ -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_reg (_menhir_stack, _, r1) = _menhir_stack in
      let MenhirCell1_SUB (_menhir_stack, _menhir_s) = _menhir_stack in
      let r2 = _v in
      let _v = _menhir_action_06 r1 r2 in
      _menhir_goto_instruction _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_07 : type  ttv_stack. ((ttv_stack, _menhir_box_file) _menhir_cell1_SUB as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_reg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | REG _v_0 ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState07
      | _ ->
          _eRR ()
  
  and _menhir_run_03 : type  ttv_stack. ((ttv_stack, _menhir_box_file) _menhir_cell1_SUBC as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_reg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | CONST _v_0 ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState03
      | _ ->
          _eRR ()
  
  let _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState00 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | SUBC ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SUB ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STOP ->
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SETRAM ->
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MOVR ->
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MOVC ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | JUMP ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | GETRAM ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ADDC ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ADD ->
          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | EOF ->
          let _v = _menhir_action_13 () in
          _menhir_goto_loption_separated_nonempty_list_NEWLINE_instruction__ _menhir_stack _v
      | _ ->
          _eRR ()
  
end

let file =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_file v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
