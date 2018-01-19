all: main.pdf

main.pdf: main.tex ACMART GRAPHs \
$(wildcard ./sections/*.tex) $(wildcard ./code-blocks/*) $(wildcard ./images/*.pdf)
	pdflatex -synctex=1 -interaction=nonstopmode $<
	pdflatex -synctex=1 -interaction=nonstopmode $<

.PHONY: ACMART
ACMART:
	@cd acmart; make all
	@cp acmart/acmart.cls .

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
	$(RM) acmart.cls
	@cd acmart; make clean

