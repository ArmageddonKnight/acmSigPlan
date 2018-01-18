all: \
$(subst  gv,pdf,$(wildcard *.gv)) \
$(subst dot,pdf,$(wildcard *.dot))

%.pdf: %.gv
	dot -Tpdf $< -o $@

%.pdf: %.dot
	dot2tex -tmath --autosize --crop \
		--format tikz $< > $*.tex
	pdflatex -synctex=1 -interaction=nonstopmode $*.tex

.PHONY: clean
clean:
	$(RM) *.aux *.bbl *.blg \
	      *.log *.out *.pdf \
	      *.tex *.synctex.gz
