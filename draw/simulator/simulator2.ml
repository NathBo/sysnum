open Netlist_ast
open Graphics_helper
open Unix
let compt= ref 0
let print_only = ref false
let number_steps = ref (-1)

let env = Hashtbl.create 256

let envreg = Hashtbl.create 256

let memory = Hashtbl.create 256

let rams = ref []


let rec puissance a n = match n with
    | 0 -> 1
    | _ -> a*puissance a (n-1)

let ajout_a_env id t = match t with
  | TBit -> Hashtbl.add env id (VBit false);Hashtbl.add envreg id (VBit false)
  | TBitArray n -> Hashtbl.add env id (VBitArray(Array.make n false));Hashtbl.add envreg id (VBitArray(Array.make n false))

let rec input_dans_env l p_vars = match l with
  | [] -> ()
  | id::q -> begin match Env.find id p_vars with
    | TBit -> print_string id;
      print_string " ? ";
      let s = ref (read_line ()) in
      while !s <> "0" && !s<> "1" do
        print_string "Wrong input.\n";
        print_string id;
        print_string " ? ";
        s := read_line () done;
      if !s="0"
      then Hashtbl.replace env id (VBit false)
      else Hashtbl.replace env id (VBit true);
      input_dans_env q p_vars
    | TBitArray n -> print_string id;
      print_string " ? ";
      let s = ref (read_line ()) in
      let rep = Array.make n false in
      let correct = ref (String.length !s = n) in
      for i=0 to n-1 do
        if !correct && !s.[i] = '0'
        then rep.(i) <- false
        else if !correct && !s.[i] = '1'
        then rep.(i) <- true
        else correct := false done;
      while not !correct do
        print_string "Wrong input.\n";
        print_string id;
        print_string " ? ";
        let s = ref (read_line ()) in
        correct := (String.length !s = n);
        for i=0 to n-1 do
          if !correct && !s.[i] = '0'
          then rep.(i) <- false
          else if !correct && !s.[i] = '1'
          then rep.(i) <- true
          else correct := false done;done;
      Hashtbl.replace env id (VBitArray rep);
      input_dans_env q p_vars end

let refersh_envreg id _ =
  Hashtbl.replace envreg id (Hashtbl.find env id)

let xor a b =
  (a || b) && (not (a&&b))

let string_of_bit b =
  if b then "1" else "0"

let compute_value valu = match valu with
  | VBit b -> b
  | _ -> failwith "Pas un bit mais un array"

let compute_array valu = match valu with
  | VBit b -> Array.make 1 b
  | VBitArray a -> a

let compute_arg argu = match argu with
  | Avar id -> Hashtbl.find env id
  | Aconst valu -> valu


  let print_bool b =
    if b then print_string "1"
    else print_string "0"
  
  let print_bool_array bs =
    for i=0 to Array.length bs -1 do
      print_bool bs.(i)
    done;
    print_endline ""


  let bitarray_to_int v = match v with
  | VBit b -> if b then 1 else 0
  | VBitArray a -> let rep = ref 0 in
    let power2 = ref 1 in
    for i=0 to (Array.length a)-1 do
      if(a.(i))then rep := !rep + !power2;
      power2 := !power2*2 done;
    !rep

let bit_of_char c =
  if c = '0'
    then false
else if c = '1'
  then true
else failwith "Invalid character for a bit (not 0 or 1)"

let execute exp id = match exp with
  | Earg argu -> compute_arg argu
  | Enot argu -> VBit (not(compute_value(compute_arg argu)))
  | Ebinop (op,argu1,argu2) ->  begin match op with
    | Or -> VBit(compute_value (compute_arg argu1) || compute_value (compute_arg argu2))
    | Xor -> VBit(xor (compute_value (compute_arg argu1)) (compute_value (compute_arg argu2)))
    | And -> VBit(compute_value (compute_arg argu1) && compute_value (compute_arg argu2))
    | Nand -> VBit(compute_value (compute_arg argu1) && compute_value (compute_arg argu2)) end
  | Emux (argu1,argu2,argu3) -> if (compute_value (compute_arg argu1))
    then compute_arg(argu3)
    else compute_arg(argu2)
  | Econcat (arg1,arg2) -> VBitArray(Array.append (compute_array(compute_arg arg1)) (compute_array(compute_arg arg2)))
  | Eslice (a,b,argu) -> VBitArray(Array.sub (compute_array (compute_arg argu)) a (b-a+1))
  | Eselect (i,argu) -> VBit((compute_array (compute_arg argu)).(i))
  | Ereg id -> Hashtbl.find envreg id
  | Erom (adrrs,wrds,addr) -> if Hashtbl.mem memory id
    then (Hashtbl.find memory id).(bitarray_to_int (compute_arg addr))
    else begin
      let ic = open_in ("../assembly/code_cpu.txt") in
      let rep = (Array.make (puissance 2 adrrs) (VBitArray(Array.make wrds false))) in
      for i=0 to puissance 2 adrrs -1 do
        let line = try input_line ic with End_of_file -> "00000000000000000000000000000000" in
        let tabl = Array.make wrds false in
        for j=0 to wrds-1 do
          tabl.(j) <- bit_of_char line.[j]
        done;
        rep.(i) <- VBitArray(tabl)
      done;
      Hashtbl.add memory id rep;
      (Hashtbl.find memory id).(bitarray_to_int (compute_arg addr))

    end 
  | Eram (adrrs,wrds,read_addr,write_e,write_addr,data) -> let rep = if Hashtbl.mem memory id
    then (Hashtbl.find memory id).(bitarray_to_int (compute_arg read_addr))
    else (Hashtbl.add memory id (Array.make (puissance 2 adrrs) (VBitArray(Array.make wrds false)));VBitArray(Array.make wrds false)) in
    rams := (id,exp):: (!rams);
    rep

let rec calc_eqs l = match l with
    | [] -> ()
    | (id,eq)::q -> Hashtbl.replace env id (execute eq id);calc_eqs q

let rec print_outputs l = match l with
    | [] -> ()
    | id::q -> let o = Hashtbl.find_opt env id in
      (match o with
        | None -> failwith ("la valeur "^id^" n'existe pas")
        | Some x -> (print_string (id^" => ");print_int (bitarray_to_int x);
            print_string "\n");
      print_outputs q)
    

let to_16b n =
  let rec d2b y lst = match y with 0 -> lst
      | _ -> d2b (y/2) ((if y mod 2 = 0 then false else true) :: lst)
    in
    let final = d2b n []
  in
  VBitArray (Array.of_list (List.rev (List.init (16-List.length final) (fun _ -> false) @ final)))
let simulator program number_steps = let number_steps= -1 in
  Env.iter ajout_a_env program.p_vars;
  let i = ref 1 in
  let ram = (Array.make (puissance 2 16) (VBitArray(Array.make 16 false))) in

  screen_init ();
  let start_screen = 100 in

  let t = (localtime (time())) in
  let sec = 0*t.tm_sec and min = 30+0*t.tm_min and hour = 23+0*t.tm_hour and mday = 29+0*t.tm_mday and mon = 1+0*t.tm_mon + 1 and year = 1999+0*(+1900 + t.tm_year) in
  let time_desc = Array.of_list (List.map to_16b [sec; min; hour; mday; mon; year]) in
  Array.blit time_desc 0 ram 1 (Array.length time_desc);
  Hashtbl.add memory "pre_result_ram" ram;
 
  let t = ref (time()) in

  while !i<>number_steps+1 do
    print_string "\nStep ";
    print_int !i;
    print_string ":\n";

    rams := [];
    Env.iter refersh_envreg program.p_vars;
    input_dans_env program.p_inputs program.p_vars;
    calc_eqs program.p_eqs;

    let set_white = ref [] and set_black = ref [] in
    let write_ram eq = match eq with
    | (id,Eram (adrrs,wrds,_,write_e,write_addr,data)) ->
      if compute_value(compute_arg write_e)
        then ((if not (Hashtbl.mem memory id)
          then Hashtbl.add memory id (Array.make (puissance 2 adrrs) (VBitArray(Array.make wrds false))));
          (Hashtbl.find memory id).(bitarray_to_int (compute_arg write_addr)) <- compute_arg data;
          match compute_arg data with 
          |VBitArray(arr) ->
            let addr = (bitarray_to_int (compute_arg write_addr)) - start_screen in
            for i = 0 to 15 do
              if arr.(i) then set_white := (16*addr+i) :: !set_white else set_black := (16*addr+i) :: !set_black
            done
          |_ -> failwith "la ram est pas 16 bit")
    | _ -> failwith "devrait etre un Eram" in
    List.iter write_ram !rams;
    update_display !set_white !set_black;

    print_outputs program.p_outputs;

    incr i;
    (*
    let ram = Hashtbl.find memory "pre_result_ram" in
    print_string "secondes : ";
    print_int (bitarray_to_int ram.(7));
    print_string "\nminutes : ";
    print_int (bitarray_to_int ram.(8));
    print_string "\nheures : ";
    print_int (bitarray_to_int ram.(9));
    print_string "\njours : ";
    print_int (bitarray_to_int ram.(10));
    print_string "\nmois : ";
    print_int (bitarray_to_int ram.(11));
    print_string "\nannées : ";
    print_int (bitarray_to_int ram.(12));
    print_endline "";
    *)
    ram.(0) <- to_16b(1)
    (*
    if time() > !t +. 1. then
      (ram.(0) <- to_16b(1); t := !t +. 1.;incr compt;);*)
  done


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

compile "processeur.txt"
