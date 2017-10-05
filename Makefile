OCB = ocamlbuild -use-ocamlfind -plugin-tag "package(ocamlbuild_atdgen)"

all: mercado_bitcoin.native mercado_bitcoin.byte test_mercado_bitcoin_j.native

clean:
	$(OCB) -clean

%.native %.byte %.cma %.cmx %.cmo: %.ml %.mli
	$(OCB) $@

utop: mercado_bitcoin.cmo
	utop -require core,nocrypto,cohttp.lwt,hex,yojson,atdgen -I _build/

test_mercado_bitcoin_j.native:
	$(OCB) test/$@

test: test_mercado_bitcoin_j.native
	./$<

.PHONY: all utop test
