NAME   := aranea
SCRIPT := src/aranea.awk
PREFIX ?= $(HOME)/.local/bin

lint:
	awk --lint -f $(SCRIPT) <<< ""

test:
	./test.sh || true

install:
	chmod +x $(SCRIPT)
	cp $(SCRIPT) $(PREFIX)/$(NAME)

uninstall:
	[ -f $(PREFIX)/$(NAME) ] && rm $(PREFIX)/$(NAME)

install-gawk:
	chmod +x $(SCRIPT)
	sed -e '1s/awk/gawk/' $(SCRIPT) > ./$(NAME)
	mv ./$(NAME) $(PREFIX)/$(NAME)

.PHONY: lint test install uninstall
