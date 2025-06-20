(** Abstract syntax tree for the Lisp interpreter. *)

(** Type representing a Lisp expression. *)
type t =
  | Number of float
  | String of string
  | Symbol of string
  | List of t list
