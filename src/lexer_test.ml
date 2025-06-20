open OUnit2

let test_simple _ =
  let open Token in
  let tokens = Lexer.tokenize "(+ 1 2)" in
  let expected = [LParen; Symbol "+"; Number 1.; Number 2.; RParen] in
  assert_equal ~printer:(fun ts -> String.concat "," (List.map (function
    | LParen -> "(" | RParen -> ")" | Number n -> string_of_float n
    | String s -> Printf.sprintf "\"%s\"" s | Symbol s -> s) ts))
    expected tokens

let suite = "lexer" >::: ["simple" >:: test_simple]

let () = run_test_tt_main suite
