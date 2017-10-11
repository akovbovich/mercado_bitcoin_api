(** 

This module contains type safe functions to interact with the
MercadoBitcoin API.

**)

open Core

type t
(** Represents the handler that interacts with the API *)
   
type mb_error = (int * string)
(** Error type returned by the API. It consists of an error code [int]
with its message [string] *)
              
val create_handler
  : tapi_id:string
  -> tapi_secret:string
  -> coin_pair:string
  -> t
(** [create_handler ~tapi_id ~tapi_secret ~coinpair] creates an API
handler using [tapi_id] and [tapi_secret] credentials to trade the
[coin_pair] *)
  
val list_system_messages
  : ?level:string
  -> t
  -> (Mercado_bitcoin_t.system_message_list, mb_error) Result.t Lwt.t
(** [list_system_messages ?level handler] request the system messages
for a specific log [level] using the api [handler]. [level] can be
'INFO', 'WARNING' or 'ERROR' *)

val get_account_info
  : t
  -> (Mercado_bitcoin_t.account_info, mb_error) Result.t Lwt.t
(** [get_account_info handler] gets the account info using [handler] *)

(** For the trade functions below, note that the key_pair is part of
the handler. This design decision is mainly for convenience: we don't
have to keep passing the currency pair over and over to the functions *)
  
val list_orderbook
  : t
  -> (Mercado_bitcoin_j.orderbook, mb_error) Result.t Lwt.t
(** [list_orderbook handler] lists the orderbook for the api
[handler] *)
  
val list_orders
  : ?order_type:int
  -> ?status_list:string
  -> ?has_fills:bool
  -> ?from_id:int
  -> ?to_id:int
  -> ?from_timestamp: string
  -> ?to_timestamp: string
  -> t
  -> (Mercado_bitcoin_j.orders, mb_error) Result.t Lwt.t
(** [list_orders ?order_type ?status_list ?has_fills ?from_id ?to_id
?from_timestamp ?to_timestamp handler] lists orders applying the 
different optional fields*)
