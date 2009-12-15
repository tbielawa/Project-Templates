#!/usr/bin/make -f

SHELL = /bin/sh
OSTYPE := $(shell /usr/bin/uname -s)

# OS X?
ifeq ("$(findstring Darwin, $(OSTYPE))", "Darwin")
	SED = sed -E
	FIND = find -E
# Assume GNU
else
	SED = sed -r
	FIND = find -regextype posix-extended
endif
