open OUnit2

let tokens_of s = Lexer.tokenize s

let test_parse_simple _ =
  let ast = Parser.parse (tokens_of "(+ 1 2)") in
  let open Ast in
  let expected = [List [Symbol "+"; Number 1.; Number 2.]] in
  assert_equal expected ast

let test_nested _ =
  let ast = Parser.parse (tokens_of "(define x (+ 1 2))") in
  let open Ast in
  let expected =
    [List [Symbol "define"; Symbol "x"; List [Symbol "+"; Number 1.; Number 2.]]]
  in
  assert_equal expected ast

let suite =
  "parser" >::: [
    "simple" >:: test_parse_simple;
    "nested" >:: test_nested;
  ]

let () = run_test_tt_main suite
