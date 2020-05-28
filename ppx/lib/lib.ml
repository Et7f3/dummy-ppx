open Migrate_parsetree

open Ast_410

let mapper _config _cookies =
  let open Ast_mapper in
  let open Ast_helper in
  let expr mapper pexp =
    match pexp.Parsetree.pexp_desc with
    | Parsetree.Pexp_extension ({txt = "dummy_ppx"; loc=_}, PStr []) -> Exp.constant (Pconst_integer ("42", None))
    | _ -> default_mapper.expr mapper pexp
  in
  {default_mapper with expr}

let () =
  Migrate_parsetree.Driver.register
    ~name:"bisect_ppx" ~args:[]
    Migrate_parsetree.Versions.ocaml_410 mapper
