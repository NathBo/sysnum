open Netlist_ast
open Graphics_helper
open Unix

let print_only = ref false
let number_steps = ref (-1)

exception Not_byte
type type_env = ty Env.t
type val_env = value Env.t

let simulator p number_steps script = 
  
  let to_16b n = 
    let rec d2b y lst = match y with 0 -> lst
        | _ -> d2b (y/2) ((y mod 2) :: lst)
      in
      let final = d2b n [] in
      (List.init (16-List.length final) (fun _ -> 0)) @ final
    in

  let prev_env = ref Env.empty in
  let ram = Array.make false (m_width*m_height + TODO) in

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
  let rom = Array.make 0 (32*List.length lines) in
  let i = ref 0 in
  List.iter (fun line -> 
      for j = 0 to 31 do 
          rom.(32* !i + j) <- int_of_char line.[j]
      done;
      i := !i + 32) lines;
  (*let rom = Array.map (fun s -> Vbit(bool_of_string x)) (Array.of_seq (String.to_seq (input_line ic))) in*)

  let t = localtime (time()) in
  let sec = t.tm_sec and min = t.tm_min and hour = t.tm_hour and mday = t.tm_mday and mon = t.tm_mon and year = 1900 + t.tm_year in
  TODO  (*donner heure initiale*);

  let t = ref (time()) in
  let k = ref 0 in 
  while !k <> number_steps do
    (*print_string ("Step " ^ string_of_int (!k+1) ^ ":\n");*)

    (*lire les inputs
    let booly x = if x="0" then false else if x="1" then true else raise Not_byte in
    let rec read_input var = Format.printf "%s = %!" var; match (Env.find var p.p_vars) with (*ou type_env*)
      |TBit -> (try VBit(booly (read_line ())) with |Not_byte -> (Format.printf "Wrong input\n%!"; read_input var))
      |TBitArray(n) -> (try let inp = read_line () in if String.length inp <> n then raise Not_byte else 
        VBitArray(Array.init n (fun t -> booly(String.make 1 inp.[t]))) with |Not_byte -> (Format.printf "Wrong input\n%!"; read_input var)) in
    let current_env = List.fold_left (fun env var -> Env.add var (read_input var) env) Env.empty p.p_inputs in *)

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
        |Nand, VBit(a), VBit(b) -> VBit(not (a && b)))

      | Emux(a1, a2, a3) -> let VBit(b1) = to_value env a1 in if b1 then to_value env a3 else to_value env a2
      | Erom(addr_s, wrd_s, read_addr) -> if wrd_s = 1 then Vbit(ram.(read_addr)) else VBitArray(Array.sub ram read_addr wrd_s)
      | Eram(addr_s, wrd_s, read_addr, we, wr_addr, data) -> to_write := (we, addr_s, wrd_s, wr_addr, data) :: !to_write; 
        (if wrd_s = 1 then Vbit(ram.(read_addr)) else VBitArray(Array.sub ram read_addr wrd_s))
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
    let mem_add (we, addr_s, wrd_s, addr, data) = 
      let VBit(write) = to_value current_env we in
      if write then let VBitArray(dat) = to_value current_env data and address = to_value current_env addr in
      let set_white = ref [] and set_black = ref [] in
      for i = 0 to wrd_s-1 do
        ram.(address+i) <- dat.(i)
        if dat.(i) = VBit(false) then set_white <- (adress+i) :: !set_white else set_black <- (adress+i) :: !set_black
      done; 
      update_display set_white set_black
    in
    List.iter mem_add !to_write;
    
    let input = get_input in
    if input.Graphics.key_pressed then match input.Graphics.key with
      |'m' | 'M' -> ram.(TODO) <- 1 
      |'s' | 'S' -> ram.(TODO) <- 1 
      |'r' | 'R' -> ram.(TODO) <- 1 
      |_ -> ()

    if time() > !t + 1 then
      (ram.(TODO) <- 1; incr t)
    
    (*print l'output, pas utile ici
    prev_env := current_env;
    let to_string = function 
      |VBit(a) -> if a then "1" else "0"
      |VBitArray(arr) -> String.concat "" (List.map (fun a -> if a then "1" else "0") (Array.to_list arr)) in
    List.iter (fun id -> print_endline ("=> " ^ id ^ " = " ^ to_string (to_value current_env (Avar(id))))) p.p_outputs;
  k := !k+1;
  done
  *)


let compile filename =
  try
    let p = Netlist.read_file filename in
    begin try
        let p = Scheduler.schedule p in
        simulator p !number_steps
      with
        | Scheduler.Combinational_cycle ->
            Format.eprintf "The netlist has a combinatory cycle.@.";
    end;
  with
    | Netlist.Parse_error s -> Format.eprintf "An error accurred: %s@." s; exit 2

let main () =
  Arg.parse
    ["-n", Arg.Set_int number_steps, "Number of steps to simulate"]
    compile
    ""
;;

main ()
