PREFIX ?= $(HOME)/.local/bin
SCRIPT := src/aranea.awk

lint:
	awk --lint -f $(SCRIPT) <<< ""

test:
	./test.sh

install:
	chmod +x $(SCRIPT)
	cp $(SCRIPT) $(PREFIX)/aranea

uninstall:
	[ -f $(PREFIX)/aranea ] && rm $(PREFIX)/aranea

install-gawk:
	chmod +x $(SCRIPT)
	sed -e '1s/awk/gawk/' $(SCRIPT) > ./aranea
	mv ./aranea $(PREFIX)/aranea

.PHONY: lint test install uninstall
