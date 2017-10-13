let tapi_secret="1ebda7d457ece1330dff1c9e04cd62c4e02d1835968ff89d2fb2339f06f73028"
let tapi_method = "/tapi/v3/?tapi_method=list_orders&tapi_nonce=1"
let tapi_mac_result=
  "7f59ea8749ba596d5c23fa242a531746b918e5e61c9f6c8663a699736db503980f3a507ff7e2ef1336f7888d684a06c9a460d18290e7b738a61d03e25ffdeb76"

let () =
  Mercado_bitcoin_http.sign ~key:tapi_secret tapi_method
  |> (=) tapi_mac_result
  |> (fun x -> assert x)
