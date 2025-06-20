(** Parser for the Lisp interpreter. *)

exception Error of string

val parse : Token.t list -> Ast.t list
(** [parse tokens] converts a list of tokens into a list of top-level
    expressions. Raises [Error] if the tokens are malformed. *)
