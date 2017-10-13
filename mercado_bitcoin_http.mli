(** Module with the low-level functions that interact with the Mercado
    Bitcoin API.  This module should not be used, use Mercado_bitcoin
    instead *)

val api_version: string
(** The api_version supported by this library *)
  
val request
  : tapi_id:string
  -> tapi_secret:string
  -> mb_method:string
  -> ?params:(string * string) list
  -> unit
  -> (Cohttp.Response.t * Cohttp_lwt_body.t) Lwt.t
(** [request ~tapi_id ~tapi_secret ~mb_method ?params ()] issues an
HTTP request for the API [method] signing it with the [tapi_id] and
[tapi_secred] credentials. Optionally takes a list with the [params]
used by the [method] *)


(** exposed for testing: *)
val sign
    : key:string
      -> string
      -> string
