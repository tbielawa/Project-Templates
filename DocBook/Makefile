#!/usr/bin/make -f

##################################################################
# Main including file
##################################################################
INDEX = Virtual-Disk-Operations

##################################################################
# Settings for HTML Transformations
##################################################################
XSLTPARAMS = --xinclude -o output/$(INDEX).html \
	 --stringparam  section.autolabel 1

# Uncomment the proper stylesheet for your distro
# Fedora - Package: docbook5-style-xsl
HTMLSTYLESHEET = /usr/share/sgml/docbook/xsl-ns-stylesheets/html/docbook.xsl
# Ubuntu - Package: docbook-xsl-ns
# HTMLSTYLESHEET = /usr/share/xml/docbook/stylesheet/docbook-xsl-ns/html/docbook.xsl

##################################################################
# Use the proper options for the target platform
##################################################################
OSTYPE := $(shell uname -s)
# OS X?
ifeq ("$(findstring Darwin, $(OSTYPE))", "Darwin")
	SED = sed -E
	FIND = find . -E
# Assume GNU
else
	SED = sed -r
	FIND = find . -regextype posix-extended
endif

##################################################################
# Build targets
##################################################################
all: clean docs

html:
	xsltproc $(XSLTPARAMS) $(HTMLSTYLESHEET) $(INDEX).xml

pdf:
	dblatex -o output/$(INDEX).pdf -P latex.class.options=11pt -P term.breakline=1 $(INDEX).xml

docs: html pdf

clean:
	$(FIND)  \( -regex "^[.]?(.+)\~$$" -o -regex "./[.]?#.*#" \) -delete
	rm -fR output/*
