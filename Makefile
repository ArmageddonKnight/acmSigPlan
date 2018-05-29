all: main.pdf

BIBTEX_FILEs := $(wildcard *.bib)
GRAPHs := $(wildcard ./graphs/*)
CODE_BLOCKs := $(wildcard ./code_blocks/*)

%.pdf: %.tex $(BIBTEX_FILEs) $(GRAPHs) $(CODE_BLOCKs)
ifneq ($(BIBTEX_FILEs),)
	pdflatex -synctex=1 -interaction=nonstopmode $<
	bibtex $*.aux
endif
	pdflatex -synctex=1 -interaction=nonstopmode $<
	pdflatex -synctex=1 -interaction=nonstopmode $<

.PHONY: clean
clean:
	find . \( -name "*.aux" -o -name "*.bbl" -o -name "*.blg" -o \
	          -name "*.log" -o -name "*.out" -o -name "*.synctex.gz" \) -o \
	       \( -name "*.pdf" -a -not -path "./graphs/*" -a -not -path "./acmart/*" \) | xargs $(RM)

.PHONY: style-upgrade
style-upgrade:
	git submodule update --init
	cd acmart && git checkout master && git pull && make acmart.cls && \
		cp acmart.cls ACM-Reference-Format.bst ..
