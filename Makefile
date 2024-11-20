NAME   := aranea
SCRIPT := ./aranea.awk

lint:
	$(SCRIPT) --lint=no-ext <<< ""

test:
	$(SCRIPT) $(wildcard test/*)

.PHONY: lint test
