TEMPLATE := Acmart-Sigconf

all: main.pdf

%.pdf: %.tex
ifneq ($(wildcard *.bib),)
	pdflatex -synctex=1 -interaction=nonstopmode $<
	bibtex $*.aux
endif
	pdflatex -synctex=1 -interaction=nonstopmode $<
	pdflatex -synctex=1 -interaction=nonstopmode $<

.PHONY: clean
clean:
	find . -maxdepth 1 \
		\( -name "*.aux" -o -name "*.bbl" -o -name "*.blg" -o \
	           -name "*.log" -o -name "*.out" -o -name "*.pdf" -o \
		   -name "*.synctex.gz" \) | xargs $(RM)

.PHONY: template-update style-update

DOC_ROOT := $(shell pwd)
GIT_ROOT := $(shell git rev-parse --show-toplevel)

template-update:
	-git add -A && git commit -m "Checkpoint before template update [ci skip]." && git push
	 cd $(GIT_ROOT) && git subtree pull \
		--prefix=$(shell python -c "import os.path; print os.path.relpath('$(DOC_ROOT)', '$(GIT_ROOT)')") \
		https://github.com/ArmageddonKnight/$(TEMPLATE) master --squash

style-update:
	git submodule update --init
	cd acmart && git checkout master && git pull && make acmart.cls && \
		cp acmart.cls ACM-Reference-Format.bst ..
	wget http://ctan.mirror.rafal.ca/macros/latex/contrib/xurl/latex/xurl.sty
