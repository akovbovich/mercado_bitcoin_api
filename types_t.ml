
module Coin = struct
  type t = float
  let make x = x
  let add x y = x +. y
end                

module Fiat = struct
  type t = float
  let make x = x
  let add x y = x +. y
end
