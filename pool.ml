open Core.Std
open Types_t

type t = { coin : Coin.t
         ; fiat: Fiat.t}

let (+) x y =
  { coin = Coin.add x.coin y.coin
  ; fiat = Fiat.add x.fiat y.fiat}

let add_coin x amount =
  { x with coin = Coin.add x.coin amount}
  
let add_fiat x amount =
  { x with fiat = Fiat.add x.fiat amount}
