open Syntax
open Type

let isDebug = true

type value = VInt of int | VBool of bool | Unit

let print_value v =
  match v with
  | VInt i ->
      print_int i
  | VBool b ->
      if b then print_string "true" else print_string "false"
  | Unit ->
      print_string "()"

let debug v nest = if isDebug then (flush stdout ; v) else v

exception Undefined of string

let rec eval e env nest =
  flush stdout ;
  match e with
  | Int ci ->
      debug (VInt ci) nest
  | Bool cb ->
      debug (VBool cb) nest
  | Add (e1, e2) -> (
      let v1, v2 = (eval e1 env (nest + 1), eval e2 env (nest + 1)) in
      match (v1, v2) with VInt v1, VInt v2 -> debug (VInt (v1 + v2)) nest )
  | Sub (e1, e2) -> (
      let v1, v2 = (eval e1 env (nest + 1), eval e2 env (nest + 1)) in
      match (v1, v2) with VInt v1, VInt v2 -> debug (VInt (v1 - v2)) nest )
  | Mul (e1, e2) -> (
      let v1, v2 = (eval e1 env (nest + 1), eval e2 env (nest + 1)) in
      match (v1, v2) with VInt v1, VInt v2 -> debug (VInt (v1 * v2)) nest )
  | Div (e1, e2) -> (
      let v1, v2 = (eval e1 env (nest + 1), eval e2 env (nest + 1)) in
      match (v1, v2) with VInt v1, VInt v2 -> debug (VInt (v1 / v2)) nest )
  | Let (id, e) ->
      let v = eval e env (nest + 1) in
      Hashtbl.add env id v ; Unit
  | Var id -> (
    try debug (Hashtbl.find env id) nest
    with Not_found -> raise (Undefined id) )
  | If (e1, e2, e3) -> (
      let v1, v2, v3 =
        (eval e1 env (nest + 1), eval e2 env (nest + 1), eval e3 env (nest + 1))
      in
      match v1 with
      | VBool true ->
          debug v2 nest
      | VBool false ->
          debug v3 nest )
  | Lt (e1, e2) -> (
    match (eval e1 env (nest + 1), eval e2 env (nest + 1)) with
    | VInt i1, VInt i2 ->
        debug (VBool (i1 < i2)) nest )
  | Le (e1, e2) -> (
    match (eval e1 env (nest + 1), eval e2 env (nest + 1)) with
    | VInt i1, VInt i2 ->
        debug (VBool (i1 <= i2)) nest )
  | Eq (e1, e2) -> (
    match (eval e1 env (nest + 1), eval e2 env (nest + 1)) with
    | VInt i1, VInt i2 ->
        debug (VBool (i1 = i2)) nest )
  | Neq (e1, e2) -> (
    match (eval e1 env (nest + 1), eval e2 env (nest + 1)) with
    | VInt i1, VInt i2 ->
        debug (VBool (i1 <> i2)) nest )
  | And (e1, e2) -> (
    match (eval e1 env (nest + 1), eval e2 env (nest + 1)) with
    | VBool i1, VBool i2 ->
        debug (VBool (i1 && i2)) nest )
  | Or (e1, e2) -> (
    match (eval e1 env (nest + 1), eval e2 env (nest + 1)) with
    | VBool i1, VBool i2 ->
        debug (VBool (i1 || i2)) nest )
  | Not e1 -> (
    match eval e1 env (nest + 1) with VBool b -> debug (VBool (not b)) nest )

let next_channel value channel =
  if channel == stdin then match value with _ -> stdin else channel

let _ =
  print_string "     mml version 1.0.0     ";
  print_endline "\n";
  let env = Hashtbl.create 100 in
  let ch = ref stdin in
  while true do
    try
      print_string ">" ;
      flush stdout ;
      let lexbuf = Lexing.from_channel !ch in
      let expr = Parser.main Lex.token lexbuf in
      match expr with
      | Empty ->
          ()
      | _ ->
          let result = eval expr env 0 in
          print_value result ;
          print_newline () ;
          flush stdout ;
          ch := next_channel result !ch
    with
    | Lex.Eof ->
        ch := stdin
    | Parsing.Parse_error ->
        print_string "[Error] Parsing error!\n"
    | Undefined id ->
        print_string ("[Error] Variable " ^ id ^ " is undefined!\n")
  done
