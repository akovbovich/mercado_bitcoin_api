Implementation
- Implement other API functions
  - [ ] `get_order
  - [ ] `place_buy_order`
  - [ ] `place_sell_order`
  - [ ] `cancel_order`
  - [ ] `get_withdrawal`
  - [ ] `withdraw_coin`

- Add more type safety
  - [ ] Change `list_system_messages`'s `level` to variant instead of string
  - [ ] Change `list_order` params to variants or `Time.t` when applicable

Build
- Add `make` targets to install `mercado_bitcoin_api.cm{x,xa}` to opam location, so it can be easily re-used in other projects
