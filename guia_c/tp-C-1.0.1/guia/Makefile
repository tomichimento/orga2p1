
MAKEFLAGS += --no-print-directory

all: avanzada basica

basica:
	$(MAKE) -C basica

avanzada:
	$(MAKE) -C avanzada

clean:
	$(MAKE) -C basica clean
	$(MAKE) -C avanzada clean

.PHONY: all avanzada basica clean