OCB_FLAGS = -use-ocamlfind -plugin-tag "package(ocamlbuild_atdgen)"

OCB = ocamlbuild $(OCB_FLAGS)

all: mercado_bitcoin_api.cma mercado_bitcoin_api.cmxa

clean:
	$(OCB) -clean

%.cma %.cmxa: %.mllib
	$(OCB) $@

mercado_bitcoin.cma mercado_bitcoin_api.cxma: *.ml *.mli *.atd

utop: mercado_bitcoin_api.cma
	utop -require core,nocrypto,cohttp.lwt,hex,yojson,atdgen -I _build/

test_%.native: test/test_%.ml
	$(OCB) test/$@

test: test_mercado_bitcoin_j.native test_mercado_bitcoin_http.native
	$(foreach t, $?, ./$(t);)

opam:
	opam install ocamlbuild-atdgen tls nocrypto cohttp hex yojson atdgen

.PHONY: opam test
