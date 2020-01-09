type t =
  | Let of (string * t)
  | Int of int
  | Bool of bool
  | Var of string
  | Add of (t * t)
  | Sub of (t * t)
  | Mul of (t * t)
  | Div of (t * t)
  | If of (t * t * t)
  | Eq of (t * t)
  | Neq of (t * t)
  | Lt of (t * t)
  | Le of (t * t)
  | Not of t
  | And of (t * t)
  | Or of (t * t)
  | Empty

(* 翻译模式 *)
let rec string_of_expr t =
  match t with
  | Int i ->
      string_of_int i
  | Bool b ->
      if b then "true" else "false"
  | Add (t1, t2) ->
      "(" ^ string_of_expr t1 ^ ")" ^ "+" ^ "(" ^ string_of_expr t2 ^ ")"
  | Sub (t1, t2) ->
      "(" ^ string_of_expr t1 ^ ")" ^ "-" ^ "(" ^ string_of_expr t2 ^ ")"
  | Mul (t1, t2) ->
      "(" ^ string_of_expr t1 ^ ")" ^ "*" ^ "(" ^ string_of_expr t2 ^ ")"
  | Div (t1, t2) ->
      "(" ^ string_of_expr t1 ^ ")" ^ "/" ^ "(" ^ string_of_expr t2 ^ ")"
  | Let (id, t) ->
      "let " ^ id ^ "=" ^ string_of_expr t
  | Var str ->
      str
  | If (t1, t2, t3) ->
      "if " ^ string_of_expr t1 ^ " then " ^ string_of_expr t2 ^ " else "
      ^ string_of_expr t3
  | Eq (t1, t2) ->
      "(" ^ string_of_expr t1 ^ ")" ^ "=" ^ "(" ^ string_of_expr t2 ^ ")"
  | Neq (t1, t2) ->
      "(" ^ string_of_expr t1 ^ ")" ^ "<>" ^ "(" ^ string_of_expr t2 ^ ")"
  | Lt (t1, t2) ->
      "(" ^ string_of_expr t1 ^ ")" ^ "<" ^ "(" ^ string_of_expr t2 ^ ")"
  | Le (t1, t2) ->
      "(" ^ string_of_expr t1 ^ ")" ^ "<=" ^ "(" ^ string_of_expr t2 ^ ")"
  | Or (t1, t2) ->
      "(" ^ string_of_expr t1 ^ ")" ^ "||" ^ "(" ^ string_of_expr t2 ^ ")"
  | And (t1, t2) ->
      "(" ^ string_of_expr t1 ^ ")" ^ "&&" ^ "(" ^ string_of_expr t2 ^ ")"
  | Not t1 ->
      "not(" ^ string_of_expr t1 ^ ")"
