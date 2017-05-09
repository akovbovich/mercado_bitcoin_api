open Core.Std
open Nocrypto

open Lwt
open Cohttp
open Cohttp_lwt_unix

module Header = Cohttp.Header
                  
let request_host = "https://www.mercadobitcoin.net"

let request_path = "/tapi/v3/"
                     
let sign ~key msg =
  let key = Cstruct.of_string key in
  let msg = Cstruct.of_string msg in
  Hash.SHA512.hmac ~key msg
  |> Hex.of_cstruct
  |> function
    `Hex str -> str

let calculate_tapi_mac ~tapi_secret body =
  let msg = (request_path ^ "?" ^ body) in
  sign ~key:tapi_secret msg

let nonce () =
  Time.now ()
  |> Time.to_epoch
  |> sprintf "%.0f"
  |> String.filter ~f:begin function
    | ',' | '.' -> false
    | _ -> true end

let request ~tapi_id ~tapi_secret ~mb_method ?(params=[]) () =
  let uri = Uri.of_string @@ request_host ^ request_path in

  let params = List.map ~f:(fun (a,b) -> (a,[b])) params in

  let body = Uri.encoded_of_query @@
      [ "tapi_nonce", [nonce ()]
      ; "tapi_method", [mb_method]]
      @ params in 

  let headers =
    let length = String.length body in
    Header.of_list
      [ "TAPI-ID", tapi_id
      ; "TAPI-MAC", calculate_tapi_mac ~tapi_secret body
      ; "Content-Type" , "application/x-www-form-urlencoded"
      ; "Content-length", Int.to_string (length)] in

  Client.post ~headers uri
    ~body:(Cohttp_lwt_body.of_string body)

module Test = struct
  let tapi_secret="1ebda7d457ece1330dff1c9e04cd62c4e02d1835968ff89d2fb2339f06f73028"
  let tapi_method = "/tapi/v3/?tapi_method=list_orders&tapi_nonce=1"
  let tapi_mac_result=
    "7f59ea8749ba596d5c23fa242a531746b918e5e61c9f6c8663a699736db503980f3a507ff7e2ef1336f7888d684a06c9a460d18290e7b738a61d03e25ffdeb76"
  let test () =
    sign ~key:tapi_secret tapi_method |>
    (=) tapi_mac_result
end
