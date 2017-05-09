open Core.Std
open Lwt.Infix

module MBhttp = Mercado_bitcoin_http

type t =
  { handler : mb_method:Core.Std.String.t
      -> ?params:(string * Core.Std.String.t) list
      -> unit
      -> (Cohttp.Response.t * Cohttp_lwt_body.t) Lwt.t
  ; pair:string}

let create_handler ~tapi_id ~tapi_secret ~pair =
  { handler= Mercado_bitcoin_http.request ~tapi_id ~tapi_secret
  ; pair}


let param_of_option_list (l: (string * string option) list)
  : (string * string) list =
  List.bind l (fun (k, mv) ->
      match mv with
      | None -> []
      | Some v -> [k,v])

let request t ~mb_method ~params ~f=
  let params = param_of_option_list params in
  t.handler
    ~mb_method
    ~params
    () >>= fun (resp, body) ->
  (Cohttp_lwt_body.to_string body) >|= f

let list_system_messages ?level t =
  request t
    ~mb_method:"list_system_messages"
    ~params:["level",level]
    ~f:Mercado_bitcoin_j.system_messages_response_of_string
