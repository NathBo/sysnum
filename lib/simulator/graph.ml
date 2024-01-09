exception Cycle
type mark = NotVisited | InProgress | Visited

type 'a graph =
    { mutable g_nodes : 'a node list }
and 'a node = {
  n_label : 'a;
  mutable n_mark : mark;
  mutable n_link_to : 'a node list;
  mutable n_linked_by : 'a node list;
}

let mk_graph () = { g_nodes = [] }

let add_node g x =
  let n = { n_label = x; n_mark = NotVisited; n_link_to = []; n_linked_by = [] } in
  g.g_nodes <- n :: g.g_nodes

let node_of_label g x =
  List.find (fun n -> n.n_label = x) g.g_nodes

let add_edge g id1 id2 =
  (*try*)
    let n1 = node_of_label g id1 in
    let n2 = node_of_label g id2 in
    n1.n_link_to   <- n2 :: n1.n_link_to;
    n2.n_linked_by <- n1 :: n2.n_linked_by
  (*with Not_found -> Format.eprintf "Tried to add an edge between non-existing nodes"; raise Not_found*)

let clear_marks g =
  List.iter (fun n -> n.n_mark <- NotVisited) g.g_nodes

let find_roots g =
  List.filter (fun n -> n.n_linked_by = []) g.g_nodes

let rec dfs_cycle a = 
  if a.n_mark = InProgress then raise Cycle
  else begin
    if a.n_mark = NotVisited then
    a.n_mark <- InProgress;
    List.iter dfs_cycle a.n_link_to;
    end;
  a.n_mark <- Visited

let has_cycle g = 
  try
    List.iter dfs_cycle g.g_nodes;
    clear_marks g;
    false
  with Cycle ->
    clear_marks g;
    true

let topological g = 
  if has_cycle g then raise Cycle
  else begin
  (*
  let rec dfs_topo a lst =
    (*a.n_label :: List.fold_left (@) [] (List.map dfs_topo a.n_link_to)*)
    a.n_label :: List.fold_left (fun acc b -> dfs_topo b acc) lst a.n_link_to

  List.rev (List.fold_left (fun acc b -> dfs_topo b acc) [] (find_roots g)) 
  

  let rec dfs_topo (ord : 'a list) (a : 'a node) = 
    a.n_label :: List.fold_left (fun acc b -> dfs_topo acc b) ord a.n_link_to

  List.fold_left (fun acc b -> dfs_topo acc b) [] (find_roots g)  *)
    
  let ord = ref [] in

  let rec dfs_topo a = 
    a.n_mark <- Visited;
    List.iter dfs_topo (List.filter (fun n -> n.n_mark = NotVisited) a.n_link_to);
    ord := a.n_label :: !ord in

  List.iter dfs_topo (find_roots g);
  clear_marks g;
  !ord
  end;;







  
