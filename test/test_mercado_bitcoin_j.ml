open Core.Std

open Mercado_bitcoin_j

let json_file_assert ~(file:string) ~transform ~expected =
  let json=In_channel.read_all file in
  assert ((transform json) = expected)

let (_test_message:unit) =
  json_file_assert
    ~file:"test/message_sample.json"
    ~transform:system_message_of_string
    ~expected:
      {msg_date = 1453827748
      ; level = "INFO"
      ; event_code = 7000
      ; msg_content = "Manutenção programada para 2015-DEZ-25, janela de até 2 horas, a partir das 14hs. O sistema estará indisponível durante esse período."}
;;

let (_test_response_message:unit) =
  json_file_assert
    ~file:"test/response_message_sample.json"
    ~transform:system_messages_response_of_string
    ~expected:
      (let open Mercado_bitcoin_j in
       { response_data =
           { messages =
               [{msg_date = 1453827748
                ; level = "INFO"
                ; event_code = 7000
                ; msg_content = "Manutenção programada para 2015-DEZ-25, janela de até 2 horas, a partir das 14hs. O sistema estará indisponível durante esse período."
                }; {
                  msg_date=1453827748
                ; level = "INFO"
                ; event_code = 7002
                ; msg_content ="Novo filtro de datas disponível para o método *list_orders*. Veja mais detalhes em https://www.mercadobitcoin.com.br/trade-api/."}]}
       ; status_code = 100
       ; server_unix_timestamp = 1453827748
       ; error_message = None})
