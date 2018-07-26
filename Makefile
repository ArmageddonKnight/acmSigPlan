include include/build_clean_update.mk

.PHONY: style-update
style-update: pull-include
	git submodule update --init
	cd acmart && git checkout master && git pull && make acmart.cls && \
		cp acmart.cls ACM-Reference-Format.bst ..
