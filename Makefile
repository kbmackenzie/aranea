NAME   := aranea
SCRIPT := ./aranea.awk

lint:
	$(SCRIPT) --lint <<< ""

test:
	$(SCRIPT) $(wildcard test/*)

.PHONY: lint test
