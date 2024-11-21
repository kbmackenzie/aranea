PREFIX ?= $(HOME)/.local/bin
SCRIPT := aranea.awk

lint:
	awk --lint -f $(SCRIPT) <<< ""

test:
	./test.sh

install:
	chmod +x $(SCRIPT)
	cp $(SCRIPT) $(PREFIX)/aranea

uninstall:
	[ -f $(PREFIX)/aranea ] && rm $(PREFIX)/aranea

.PHONY: lint test install uninstall
