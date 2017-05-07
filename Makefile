OCB = ocamlbuild

all: mercado_bitcoin.native mercado_bitcoin.byte

clean:
	$(OCB) -clean
	rm mercado_bitcoin_*.ml*

%.native %.byte:
	$(OCB) $@

mercado_bitcoin_t.mli mercado_bitcoin_t.ml: mercado_bitcoin.atd
	atdgen -t $<

mercado_bitcoin_j.mli mercado_bitcoin_j.ml: mercado_bitcoin.atd
	atdgen -j $<

mercado_bitcoin_j.cmo: mercado_bitcoin_j.mli mercado_bitcoin_j.ml
	$(OCB) $@

mercado_bitcoin_t.cmo: mercado_bitcoin_t.mli mercado_bitcoin_t.ml
	$(OCB) $@

utop: mercado_bitcoin.byte mercado_bitcoin_t.cmo mercado_bitcoin_j.cmo
	utop -require core,nocrypto,cohttp.lwt,hex,yojson,atdgen -I _build/

test:
	echo "test"

.PHONY: all native byte utop test
