all: $(subst .png,.pdf,*.png)

%.pdf: %.png
	convert $< $@