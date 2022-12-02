.PHONY: format help
# Help system from https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.DEFAULT_GOAL := help
# Copyright (c) 2019-2022 Jahway603 & The Hush Developers
# Released under the GPLv3
#
# Hush Silentdragonlite-cli Makefile
PROJECT_NAME := "silentdragonlite-cli"

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

about: ## Display release info
	printf "Hush Silentdragonlite-cli Makefile by jahway603"

build: ## Build the release
	cargo build --release

clean: ## Clean the repo
	cargo clean
