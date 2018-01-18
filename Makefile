all: main.pdf

main.pdf: main.tex ACMSTY GRAPHs \
$(wildcard ./sections/*.tex) $(wildcard ./code-blocks/*) $(wildcard ./images/*.pdf)
	pdflatex -synctex=1 -interaction=nonstopmode $<
	pdflatex -synctex=1 -interaction=nonstopmode $<

.PHONY: ACMSTY
ACMSTY:
	@cd acmsty; make all

.PHONY: GRAPHs
GRAPHs:
	@cd graphs; make all

.PHONY: clean
clean:
	$(RM) *.aux *.bbl *.blg \
	      *.log *.out *.pdf \
	      *.synctex.gz
	@cd graphs; make clean

.PHONY: dist-clean
dist-clean: clean
	@cd acmsty; make clean

