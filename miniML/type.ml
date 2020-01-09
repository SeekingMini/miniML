open Syntax

type t = TInt | TBool | TUnit | TBroken  (* 能够识别的类型 *)

let print_type t =
  match t with
  | TInt ->
      "Int"
  | TBool ->
      "Bool"
  | TUnit ->
      "Unit"
  | TBroken ->
      "broken type"

let print_type2 t = print_string (print_type t)

(* 类型检查 *)
let rec check1in t1 i1 o =
  let ty1 = type_check t1 in
  if ty1 == i1 then o else TBroken

and check2in t1 t2 i1 i2 o =
  let ty1, ty2 = (type_check t1, type_check t2) in
  if ty1 == i1 && ty2 == i2 then o else TBroken
(*  *)
and type_check t =
  match t with
  | Int i ->
      TInt
  | Bool b ->
      TBool
  | Add (t1, t2) ->
      check2in t1 t2 TInt TInt TInt
  | Sub (t1, t2) ->
      check2in t1 t2 TInt TInt TInt
  | Mul (t1, t2) ->
      check2in t1 t2 TInt TInt TInt
  | Div (t1, t2) ->
      check2in t1 t2 TInt TInt TInt
  | Let (id, t) ->
      TUnit
  | Var str ->
      TBroken
  | If (t1, t2, t3) ->
      let ty1, ty2, ty3 = (type_check t1, type_check t2, type_check t3) in
      if ty1 == TBool && ty2 == ty3 then ty2 else TBroken
  | Eq (t1, t2) ->
      check2in t1 t2 TInt TInt TBool
  | Neq (t1, t2) ->
      check2in t1 t2 TInt TInt TBool
  | Lt (t1, t2) ->
      check2in t1 t2 TInt TInt TBool
  | Le (t1, t2) ->
      check2in t1 t2 TInt TInt TBool
  | Or (t1, t2) ->
      check2in t1 t2 TBool TBool TBool
  | And (t1, t2) ->
      check2in t1 t2 TBool TBool TBool
  | Not t1 ->
      check1in t1 TBool TBool
