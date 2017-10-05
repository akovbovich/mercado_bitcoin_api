
Trader
request-orderbook
order-status
create-order
cancel-order
order-complete
update-pool
price


fee-percent

pool-interval

min-order-size
max-order-size

order-pool-fraction

initial-pool: currency, coin
min-price-decimals
price-shadow-interval

max retries

State:
pool
last-completed-bid
last-completed-ask
bid-order-status
ask-rder-status


Logic:
1) Pool server
   Get top first three bids and asks
   Update status for orders

2) Evaluate bid-order
   - Case no bid -> evaluate ask-order
   - Order completed: update pool, update last completed bid -> evaluate ask-order
   - Better bidder: cancel order -> evaluate ask-order
   - Second best bidder: check if bid order moved lower, remove order order -> evaluate ask-order
   - still got the best bid -> evaluate ask order

3) Evaluate ask-order
4) Eval orders: evaluate which new orders need to be dispatched and if price is still profitable
5) Evaluate logic to send new orders


Next steps:
- Parse different request from mercado bitcoin using atd
- Create order abstraction so that other exchange can be used
- Implement logic


Dependencies:
- opam install ocamlbuild-atdgen
- OCaml 4.04