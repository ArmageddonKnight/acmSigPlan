all: main.pdf

%.pdf: %.tex bibliography.bib acmart.cls ACM-Reference-Format.bst \
$(wildcard ./sections/*.tex) $(wildcard ./code-blocks/*) $(wildcard ./images/*.pdf) \
$(subst  .gv,.pdf,$(wildcard ./graphs/*.gv)) \
$(subst .dot,.pdf,$(wildcard ./graphs/*.dot))
	pdflatex -synctex=1 -interaction=nonstopmode $<
	bibtex $*.aux
	pdflatex -synctex=1 -interaction=nonstopmode $<
	pdflatex -synctex=1 -interaction=nonstopmode $<  

./graphs/%.pdf: ./graphs/%.gv
	dot -Tpdf $< -o $@

./graphs/%.pdf: ./graphs/%.dot
	dot2tex -tmath --autosize --crop --format tikz $< > ./graphs/$*.tex
	pdflatex -synctex=1 -interaction=nonstopmode \
		-output-directory ./graphs ./graphs/$*.tex

.PHONY: clean
clean:
	find . \( -name "*.aux" -o -name "*.bbl" -o -name "*.blg" -o \
	          -name "*.log" -o -name "*.out" -o -name "*.synctex.gz" \) -o \
	       \( -name "*.pdf" -a -not -path "./images/*" \) | xargs $(RM)
	$(RM) ./graphs/*.tex

.PHONY: style-upgrade
style-upgrade:
	@cd acmart; git checkout master; make clean; make acmart.cls
	@cp acmart/acmart.cls \
	    acmart/ACM-Reference-Format.bst .
