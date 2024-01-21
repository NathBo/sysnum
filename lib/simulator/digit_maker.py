nlin, ncol = 12, 8
Nlin = 108

#Une template par chiffre
template = [
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0]
]

template1 = [
    [0, 0, 0, 0, 0, 1, 1, 0],
    [0, 0, 0, 0, 1, 1, 1, 0],
    [0, 0, 0, 1, 1, 1, 1, 0],
    [0, 0, 1, 1, 0, 1, 1, 0],
    [0, 0, 0, 0, 0, 1, 1, 0],
    [0, 0, 0, 0, 0, 1, 1, 0],
    [0, 0, 0, 0, 0, 1, 1, 0],
    [0, 0, 0, 0, 0, 1, 1, 0],
    [0, 0, 0, 0, 0, 1, 1, 0],
    [0, 0, 0, 0, 0, 1, 1, 0],
    [0, 0, 0, 0, 0, 1, 1, 0],
    [0, 0, 0, 0, 0, 1, 1, 0]
]

lst = [i*Nlin+j for i in range(nlin) for j in range(ncol) if template1[i][j]]

w = '[' + '; '.join(map(str, lst)) + ']'

with open("graphics_helper.ml", "w+") as file:
    file.write(
f"""
open Graphics
open Netlist_ast
        
let white = yellow and black = rgb 128 0 128

(*
conventions:
les bords font 8 megapixels  
les megapixels sont 8x8
un chiffre est en 12x8 megapixels 
*)

let screen_width = 992 and screen_height = 48*8
let mpixs = 8 and edge = 8
let m_width = screen_width/mpixs - 2*edge and m_height = screen_height/mpixs - 2*edge

let screen_init () = 
  open_graph (" " ^ (string_of_int screen_width) ^ "x" ^ (string_of_int screen_height)); (*oui, il faut un espace en premier*)
  set_window_title "clock";
  set_color black;
  fill_rect 0 0 (screen_width-1) (screen_height-1);
  auto_synchronize false

let draw_ram ram = 
  if Array.length ram <> screen_width * screen_height then failwith "image size and window size do not match";
  fill_rect 0 0 (screen_width-1) (screen_height-1);
  set_color white;
  let to_display = ref [] in
  for i = 0 to screen_height - 1 do
    for j = 0 to screen_width - 1 do
      if ram.(i*screen_width + j) = VBit(true) then to_display := (j, i) :: !to_display
      done
    done;
  plots (Array.of_list !to_display);
  set_color black;
  synchronize ()

let update_display to_change_white to_change_black =

  let update (color, lst) = 
    set_color color;
    let to_display = List.map (fun i -> (mpixs * (edge+ (i mod m_width)), mpixs*(1+edge + (i/m_width)))) lst in
    List.iter (fun (x, y) -> fill_rect x (screen_height - y) mpixs mpixs) to_display in
  List.iter update [(white, to_change_white); (black, to_change_black)];
  synchronize ()

let get_input () = wait_next_event [Key_pressed; Poll]

let tests () = 
  screen_init ();
  let w = {w} in
  update_display w [];
  Unix.sleep 60
  

let _=tests ()
""")
