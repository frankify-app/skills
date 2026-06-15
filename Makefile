SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

.DEFAULT_GOAL := help

.PHONY: help ## Shows help for all PHONY targets with help text
help:
	@grep -E '^.PHONY:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| sed 's/^Makefile:.PHONY: //' \
	| awk ' \
		BEGIN {FS = " *?## "}; \
		{printf "\033[36m%-30s\033[0m %s\n", $$1, $$2} \
	' \
	;

.SECONDEXPANSION:

.PHONY: test ## Run all tests
test:
	bats --recursive tests/

.PHONY: lint ## Run all linters
lint:
	shellcheck $(shell find derived/ original/ -name '*.sh' -type f)
