PREFIX ?= $(HOME)/.local/bin
SCRIPT := aranea.awk

lint:
	./$(SCRIPT) --lint <<< ""

test:
	./$(SCRIPT) $(wildcard test/*)

install:
	mkdir -p $(PREFIX)
	cp ./$(SCRIPT) $(PREFIX)

uninstall:
	rm $(PREFIX)/$(SCRIPT)

.PHONY: lint test install uninstall
