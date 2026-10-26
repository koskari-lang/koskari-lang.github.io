# Makefile for koskari.org

PYTHON ?= $(shell which python3 python 2>/dev/null | head -n1)
PYTHON := $(PYTHON)

SITE_DIR := site
BUILD_DIR := build
OUT_DIR := $(BUILD_DIR)/html
VENV_DIR := .venv
VENV_PYTHON := $(VENV_DIR)/bin/python
PORT ?= 8000


define checkfor
	@if ! which $(1) >/dev/null 2>&1 ; then \
		echo "$(1) is required, but not available" 1>&2 ; \
		exit 1 ; \
	fi
endef


##@ Basic Targets

.DEFAULT_GOAL := help

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


##@ Site

$(VENV_DIR)/.installed: requirements.txt
	@$(call checkfor,$(PYTHON))
	@echo "Creating virtual environment in $(VENV_DIR)..."
	@$(PYTHON) -m venv $(VENV_DIR)
	@$(VENV_PYTHON) -m pip install --disable-pip-version-check -q -r requirements.txt
	@touch $@

venv: $(VENV_DIR)/.installed  ## Create the build virtual environment

site: $(VENV_DIR)/.installed  ## Build the site into build/html
	@echo "Building site..."
	@$(VENV_PYTHON) -B -m sphinx.cmd.build -W --keep-going -b html \
		-d $(BUILD_DIR)/doctrees $(SITE_DIR) $(OUT_DIR)

preview: site  ## Build the site and serve build/html for local preview
	@echo "Serving site at http://127.0.0.1:$(PORT)/ (Ctrl+C to stop)"
	@cd $(OUT_DIR) && $(abspath $(VENV_PYTHON)) -m http.server $(PORT)

clean:  ## Remove build output
	@rm -rf $(BUILD_DIR)

purge: clean  ## Remove build output and the virtual environment
	@rm -rf $(VENV_DIR)


.PHONY: \
	clean \
	help \
	preview \
	purge \
	site \
	venv


# The end.
