open Core

type t

type mb_error = (int * string)

val create_handler: tapi_id:string -> tapi_secret:string -> coin_pair:string -> t

val list_system_messages:
  ?level:string
  -> t ->
  (Mercado_bitcoin_t.system_message_list, mb_error) Result.t Lwt.t

val get_account_info : t -> (Mercado_bitcoin_t.account_info, mb_error) Result.t Lwt.t

val list_orderbook: t -> (Mercado_bitcoin_j.orderbook, mb_error) Result.t Lwt.t

val list_orders: ?order_type:int
  -> ?status_list:string
  -> ?has_fills:bool
  -> ?from_id:int
  -> ?to_id:int
  -> ?from_timestamp: string
  -> ?to_timestamp: string
  -> t
  -> (Mercado_bitcoin_j.orders, mb_error) Result.t Lwt.t

