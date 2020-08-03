all: main.pdf

%.pdf: %.tex
ifneq ($(wildcard *.bib),)
	pdflatex -synctex=1 -interaction=nonstopmode $<
	bibtex $*.aux
endif
	pdflatex -synctex=1 -interaction=nonstopmode $<
	pdflatex -synctex=1 -interaction=nonstopmode $<

.PHONY: clean upgrade
clean:
	find . -maxdepth 1 \
		\( -name "*.aux" -o -name "*.bbl" -o -name "*.blg" -o \
	           -name "*.log" -o -name "*.out" -o -name "*.pdf" -o \
		   -name "*.synctex.gz" \) | xargs $(RM)

upgrade:
	git submodule update --init
	cd acmart && git checkout master && git pull && make acmart.cls && \
		cp acmart.cls ACM-Reference-Format.bst ..
	curl http://ctan.mirror.rafal.ca/macros/latex/contrib/xurl/latex/xurl.sty -o xurl.sty
