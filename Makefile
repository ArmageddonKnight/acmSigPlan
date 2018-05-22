all: main.pdf

%.pdf: %.tex
	pdflatex -synctex=1 -interaction=nonstopmode $<
	@if [ -f bibliography.bib ]; then \
		bibtex $*.aux; \
		pdflatex -synctex=1 -interaction=nonstopmode $<; \
		pdflatex -synctex=1 -interaction=nonstopmode $<; \
	fi

.PHONY: clean
clean:
	find . \( -name "*.aux" -o -name "*.bbl" -o -name "*.blg" -o \
	          -name "*.log" -o -name "*.out" -o -name "*.synctex.gz" \) -o \
	       \( -name "*.pdf" -a -not -path "./graphs/*" -a -not -path "./acmart/*" \) | xargs $(RM)

.PHONY: style-upgrade
style-upgrade:
	@cd acmart; git checkout master && git pull; \
		make clean; make acmart.cls
	@cp acmart/acmart.cls \
	    acmart/ACM-Reference-Format.bst .
