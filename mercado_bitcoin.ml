open Core
open Lwt.Infix

module MBhttp = Mercado_bitcoin_http

type t =
  { handler : mb_method:Core.String.t
      -> ?params:(string * Core.String.t) list
      -> unit
      -> (Cohttp.Response.t * Cohttp_lwt_body.t) Lwt.t
  ; coin_pair:string}

type mb_error = (int * string)

let unwrap_error (response: 'a Mercado_bitcoin_t.response) : ('a, mb_error) Result.t =
  let open Mercado_bitcoin_t in
  match response.status_code, response.error_message with
  | 100, None -> Result.Ok (Option.value_exn response.response_data)
  | code, Some msg -> Result.Error (code, msg)
  | _, _ -> Result.Error (999, "Inconsistent response status")

let create_handler ~tapi_id ~tapi_secret ~coin_pair =
  { handler= Mercado_bitcoin_http.request ~tapi_id ~tapi_secret
  ; coin_pair}


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
  (Cohttp_lwt_body.to_string body) >|= Fn.compose unwrap_error f

let list_system_messages ?level t =
  request t
    ~mb_method:"list_system_messages"
    ~params:["level",level]
    ~f:Mercado_bitcoin_j.system_messages_response_of_string

let get_account_info t =
  request t
    ~mb_method:"get_account_info"
    ~params:[]
    ~f:Mercado_bitcoin_j.account_info_response_of_string

let list_orderbook t =
  request t
    ~mb_method:"list_orderbook"
    ~params:[ "coin_pair", Some t.coin_pair ]
    ~f:Mercado_bitcoin_j.orderbook_response_of_string

let list_orders
    ?order_type
    ?status_list
    ?has_fills
    ?from_id
    ?to_id
    ?from_timestamp
    ?to_timestamp
    t =
  request t
    ~mb_method:"list_orders"
    ~params:
      [ "coin_pair", Some t.coin_pair
      ; "order_type" , Option.map ~f:Int.to_string order_type
      ; "status_list" , status_list
      ; "has_fills" , Option.map ~f:Bool.to_string has_fills
      ; "from_id" , Option.map ~f:Int.to_string from_id
      ; "to_id" ,  Option.map ~f:Int.to_string to_id
      ; "from_timestamp" , from_timestamp
      ; "to_timestamp" ,  to_timestamp]
    ~f:Mercado_bitcoin_j.orders_response_of_string
