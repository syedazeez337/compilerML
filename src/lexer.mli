(** Tokenizer for the Lisp interpreter. *)

val tokenize : string -> Token.t list
(** [tokenize s] converts the string [s] into a list of tokens. *)
