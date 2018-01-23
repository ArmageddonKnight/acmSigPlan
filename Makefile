all: main.pdf

main.pdf: main.tex $(wildcard ./sections/*.tex) \
$(wildcard ./code-blocks/*) $(wildcard ./images/*.pdf) $(wildcard ./graphs/*.pdf)
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
	          -name "*.log" -o -name "*.out" -o -name "*.synctex.gz" \) | xargs $(RM)

.PHONY: style-upgrade
style-upgrade:
	@cd acmart; git checkout origin/master; make all
	@cp acmart/acmart.cls .
