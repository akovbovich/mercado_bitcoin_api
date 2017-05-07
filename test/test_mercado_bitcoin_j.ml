open Core.Std

let json_file_assert ~(file:string) ~transform ~expected =
  let json=In_channel.read_all file in
  assert ((transform json) = expected)

let (_test_message:unit) =
  json_file_assert
    ~file:"test/message_sample.json"
    ~transform:Mercado_bitcoin_j.system_message_of_string
    ~expected:
      {Mercado_bitcoin_j.msg_date = 1453827748
      ; level = "INFO"
      ; event_code = 7000
      ; msg_content = "Manutenção programada para 2015-DEZ-25, janela de até 2 horas, a partir das 14hs. O sistema estará indisponível durante esse período."}
;;
