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
                ("addc", ADDC);
                ("sub", SUB);
                ("subc", SUBC);
                ("movr", MOVR);
                ("movc", MOVC);
                ("jump", JUMP);
                ("getram", GETRAM);
                ("setram", SETRAM);

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
    
    let convert_to_base_2 n = 
        let rec aux cur_val cur_bit = match (cur_val, cur_bit) with
            | (0, 16) -> ""
            | (_, 16) -> raise (Lexing_error ("Overflow in constant"))
            | (0, _) -> "0" ^ (aux 0 (cur_bit + 1))
            | (v, _) ->  (if v mod 2 = 0 then "0"
                        else "1") ^ (aux (v / 2) (cur_bit + 1)) in
        aux n 0
}

let letter = ['a'-'z']
let whitespace = [' ' '\t']
let newline = ['\n']
let digit = ['0'-'9']
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
        { CONST( convert_to_base_2 (int_of_string (n))) }
    | eof
        { EOF }
    | _
        { raise (Lexing_error ("Invalid instruction"))}