type t =
  | Number of float
  | String of string
  | Symbol of string
  | List of t list
