OCB = ocamlbuild -use-ocamlfind -plugin-tag "package(ocamlbuild_atdgen)"

all: mercado_bitcoin_http.native mercado_bitcoin_http.byte

clean:
	$(OCB) -clean

%.native %.byte:
	$(OCB) $@

utop: mercado_bitcoin.byte mercado_bitcoin_t.cmo mercado_bitcoin_j.cmo
	utop -require core,nocrypto,cohttp.lwt,hex,yojson,atdgen -I _build/


test_mercado_bitcoin_j.native: mercado_bitcoin_j.cmx mercado_bitcoin_t.cmx
	$(OCB) test/$@

test: test_mercado_bitcoin_j.native
	./$<

.PHONY: all utop test
