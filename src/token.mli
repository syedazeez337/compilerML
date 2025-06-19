(** Representation of tokens recognized by the lexer. *)

type t =
  | LParen        (** '(' character *)
  | RParen        (** ')' character *)
  | Number of float  (** numeric literal *)
  | String of string (** string literal without quotes *)
  | Symbol of string (** symbol or identifier *)
