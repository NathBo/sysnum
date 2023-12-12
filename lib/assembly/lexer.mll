{
    open Lexing
    open Format
    open Parser

    exception Lexing_error of string

    let resolve_keywords = 
        let keywords = Hashtbl.create 17 in
        List.iter
        (
            fun (keyword, token) -> Hashtbl.add keywords token 
        )
        (
            [
                ("stop", STOP);
                ("add", ADD);
                ("sub", SUB);
                ("movr", MOVR);
                ("movc", MOVC);
                ("jump", JUMP);
                ("getram", GETRAM);
                ("setram", SETRAM);
                ("rom", ROM);

                ("ra", REG( [0; 0; 0; 0] )); 
                ("rb", REG( [0; 0; 0; 1] ));
                ("rc", REG( [0; 0; 1; 0] ));
                ("rd", REG( [0; 0; 1; 1] ));
                ("re", REG( [0; 1; 0; 0] ));
                ("rf", REG( [0; 1; 0; 1] ));
                ("rg", REG( [0; 1; 1; 0] ));
                ("rh", REG( [0; 1; 1; 1] ));
                ("ri", REG( [1; 0; 0; 0] ));
                ("rj", REG( [1; 0; 0; 1] ));
                ("rk", REG( [1; 0; 1; 0] ));
                ("rl", REG( [1; 0; 1; 1] ));
                ("rm", REG( [1; 1; 0; 0] ));
                ("rn", REG( [1; 1; 0; 1] ));
                ("ro", REG( [1; 1; 1; 0] ));
                ("rp", REG( [1; 1; 1; 1] ))
                
            ]
        );
        fun kw -> try Hashtbl.find keywords kw
                  with Not_found -> raise (Lexing_error ("Keyword not found"))
    
    let convert_string_to_int s = 
        let list_bytes = ref [] in
        for i = (String.length s) - 1 downto 0 do
            list_bytes := 
                (
                    match s.[i] with
                        | "0" -> 0
                        | "1" -> 1
                ) 
                :: (!list_bytes)
        done;
        !list_bytes
}

let letter = ['a'-'z']
let word = (letter | number)+
let whitespace = [' ' '\t']
let newline = ['\n']
let digit = ['0' '1']
let number = digit*

let next_token = parse
    | whitespace
        { next_loken lexbuf}
    | newline
        { NEWLINE }
    | word as w
        { resolve_keywords w }
    | number as n
        { CONST( convert_string_to_int n ) }
    | eof
        { EOF }
    | _
        { raise (Lexing_error ("Invalid instruction"))}