(** Lexer for the mini Lisp interpreter.
    It converts an input string into a list of {!Token.t} values.

    The implementation walks over the input character by character,
    building tokens for parentheses, numbers, strings and symbols.
    Whitespace separates tokens and is otherwise ignored.
*)

open Token

let is_whitespace = function
  | ' ' | '\n' | '\t' | '\r' -> true
  | _ -> false

let is_digit c = c >= '0' && c <= '9'

(* [read_number s i] reads a numeric literal starting at index [i].
   It returns the parsed float and the position immediately after the
   literal. Only decimal numbers are supported for now. *)
let read_number s i =
  let len = String.length s in
  let rec aux j =
    if j < len then
      match s.[j] with
      | c when is_digit c || c = '.' -> aux (j + 1)
      | _ -> j
    else j
  in
  let j = aux i in
  let substr = String.sub s i (j - i) in
  let value = float_of_string substr in
  (Number value, j)

(* [read_symbol s i] reads a symbol starting at index [i].
   A symbol is any sequence of characters that does not contain
   whitespace or parentheses. *)
let read_symbol s i =
  let len = String.length s in
  let rec aux j =
    if j < len then
      match s.[j] with
      | '(' | ')' | '"' -> j (* stop before delimiters *)
      | c when is_whitespace c -> j
      | _ -> aux (j + 1)
    else j
  in
  let j = aux i in
  let substr = String.sub s i (j - i) in
  (Symbol substr, j)

(* [read_string s i] reads a string literal starting at index [i].
   Strings are delimited by double quotes. Escapes are not yet supported. *)
let read_string s i =
  let len = String.length s in
  let rec aux j =
    if j < len then
      match s.[j] with
      | '"' -> j
      | _ -> aux (j + 1)
    else failwith "Unterminated string"
  in
  let j = aux (i + 1) in
  let substr = String.sub s (i + 1) (j - i - 1) in
  (String substr, j + 1)

(* Main tokenization function. *)
let tokenize s =
  let len = String.length s in
  let rec aux i acc =
    if i >= len then List.rev acc
    else
      match s.[i] with
      | c when is_whitespace c -> aux (i + 1) acc
      | '(' -> aux (i + 1) (LParen :: acc)
      | ')' -> aux (i + 1) (RParen :: acc)
      | '"' ->
          let (tok, j) = read_string s i in
          aux j (tok :: acc)
      | c when is_digit c || (c = '-' && i + 1 < len && is_digit s.[i + 1]) ->
          let (tok, j) = read_number s i in
          aux j (tok :: acc)
      | _ ->
          let (tok, j) = read_symbol s i in
          aux j (tok :: acc)
  in
  aux 0 []
