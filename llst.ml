open Utils

type id = Ident.t
type label = Ident.t
type pstring = string

type program = module_ list

and module_ = {
    md_id: id ;
    md_decls: decl list ;
    md_defs: def list ;
  }

and decl = 
  | Dtype of id * type_expr
  | Dval of id * type_expr

and type_expr =
  | Tany
  | Tprim of type_prim
  | Tid of id
  | Tfun of type_expr_list * type_expr_list
  | Tstruct of type_expr list
  | Tptr of type_expr

and type_expr_list = type_expr list

and type_prim = Nast.type_prim =
  | Tunit
  | Tbool
  | Tchar
  | Tint32
  | Tfloat
  | Tstring

and ty_id = type_expr * id
and ty_idl = ty_id list

and def = {
    df_id: id ;
    df_args: ty_id list ;
    df_body: block list ;
    df_ret: type_expr list ;
  }

and block = {
    bl_id: label ;
    bl_phi: phi list ;
    bl_eqs: equation list ;
    bl_ret: ret ;
  }

and ret =   
  | Return of ty_idl
  | Jump of label
  | If of ty_id * label * label
  | Switch of ty_id * (value * label) list * label

and phi = id * type_expr * (id * label) list

and equation = ty_idl * expr

and expr = 
  | Enull
  | Eid of id
  | Evalue of value
  | Ebinop of Ast.bop * ty_id * ty_id
  | Euop of Ast.uop * ty_id
  | Efield of ty_id * int
  | Eapply of id * ty_idl
  | Etuple of ty_id option * (int * ty_id) list
  | Egettag of ty_id
  | Egetargs of ty_id
  | Ecast of ty_id
  | Eproj of ty_id * int
  | Eptr_of_int of Ident.t
  | Eint_of_ptr of Ident.t
  | Eis_null of ty_id

and value =
  | Eunit
  | Ebool of bool
  | Eint of pstring
  | Efloat of pstring
  | Echar of pstring
  | Estring of pstring
  | Eiint of int
