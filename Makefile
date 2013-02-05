
default: compiler/limlc

.PHONY: compiler/limlc

compiler/limlc: Makefile.config
	$(MAKE) -C compiler
	$(MAKE) -C stdlib
	cp compiler/limlc .

stdlib/libliml.lmli: compiler/limlc
	@echo "Compiling the standard library"
	$(MAKE) -C stdlib

clean: 
	rm -f *~
	$(MAKE) -C compiler clean
	$(MAKE) -C stdlib clean

Makefile.config: configure
	$(error run ./configure)
configure: configure.ac aclocal.m4
	autoconf
