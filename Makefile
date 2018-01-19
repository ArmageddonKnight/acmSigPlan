all: main.pdf

main.pdf: main.tex main.aux GRAPHs \
$(wildcard ./sections/*.tex) $(wildcard ./code-blocks/*) $(wildcard ./images/*.pdf)
	pdflatex -synctex=1 -interaction=nonstopmode $<
	pdflatex -synctex=1 -interaction=nonstopmode $<

main.aux: main.tex bibliography.bib
	pdflatex -synctex=1 -interaction=nonstopmode $<
	bibtex $@

.PHONY: GRAPHs
GRAPHs:
	@cd graphs; make all

.PHONY: clean
clean:
	$(RM) *.aux *.bbl *.blg \
	      *.log *.out *.pdf \
	      *.synctex.gz
	@cd graphs; make clean

.PHONY: dist-upgrade
dist-upgrade:
	@cd acmart; make all
	@cp acmart/acmart.cls \
	    acmart/ACM-Reference-Format.bst .

