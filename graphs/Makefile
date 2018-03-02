all: $(subst .png,.pdf,$(wildcard *.png))

%.pdf: %.png
	convert $< $@
