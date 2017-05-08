OCB = ocamlbuild

all: mercado_bitcoin_http.native mercado_bitcoin_http.byte

clean:
	$(OCB) -clean
	rm mercado_bitcoin_*.ml*

%.native %.byte:
	$(OCB) $@

mercado_bitcoin_t.mli mercado_bitcoin_t.ml: mercado_bitcoin.atd
	atdgen -t $<

mercado_bitcoin_j.mli mercado_bitcoin_j.ml: mercado_bitcoin.atd mercado_bitcoin_t.mli mercado_bitcoin_t.ml
	atdgen -j $<

mercado_bitcoin_j.cmo mercado_bitcoin_j.cmx: mercado_bitcoin_j.mli mercado_bitcoin_j.ml
	$(OCB) $@

mercado_bitcoin_t.cmo mercado_bitcoin_t.cmx: mercado_bitcoin_t.mli mercado_bitcoin_t.ml
	$(OCB) $@

atdgen: mercado_bitcoin_j.cmo mercado_bitcoin_j.cmx mercado_bitcoin_t.cmo mercado_bitcoin_t.cmx

utop: mercado_bitcoin.byte mercado_bitcoin_t.cmo mercado_bitcoin_j.cmo
	utop -require core,nocrypto,cohttp.lwt,hex,yojson,atdgen -I _build/


test_mercado_bitcoin_j.native: mercado_bitcoin_j.cmx mercado_bitcoin_t.cmx
	$(OCB) test/$@

test: test_mercado_bitcoin_j.native
	./$<

.PHONY: all utop test
