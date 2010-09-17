#!/usr/bin/make -f

##################################################################
# General settings
#
# INPUT - Main including file without .xml suffix
# OUTPUT - Generated document minus target suffix
# DEST - Destination for (non-chunked) transformations
# CHUNKDIR - Destination for chunked HTML transformations
# OUTPUT - "Path/Name" of generated (non-chunked) documents.
##################################################################
INPUT = index
OUTPUT = index
DEST = .
CHUNKDIR = html
OUTFILE = $(DEST)/$(OUTPUT)

##################################################################
# Stylesheet configuration
#
# Uncomment the proper stylesheet directory for your machine
#
# STYLEDIR - Directory holding xsl-ns stylesheet distribution
# HTML_xsl - Stylesheet for HTML transformations
# HTML_CHUNKED_xsl - Stylesheet for Chunked HTML transformations
##################################################################
# Fedora - Package: docbook5-style-xsl
STYLEDIR = /usr/share/sgml/docbook/xsl-ns-stylesheets/

# Ubuntu - Package: docbook-xsl-ns
# STYLEDIR = /usr/share/xml/docbook/stylesheet/docbook-xsl-ns/

# OS X - Package (Macports): docbook-xsl
# STYLEDIR = /opt/local/share/xsl/docbook-xsl

HTML_xsl = $(STYLEDIR)/html/docbook.xsl
HTML_CHUNKED_xsl = $(STYLEDIR)/html/chunk.xsl

##################################################################
# Options for transformations
#
# XSLTPARAMS - Options applicable to single/chunked output
# XSLT_HTML_PARAMS - Options specific to sigle HTML output
# DBLATEX_PARAMS - Options specific to dblatex PDF output
##################################################################
XSLTPARAMS = --xinclude \
	--stringparam section.autolabel 1

XSLT_HTML_PARAMS = -o $(OUTFILE).html

XSLT_CHUNKED_PARAMS = --stringparam base.dir $(CHUNKDIR)/

DBLATEX_PARAMS = -o $(OUTFILE).pdf \
	-P latex.class.options=11pt \
	-P term.breakline=1

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
# DocBook5 Schema
#
# Uncomment the applicable path to your system
#
# SCHEMADIR - Directory holding the DocBook5 RNC/RNG DTDs
##################################################################
# Fedora - Package: docbook5-schemas
SCHEMADIR = /usr/share/xml/docbook5/schema/rng/5.0

# OS X - Package (MacPorts): docbook-xml-5.0
# SCHEMADIR = /opt/local/share/xml/docbook/5.0/rng

# Ubuntu - Package: docbook5-xml
# SCHEMADIR = /usr/share/xml/docbook/schema/rng/5.0

##################################################################
# Build targets
##################################################################
all: clean docs

docdir:
	mkdir -p $(DEST)
	mkdir -p $(CHUNKDIR)

chunked:
	xsltproc $(XSLTPARAMS) $(XSLT_CHUNKED_PARAMS) $(HTML_CHUNKED_xsl) $(INPUT).xml

html:
	xsltproc $(XSLTPARAMS) $(XSLT_HTML_PARAMS) $(HTML_xsl) $(INPUT).xml

pdf:
	dblatex $(DBLATEX_PARAMS) $(INPUT).xml

docs: docdir html pdf chunked

locator:
	sed "s'%SCHEMADIR%'$(SCHEMADIR)'" .schemas.xml > schemas.xml

clean:
	$(FIND)  \( -regex "^[.]?(.+)\~$$" -o -regex "./[.]?#.*#" \) -delete
	rm -fR output/*
