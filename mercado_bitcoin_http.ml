open Core
open Nocrypto

open Lwt
open Cohttp
open Cohttp_lwt_unix

module Header = Cohttp.Header
                  
let request_host = "https://www.mercadobitcoin.net"

let api_version = "v3"

let request_path = "/tapi/" ^ api_version ^ "/"
                     
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
  |> Time.to_span_since_epoch
  |> Time.Span.to_sec
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
