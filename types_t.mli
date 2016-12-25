module Coin :
  sig
    type t
    val make : t -> t
    val add : t -> t -> t
    val mult : t -> float -> t
  end

module Fiat :
  sig
    type t
    val make : t -> t
    val add : t -> t -> t
    val mult : t -> float -> t            
  end
