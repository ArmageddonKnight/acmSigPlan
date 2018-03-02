all: main.pdf

%.pdf: %.tex bibliography.bib acmart.cls ACM-Reference-Format.bst \
$(wildcard ./sections/*.tex) $(wildcard ./code-blocks/*) \
$(wildcard ./graphs/*.pdf) $(subst .png,.pdf,$(wildcard ./graphs/*.png))
	pdflatex -synctex=1 -interaction=nonstopmode $<
	bibtex $*.aux
	pdflatex -synctex=1 -interaction=nonstopmode $<
	pdflatex -synctex=1 -interaction=nonstopmode $<  

$(subst .png,.pdf,$(wildcard ./graphs/*.png))
./graphs/%.pdf: ./graphs/%.png
	convert $< $@

.PHONY: clean
clean:
	find . \( -name "*.aux" -o -name "*.bbl" -o -name "*.blg" -o \
	          -name "*.log" -o -name "*.out" -o -name "*.synctex.gz" \) -o \
	       \( -name "*.pdf" -a -not -path "./graphs/*" \) | xargs $(RM)

.PHONY: style-upgrade
style-upgrade:
	@cd acmart; git checkout master; make clean; make acmart.cls
	@cp acmart/acmart.cls \
	    acmart/ACM-Reference-Format.bst .
