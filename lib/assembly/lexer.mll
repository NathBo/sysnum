{
    open Lexing
    open Format
    open Parser

    exception Lexing_error of string

    let resolve_keywords = 
        let keywords = Hashtbl.create 17 in
        List.iter
        (
            fun (keyword, token) -> Hashtbl.add keywords keyword token
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

                ("ra", REG( "0000" )); 
                ("rb", REG( "0001" ));
                ("rc", REG( "0010" ));
                ("rd", REG( "0011" ));
                ("re", REG( "0100" ));
                ("rf", REG( "0101" ));
                ("rg", REG( "0110" ));
                ("rh", REG( "0111" ));
                ("ri", REG( "1000" ));
                ("rj", REG( "1001" ));
                ("rk", REG( "1010" ));
                ("rl", REG( "1011" ));
                ("rm", REG( "1100" ));
                ("rn", REG( "1101" ));
                ("ro", REG( "1110" ));
                ("rp", REG( "1111" ))
                
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
                        | '0' -> 0
                        | '1' -> 1
                        | _ -> assert false (* Cas impossible par construction *)
                ) 
                :: (!list_bytes)
        done;
        !list_bytes
}

let letter = ['a'-'z']
let whitespace = [' ' '\t']
let newline = ['\n']
let digit = ['0' '1']
let number = digit*
let word = letter+

rule next_token = parse
    | whitespace
        { next_token lexbuf}
    | newline
        { NEWLINE }
    | word as w
        { resolve_keywords w }
    | number as n
        { CONST( n ) }
    | eof
        { EOF }
    | _
        { raise (Lexing_error ("Invalid instruction"))}