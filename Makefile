all: main.pdf

main.pdf: main.tex GRAPHs \
$(wildcard ./sections/*.tex) $(wildcard ./code-blocks/*) $(wildcard ./images/*.pdf)
	pdflatex -synctex=1 -interaction=nonstopmode $<
	pdflatex -synctex=1 -interaction=nonstopmode $<

.PHONY: GRAPHs
GRAPHs:
	@cd graphs; make all

.PHONY: clean
clean:
	$(RM) *.aux *.bbl *.blg \
	      *.log *.out *.pdf \
	      *.synctex.gz
	@cd graphs; make clean

.PHONY: style-upgrade
style-upgrade:
	@cd acmart; git checkout master; make all
	@cp acmart/acmart.cls .
