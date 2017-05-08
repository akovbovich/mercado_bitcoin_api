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

let list_system_messages ?level t =
  let params = Option.map level ~f:(fun l -> ["level",l]) in 
  t.handler
    ~mb_method:"list_system_messages"
    ?params
    () >>= fun (resp, body) ->
  (Cohttp_lwt_body.to_string body) >|=
  Mercado_bitcoin_j.system_messages_response_of_string
