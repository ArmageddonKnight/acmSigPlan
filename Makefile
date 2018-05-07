all: main.pdf

%.pdf: %.tex bibliography.bib $(wildcard ./sections/*.tex) $(wildcard ./code-blocks/*) $(wildcard ./graphs/*.pdf)
	pdflatex -synctex=1 -interaction=nonstopmode $<
	bibtex $*.aux
	pdflatex -synctex=1 -interaction=nonstopmode $<
	pdflatex -synctex=1 -interaction=nonstopmode $<  

.PHONY: clean
clean:
	find . \( -name "*.aux" -o -name "*.bbl" -o -name "*.blg" -o \
	          -name "*.log" -o -name "*.out" -o -name "*.synctex.gz" \) -o \
	       \( -name "*.pdf" -a -not -path "./graphs/*" \) | xargs $(RM)

.PHONY: style-upgrade
style-upgrade:
	@cd acmart; git checkout master && git pull; \
		make clean; make acmart.cls
	@cp acmart/acmart.cls \
	    acmart/ACM-Reference-Format.bst \
	    acmart/sample-bibliography.bib .
	@mv sample-bibliography.bib bibliography.bib
