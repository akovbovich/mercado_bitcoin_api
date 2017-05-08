type t

val create_handler: tapi_id:string -> tapi_secret:string -> pair:string -> t

val list_system_messages: ?level:string -> t -> Mercado_bitcoin_t.system_messages_response Lwt.t

