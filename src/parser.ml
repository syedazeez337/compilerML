exception Error of string

let parse tokens =
  let rec parse_expr = function
    | Token.Number n :: rest -> (Ast.Number n, rest)
    | Token.String s :: rest -> (Ast.String s, rest)
    | Token.Symbol s :: rest -> (Ast.Symbol s, rest)
    | Token.LParen :: rest ->
        let rec parse_list acc = function
          | [] -> raise (Error "Unterminated list")
          | Token.RParen :: rest -> (Ast.List (List.rev acc), rest)
          | tokens ->
              let expr, rest' = parse_expr tokens in
              parse_list (expr :: acc) rest'
        in
        parse_list [] rest
    | Token.RParen :: _ -> raise (Error "Unexpected )")
    | [] -> raise (Error "Unexpected end of input")
  in
  let rec parse_multiple acc tokens =
    match tokens with
    | [] -> List.rev acc
    | _ ->
        let expr, rest = parse_expr tokens in
        parse_multiple (expr :: acc) rest
  in
  parse_multiple [] tokens
