Mercado Bitcoin OCaml API
=========================

A type safe OCaml library to interact with the [Mercado Bitcoin Trading API v3](https://www.mercadobitcoin.com.br/trade-api/)

Installation
------------

This library requires OCaml 4.04

```
opam switch 4.04.2
```

Install the dependencies with
```
make opam
```

Usage
-----

Currently you can build the library `_build/mercado_bitcoin_api.{cma,cmxa}` with

```
make all
```

You can also play with it it in the OCaml REPL:

```
$ make utop

utop> #load  "mercado_bitcoin_api.cma";;

utop> Mercado_bitcoin.create_handler
        ~tapi_id:<redacted>
        ~tapi_secret:<redacted>
        ~coin_pair:"BRLBTC"
      |> Mercado_bitcoin.list_orderbook;;

- : (Mercado_bitcoin_j.orderbook, Mercado_bitcoin.mb_error) Result.t =
Core.Result.Ok
 {Mercado_bitcoin_j.orderbook =
   {Mercado_bitcoin_j.bids =
     [{Mercado_bitcoin_j.order_id = 42718166; quantity = 0.00637152;
       limit_price = 15800.; is_owner = false};
      {Mercado_bitcoin_j.order_id = 42718203; quantity = 0.08124671;
       limit_price = 15781.00003; is_owner = false};
      ... ]
    asks =
     [{Mercado_bitcoin_j.order_id = 42718164; quantity = 0.06368677;
       limit_price = 15879.89999; is_owner = false};
      {Mercado_bitcoin_j.order_id = 42718155; quantity = 0.02524;
       limit_price = 15879.9; is_owner = false};
      ...]
```

Development
-----------
For the list of remaining things to do in this library, check out [TODO.md](TODO.md)

Disclaimer
---------
This library was developed for experimental purposes. Use it at your own risk.
