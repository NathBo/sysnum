
open Graphics
open Netlist_ast
        
let white = yellow and black = rgb 128 0 128

(*
conventions:
les bords font 4 megapixels  
les megapixels sont 8x8
un chiffre est en 11x6 megapixels 
*)
let nlin = 22 and ncol = 16
let mpixs = 4 and edge = 4
let screen_width = (2*edge + 10*ncol)*mpixs and screen_height = (2*edge + 3*nlin)*mpixs
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
  List.iter update [(black, to_change_black); (white, to_change_white)];
  synchronize ()

let get_input () = wait_next_event [Key_pressed; Poll]

let tests () = 
  screen_init ();
  let w = [1; 2; 3; 4; 108; 113; 216; 221; 324; 329; 432; 437; 648; 653; 756; 761; 864; 869; 972; 977; 1081; 1082; 1083; 1084] in
  update_display w [];
  Unix.sleep 60


  let display_0 pos = 
    update_display (List.map (fun off -> off + pos)[4; 5; 6; 7; 8; 9; 10; 11; 164; 165; 166; 167; 168; 169; 170; 171; 322; 323; 332; 333; 482; 483; 492; 493; 642; 643; 652; 653; 802; 803; 812; 813; 962; 963; 972; 973; 1122; 1123; 1132; 1133; 1282; 1283; 1292; 1293; 1442; 1443; 1452; 1453; 1922; 1923; 1932; 1933; 2082; 2083; 2092; 2093; 2242; 2243; 2252; 2253; 2402; 2403; 2412; 2413; 2562; 2563; 2572; 2573; 2722; 2723; 2732; 2733; 2882; 2883; 2892; 2893; 3042; 3043; 3052; 3053; 3204; 3205; 3206; 3207; 3208; 3209; 3210; 3211; 3364; 3365; 3366; 3367; 3368; 3369; 3370; 3371]) []
  
  let display_1 pos = 
    update_display (List.map (fun off -> off + pos)[332; 333; 492; 493; 652; 653; 812; 813; 972; 973; 1132; 1133; 1292; 1293; 1452; 1453; 1932; 1933; 2092; 2093; 2252; 2253; 2412; 2413; 2572; 2573; 2732; 2733; 2892; 2893; 3052; 3053]) []
  
  let display_2 pos = 
    update_display (List.map (fun off -> off + pos)[4; 5; 6; 7; 8; 9; 10; 11; 164; 165; 166; 167; 168; 169; 170; 171; 332; 333; 492; 493; 652; 653; 812; 813; 972; 973; 1132; 1133; 1292; 1293; 1452; 1453; 1604; 1605; 1606; 1607; 1608; 1609; 1610; 1611; 1764; 1765; 1766; 1767; 1768; 1769; 1770; 1771; 1922; 1923; 2082; 2083; 2242; 2243; 2402; 2403; 2562; 2563; 2722; 2723; 2882; 2883; 3042; 3043; 3204; 3205; 3206; 3207; 3208; 3209; 3210; 3211; 3364; 3365; 3366; 3367; 3368; 3369; 3370; 3371]) []
  
  let display_3 pos = 
    update_display (List.map (fun off -> off + pos)[4; 5; 6; 7; 8; 9; 10; 11; 164; 165; 166; 167; 168; 169; 170; 171; 332; 333; 492; 493; 652; 653; 812; 813; 972; 973; 1132; 1133; 1292; 1293; 1452; 1453; 1604; 1605; 1606; 1607; 1608; 1609; 1610; 1611; 1764; 1765; 1766; 1767; 1768; 1769; 1770; 1771; 1932; 1933; 2092; 2093; 2252; 2253; 2412; 2413; 2572; 2573; 2732; 2733; 2892; 2893; 3052; 3053; 3204; 3205; 3206; 3207; 3208; 3209; 3210; 3211; 3364; 3365; 3366; 3367; 3368; 3369; 3370; 3371]) []
  
  let display_4 pos = 
    update_display (List.map (fun off -> off + pos)[322; 323; 332; 333; 482; 483; 492; 493; 642; 643; 652; 653; 802; 803; 812; 813; 962; 963; 972; 973; 1122; 1123; 1132; 1133; 1282; 1283; 1292; 1293; 1442; 1443; 1452; 1453; 1604; 1605; 1606; 1607; 1608; 1609; 1610; 1611; 1764; 1765; 1766; 1767; 1768; 1769; 1770; 1771; 1932; 1933; 2092; 2093; 2252; 2253; 2412; 2413; 2572; 2573; 2732; 2733; 2892; 2893; 3052; 3053]) []
  
  let display_5 pos = 
    update_display (List.map (fun off -> off + pos)[4; 5; 6; 7; 8; 9; 10; 11; 164; 165; 166; 167; 168; 169; 170; 171; 322; 323; 482; 483; 642; 643; 802; 803; 962; 963; 1122; 1123; 1282; 1283; 1442; 1443; 1604; 1605; 1606; 1607; 1608; 1609; 1610; 1611; 1764; 1765; 1766; 1767; 1768; 1769; 1770; 1771; 1932; 1933; 2092; 2093; 2252; 2253; 2412; 2413; 2572; 2573; 2732; 2733; 2892; 2893; 3052; 3053; 3204; 3205; 3206; 3207; 3208; 3209; 3210; 3211; 3364; 3365; 3366; 3367; 3368; 3369; 3370; 3371]) []
  
  let display_6 pos = 
    update_display (List.map (fun off -> off + pos)[4; 5; 6; 7; 8; 9; 10; 11; 164; 165; 166; 167; 168; 169; 170; 171; 322; 323; 482; 483; 642; 643; 802; 803; 962; 963; 1122; 1123; 1282; 1283; 1442; 1443; 1604; 1605; 1606; 1607; 1608; 1609; 1610; 1611; 1764; 1765; 1766; 1767; 1768; 1769; 1770; 1771; 1922; 1923; 1932; 1933; 2082; 2083; 2092; 2093; 2242; 2243; 2252; 2253; 2402; 2403; 2412; 2413; 2562; 2563; 2572; 2573; 2722; 2723; 2732; 2733; 2882; 2883; 2892; 2893; 3042; 3043; 3052; 3053; 3204; 3205; 3206; 3207; 3208; 3209; 3210; 3211; 3364; 3365; 3366; 3367; 3368; 3369; 3370; 3371]) []
  
  let display_7 pos = 
    update_display (List.map (fun off -> off + pos)[4; 5; 6; 7; 8; 9; 10; 11; 164; 165; 166; 167; 168; 169; 170; 171; 332; 333; 492; 493; 652; 653; 812; 813; 972; 973; 1132; 1133; 1292; 1293; 1452; 1453; 1932; 1933; 2092; 2093; 2252; 2253; 2412; 2413; 2572; 2573; 2732; 2733; 2892; 2893; 3052; 3053]) []
  
  let display_8 pos = 
    update_display (List.map (fun off -> off + pos)[4; 5; 6; 7; 8; 9; 10; 11; 164; 165; 166; 167; 168; 169; 170; 171; 322; 323; 332; 333; 482; 483; 492; 493; 642; 643; 652; 653; 802; 803; 812; 813; 962; 963; 972; 973; 1122; 1123; 1132; 1133; 1282; 1283; 1292; 1293; 1442; 1443; 1452; 1453; 1604; 1605; 1606; 1607; 1608; 1609; 1610; 1611; 1764; 1765; 1766; 1767; 1768; 1769; 1770; 1771; 1922; 1923; 1932; 1933; 2082; 2083; 2092; 2093; 2242; 2243; 2252; 2253; 2402; 2403; 2412; 2413; 2562; 2563; 2572; 2573; 2722; 2723; 2732; 2733; 2882; 2883; 2892; 2893; 3042; 3043; 3052; 3053; 3204; 3205; 3206; 3207; 3208; 3209; 3210; 3211; 3364; 3365; 3366; 3367; 3368; 3369; 3370; 3371]) []
  
  let display_9 pos = 
    update_display (List.map (fun off -> off + pos)[4; 5; 6; 7; 8; 9; 10; 11; 164; 165; 166; 167; 168; 169; 170; 171; 322; 323; 332; 333; 482; 483; 492; 493; 642; 643; 652; 653; 802; 803; 812; 813; 962; 963; 972; 973; 1122; 1123; 1132; 1133; 1282; 1283; 1292; 1293; 1442; 1443; 1452; 1453; 1604; 1605; 1606; 1607; 1608; 1609; 1610; 1611; 1764; 1765; 1766; 1767; 1768; 1769; 1770; 1771; 1932; 1933; 2092; 2093; 2252; 2253; 2412; 2413; 2572; 2573; 2732; 2733; 2892; 2893; 3052; 3053; 3204; 3205; 3206; 3207; 3208; 3209; 3210; 3211; 3364; 3365; 3366; 3367; 3368; 3369; 3370; 3371]) []

let from_16b l =
  let rec aux acc = function
    |[] -> acc
    |b :: t -> aux (2*acc + Bool.to_int b) t in
  aux 0 (List.rev l)

let leading_zero s = match String.length s with 
  |1 -> "0" ^ s |_ -> s
(*
let display_init ram_arr = 
  let positions = [|0; 16; 48; 64; 96; 112; 4800; 4816; 4848; 4864; 4896; 4912|] in
  let strings = "            " in
  for i = 0 to 5 do
    let s = leading_zero (string_of_int (from_16b ((fun (VBitArray(arr)) -> Array.to_list arr) ram_arr.(i)))) in
    strings.[2*i] <- s.[0]; strings.[2*i+1] <- s.[1]
*)
