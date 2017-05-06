OCB_FLAGS = -use-ocamlfind -tag bin_annot -pkg core

OCB = ocamlbuild $(OCB_FLAGS)

OCB_PACKAGES = nocrypto,cohttp.lwt,hex,yojson,atdgen

OCB_TAGS = thread

all: mercado_bitcoin.native mercado_bitcoin.byte

clean:
	$(OCB) -clean
	rm mercado_bitcoin_*.ml*

%.native %.byte:
	$(OCB) -tag $(OCB_TAGS) -pkgs $(OCB_PACKAGES) $@

mercado_bitcoin_t.mli mercado_bitcoin_t.ml: mercado_bitcoin.atd
	atdgen -t $<

mercado_bitcoin_j.mli mercado_bitcoin_j.ml: mercado_bitcoin.atd
	atdgen -j $<

%.cmo: %.mli %.mli
	$(OCB) -tag $(OCB_TAGS) -pkgs $(OCB_PACKAGES) $@

# _build/%.cmx
# _build/mercado_bitcoin_json.cma: mercado_bitcoin_t.mli mercado_bitcoin_t.ml mercado_bitcoin_j.mli mercado_bitcoin_j.ml
# 	ocamlfind ocamlc -a -o $@ -package atdgen $^

# _build/mercado_bitcoin_json.cmx: mercado_bitcoin_t.mli mercado_bitcoin_t.ml mercado_bitcoin_j.mli mercado_bitcoin_j.ml
# 	ocamlfind ocamlopt -a -o $@ -package atdgen $^

utop: mercado_bitcoin.byte mercado_bitcoin_t.cmo mercado_bitcoin_j.cmo
	utop -require core,nocrypto,cohttp.lwt,hex,yojson,atdgen -I _build/

test:
	echo "test"

.PHONY: all native byte utop test
