open Ocamlbuild_plugin

let () =
  dispatch (function
      | Before_options ->
        Options.use_ocamlfind := true;
      | _ -> ())


let _ = Ocamlbuild_plugin.dispatch Ocamlbuild_atdgen.dispatcher
