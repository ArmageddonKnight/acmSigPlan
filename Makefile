include include/build_clean_update.mk

.PHONY: update
update: update-include
	git submodule update --init
	cd acmart  && git checkout master && git pull && make acmart.cls && \
		cp acmart.cls ACM-Reference-Format.bst ..

