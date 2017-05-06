

OCB_FLAGS = -use-ocamlfind -tag bin_annot -pkg core
OCB = ocamlbuild $(OCB_FLAGS)

OCB_PACKAGES =

clean:
	$(OCB) -clean

all: native byte

.DEFAULT: all

native:
	$(OCB) -tag thread -pkgs nocrypto,cohttp.lwt,hex mercado_bitcoin.native

byte:
	$(OCB) mercado_bitcoin.byte


mercado_bitcoin_t.mli, mercado_bitcoin_t.mli: mercado_bitcoin.atd
	atdgen -t $<

mercado_bitcoin_j.mli, mercado_bitcoin_j.mli: mercado_bitcoin.atd
	atdgen -j $<

_build/mercado_bitcoin_json.cma: mercado_bitcoin_t.mli mercado_bitcoin_t.ml mercado_bitcoin_j.mli mercado_bitcoin_j.ml
	ocamlfind ocamlc -a -o $@ -package atdgen $^

_build/mercado_bitcoin_json.cmx: mercado_bitcoin_t.mli mercado_bitcoin_t.ml mercado_bitcoin_j.mli mercado_bitcoin_j.ml
	ocamlfind ocamlopt -a -o $@ -package atdgen $^

utop: _build/mercado_bitcoin_json.cma
	utop -require nocrypto,cohttp,hex,yojson,atdgen _build/mercado_bitcoin_json.cma

test:
	echo "test"

.PHONY: all native byte utop test
