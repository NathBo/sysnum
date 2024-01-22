open Graphics_helper
open Unix
open Netlist_ast

let print_only = ref false
let number_steps = ref (-1)

exception Not_byte
type type_env = ty Env.t
type val_env = value Env.t

let simulator p number_steps = 
  Printf.printf "hello3%!";
  let script = "clock.txt" in

  let prev_env = ref Env.empty in
  let start_ram_screen = 14 in
  let ram = Array.init (16*(m_width*m_height + start_ram_screen)) (fun _ -> VBitArray(Array.make 16 false)) in 
  (*1: seconde passée
    6: temps initial
    3: inputs M, S, R: mode, start/stop, reset (start/reset seulement en mode timer) *)

  let get_lines file = 
    let lines = ref [] in
    let chan = open_in file in
    try
      while true; do
        lines := input_line chan :: !lines
      done; !lines
    with End_of_file ->
      close_in chan;
      List.rev !lines 
    in
  let lines = get_lines script in
  let rom = Array.make (2*List.length lines) (VBitArray(Array.make 16 false)) in
  let i = ref 0 in
  let bool_of_char = function |'0' -> false |'1' -> true |_ -> Format.eprintf "scirpt is not in binary"; exit 2 in
  List.iter (fun line -> 
      let VBitArray(arr1) = rom.(!i) and VBitArray(arr2) = rom.(!i+1) in
      for j = 0 to 15 do 
        arr1.(j) <- bool_of_char line.[j];
        arr2.(j) <- bool_of_char line.[j+16]
      done;
      i := !i + 2) 
    lines;
  (*let rom = Array.map (fun s -> Vbit(bool_of_string x)) (Array.of_seq (String.to_seq (input_line ic))) in*)

    
  screen_init ();

  let to_16b n = 
    let rec d2b y lst = match y with 0 -> lst
        | _ -> d2b (y/2) ((if y mod 2 = 0 then false else true) :: lst)
      in
      let final = d2b n [] 
    in
    VBitArray (Array.of_list (List.init (16-List.length final) (fun _ -> false) @ final))
  in
  let from_16b l = 
    let rec aux acc = function
      |[] -> acc
      |b :: t -> aux (2*acc + Bool.to_int b) t in
    aux 0 l in

  (*donner le temps initial*)
  let t = localtime (time()) in
  let sec = t.tm_sec and min = t.tm_min and hour = t.tm_hour and mday = t.tm_mday and mon = t.tm_mon and year = 1900 + t.tm_year in
  let time_desc = Array.of_list (List.map to_16b [sec; min; hour; mday; mon; year]) in
  Array.blit time_desc 0 ram 1 (Array.length time_desc);


  let t = ref (time()) in
  let k = ref 0 in 
  while !k <> number_steps do
    let to_write = ref [] in
    let to_value env = function
      |Avar(id) -> Env.find id env
      |Aconst(x) -> x in

    (* calcule la valeur de eq en évaluant les arguments dans env *)
    let eval env eq = match snd eq with
      | Earg(arg) -> to_value env arg
      | Enot(arg) -> (match to_value env arg with |VBit(a) -> VBit(not a))
      | Ereg(id) -> (try Env.find id !prev_env with |_ -> (match Env.find id p.p_vars with |TBit -> VBit(false) 
                                                            |TBitArray(n) -> VBitArray(Array.init n (fun _ -> false))))
      | Ebinop(binop, arg1, arg2) -> (match binop, to_value env arg1, to_value env arg2 with
        |Or, VBit(a), VBit(b) -> VBit(a || b)
        |Xor, VBit(a), VBit(b) -> VBit(a <> b)
        |And, VBit(a), VBit(b) -> VBit(a && b)
        |Nand, VBit(a), VBit(b) -> VBit(not (a && b))
        |_ -> failwith "binop not supported")

      | Emux(a1, a2, a3) -> let VBit(b1) = to_value env a1 in if b1 then to_value env a3 else to_value env a2
      | Erom(addr_s, wrd_s, read_addr) -> 
        let addr = from_16b ((fun (VBitArray(arr)) -> Array.to_list arr) (to_value env read_addr)) in
        rom.(addr_s)
      | Eram(addr_s, wrd_s, read_addr, we, wr_addr, data) -> 
        let r_addr = from_16b ((fun (VBitArray(arr)) -> Array.to_list arr) (to_value env read_addr)) in
        let w_addr = from_16b ((fun (VBitArray(arr)) -> Array.to_list arr) (to_value env wr_addr)) in
        to_write := (we, r_addr, wrd_s, w_addr, data) :: !to_write; 
        ram.(r_addr)
      | Econcat(a1, a2) -> (match to_value env a1, to_value env a2 with 
        | VBitArray(arr1), VBitArray(arr2) -> VBitArray(Array.concat [arr1; arr2])
        | VBitArray(arr1), VBit(a) -> VBitArray(Array.concat [arr1; [|a|]])
        | VBit(a), VBitArray(arr2) -> VBitArray(Array.concat [[|a|]; arr2])
        | VBit(a), VBit(b) -> VBitArray([|a; b|]))
      | Eslice(i1, i2, a) -> let VBitArray(arr) = to_value env a in VBitArray(Array.sub arr i1 (i2-i1+1))
      | Eselect(i, a) -> match to_value env a with 
        |VBit(a) -> VBit(a)
        |VBitArray(arr) -> VBit(arr.(i)) in
    let add env eq =  Env.add (fst eq) (eval env eq) env in
    let current_env = List.fold_left add Env.empty p.p_eqs in

    (*faire les writes de RAM*)
    let set_white = ref [] and set_black = ref [] in
    let mem_add (we, addr_s, wrd_s, addr, data) = 
      let VBit(write) = to_value current_env we in
      if write then (
        let dat = to_value current_env data in
        ram.(addr) <- dat;
        if addr >= start_ram_screen then 
          let VBitArray(arr) = dat in
          let addr = addr - start_ram_screen in
          for i = 0 to 15 do 
            if arr.(i) = false then set_white := (16*addr+i) :: !set_white else set_black := (16*addr+i) :: !set_black
          done)
    in
    List.iter mem_add !to_write;
    update_display !set_white !set_black;
    
    let input = get_input () in
    if input.Graphics.keypressed then match input.Graphics.key with
      |'m' | 'M' -> ram.(7*16) <- to_16b(1) 
      |'s' | 'S' -> ram.(8*16) <- to_16b(1) 
      |'r' | 'R' -> ram.(9*16) <- to_16b(1) 
      |_ -> ();

    if time() > !t +. 1. then
      (ram.(0) <- to_16b(1) ; t := !t +. 1.);

    Printf.printf "\n nouveau cycle \n";
    for i = 7 to 12 do
      Printf.printf "%d\n%!" (from_16b ((fun (VBitArray(arr)) -> Array.to_list arr) ram.(i)))
    done
    
  done


let compile filename =
  Printf.printf "hello0%!";
  try
    let p = Netlist.read_file filename in
    Printf.printf "hello1%!";
    try
      let p = Scheduler.schedule p in
      Printf.printf "hello2%!";
      simulator p !number_steps
    with
      | Scheduler.Combinational_cycle ->
          Format.eprintf "The netlist has a combinatory cycle.@.";
  with
    | Netlist.Parse_error s -> Format.eprintf "An error accurred: %s@." s; exit 2

let main () =
  Arg.parse
    ["-n", Arg.Set_int number_steps, "Number of steps to simulate"]
    compile
    ""
;;
(*main ()*)
compile "processeur.txt"
