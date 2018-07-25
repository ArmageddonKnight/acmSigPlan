include include/build_clean_update.mk

.PHONY: style-update template-update
style-update: pull-include
	git submodule update --init
	cd acmart && git checkout master && git pull && make acmart.cls && \
		cp acmart.cls ACM-Reference-Format.bst ..

DOC_ROOT := $(shell pwd)
GIT_ROOT := $(shell git rev-parse --show-topleve)

template-update:
	git add -A && git commit -m "Checkpoint before template upgrade." && git push
	cd $(DOC_ROOT) && git subtree pull \
		--prefix=$(python -c "import os.path; print os.path.relpath('$(GIT_ROOT)', '$(DOC_ROOT)')") \
		https://github.com/ArmageddonKnight/Acmart-Sigconf master
