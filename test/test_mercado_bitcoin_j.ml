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
      ; level = Info
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
           Some { messages =
                    [{msg_date = 1453827748
                     ; level = Info
                     ; event_code = 7000
                     ; msg_content = "Manutenção programada para 2015-DEZ-25, janela de até 2 horas, a partir das 14hs. O sistema estará indisponível durante esse período."
                     }; {
                       msg_date=1453827748
                     ; level = Info
                     ; event_code = 7002
                     ; msg_content ="Novo filtro de datas disponível para o método *list_orders*. Veja mais detalhes em https://www.mercadobitcoin.com.br/trade-api/."}]}
       ; status_code = 100
       ; server_unix_timestamp = 1453827748
       ; error_message = None})


let (_test_order:unit) =
  json_file_assert
    ~file:"test/order_sample.json"
    ~transform:order_r_of_string
    ~expected:
      { order = {
            order_id = 3
          ; coin_pair = "BRLBTC"
          ; order_type = 2
          ; status = 4
          ; has_fills = true
          ; quantity = 1.00000000
          ; limit_price = 900.00000
          ; executed_quantity = 1.00000000
          ; executed_price_avg = 900.00000
          ; fee = 6.30000000
          ; created_timestamp = 1453835329
          ; updated_timestamp = 1453835329
          ; operations = [
              {
                operation_id = 1
              ; quantity = 1.00000000
              ; price = 900.00000
              ; fee_rate = 0.70
              ; executed_timestamp = 1453835329
              }
            ]
          }
      }

let (_test_orders:unit) =
  json_file_assert
    ~file:"test/orders_sample.json"
    ~transform:orders_of_string
    ~expected:
      { orders = [
            {
              order_id = 1
            ; coin_pair = "BRLBTC"
            ; order_type = 1
            ; status = 2
            ; has_fills = false
            ; quantity = 1.00000000
            ; limit_price = 1000.00000
            ; executed_quantity = 0.00000000
            ; executed_price_avg = 0.00000
            ; fee = 0.00000000
            ; created_timestamp = 1453838494
            ; updated_timestamp = 1453838494
            ; operations = []
            }; {
              order_id = 2
            ; coin_pair = "BRLBTC"
            ; order_type = 2
            ; status = 2
            ; has_fills = false
            ; quantity = 1.00000000
            ; limit_price = 1100.00000
            ; executed_quantity = 0.00000000
            ; executed_price_avg = 0.00000
            ; fee = 0.00000000
            ; created_timestamp = 1453838494
            ; updated_timestamp = 1453838494
            ; operations = []
          } ; {
              order_id = 3
            ; coin_pair = "BRLBTC"
            ; order_type = 2
            ; status = 4
            ; has_fills = true
            ; quantity = 1.00000000
            ; limit_price = 900.00000
            ; executed_quantity = 1.00000000
            ; executed_price_avg = 900.00000
            ; fee = 6.30000000
            ; created_timestamp = 1453838494
            ; updated_timestamp = 1453838494
            ; operations = [
              {
                operation_id = 1
              ; quantity = 1.00000000
              ; price = 900.00000
              ; fee_rate = 0.70
              ; executed_timestamp = 1453838494
              }
              ]
            } ; {
              order_id = 4
            ; coin_pair = "BRLBTC"
            ; order_type = 1
            ; status = 2
            ; has_fills = true
            ; quantity = 2.00000000
            ; limit_price = 900.00000
            ; executed_quantity = 1.00000000
            ; executed_price_avg = 900.00000
            ; fee = 0.00300000
            ; created_timestamp = 1453838494
            ; updated_timestamp = 1453838494
            ; operations = [
                {
                  operation_id = 1
                ; quantity = 1.00000000
                ; price = 900.00000
                ; fee_rate = 0.30
                ; executed_timestamp = 1453838494
                }
              ]
            }
          ]
      }
