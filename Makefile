all: main.pdf

main.pdf: main.tex main.aux $(wildcard ./sections/*.tex) \
$(wildcard ./code-blocks/*) $(wildcard ./images/*.pdf) \
$(subst  .gv,.pdf,$(wildcard ./graphs/*.gv)) \
$(subst .dot,.pdf,$(wildcard ./graphs/*.dot))
	pdflatex -synctex=1 -interaction=nonstopmode $<
	pdflatex -synctex=1 -interaction=nonstopmode $<

main.aux: main.tex bibliography.bib
	pdflatex -synctex=1 -interaction=nonstopmode $<
	bibtex $@

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
	@cd acmart; git checkout origin/master; make all
	@cp acmart/acmart.cls \
	    acmart/ACM-Reference-Format.bst .
