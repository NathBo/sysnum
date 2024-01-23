open Netlist_ast
open Graph

exception Combinational_cycle

let read_exp eq = 
  let arg_lst = (
      match snd eq with
    | Earg(arg) |Enot(arg)-> [arg]
    | Ereg(id) -> []
    | Ebinop(binop, arg1, arg2) -> [arg1; arg2]
    | Emux(a1, a2, a3) -> [a1; a2; a3]
    | Erom(i1, i2, a) -> [a]
    | Eram(i1, i2, a1, a2, a3, a4) -> [a1]
    | Econcat(a1, a2) -> [a1; a2]
    | Eslice(i1, i2, a) -> [a]
    | Eselect(i2, a) -> [a]) in
  let rec identify = function
    |[] -> []
    |a :: q -> begin match a with 
      |Avar(id) -> id :: identify q
      |Aconst(c) -> identify q
      end in
  identify arg_lst

let schedule p = 
  let eqs = p.p_eqs and p_inputs = p.p_inputs and p_outputs = p.p_outputs and p_vars = p.p_vars in
  let var_eq = Hashtbl.create (List.length eqs) in
  let g = mk_graph () in
  List.iter (fun x -> (add_node g (fst x); Hashtbl.add var_eq (fst x) x)) eqs;
  let depends_on = List.map (fun eq -> (fst eq, read_exp eq)) eqs in
  List.iter (fun (x, x_dep) -> List.iter (fun dep -> try add_edge g dep x with Not_found -> ()) x_dep) depends_on;
  try
    let sorted_vars = topological g in
    {p_eqs= List.map (fun var -> Hashtbl.find var_eq var) sorted_vars; p_inputs; p_outputs; p_vars}
  with Cycle -> raise Combinational_cycle