#!/usr/bin/make -f
#
#   Copyright information
#
#	Copyright (C) 2003-2011 Jari Aalto
#
#   License
#
#	This program is free software; you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation; either version 2 of the License, or
#	(at your option) any later version.
#
#	This program is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#	GNU General Public License for more details.
#
#	You should have received a copy of the GNU General Public License
#	along with this program. If not, see <http://www.gnu.org/licenses/>.

ifneq (,)
This makefile requires GNU Make.
endif

PACKAGE		= ripdoc
VERSION		=

DESTDIR		=
prefix		= /usr
exec_prefix	= $(prefix)
man_prefix	= $(prefix)/share
mandir		= $(man_prefix)/man
bindir		= $(exec_prefix)/bin
sharedir	= $(prefix)/share

BINDIR		= $(DESTDIR)$(bindir)
DOCDIR		= $(DESTDIR)$(sharedir)/doc
LOCALEDIR	= $(DESTDIR)$(sharedir)/locale
SHAREDIR	= $(DESTDIR)$(sharedir)/$(PACKAGE)
LIBDIR		= $(DESTDIR)$(prefix)/lib/$(PACKAGE)
SBINDIR		= $(DESTDIR)$(exec_prefix)/sbin
ETCDIR		= $(DESTDIR)/etc/$(PACKAGE)

# 1 = regular, 5 = conf, 6 = games, 8 = daemons
MANDIR		= $(DESTDIR)$(mandir)
MANDIR1		= $(MANDIR)/man1
MANDIR5		= $(MANDIR)/man5
MANDIR6		= $(MANDIR)/man6
MANDIR8		= $(MANDIR)/man8

INSTALL_OBJS_BIN   = $(PACKAGE)
INSTALL_OBJS_MAN1  = $(PACKAGE).1
INSTALL_OBJS_SHARE =
INSTALL_OBJS_ETC   =

INSTALL		= /usr/bin/install
INSTALL_BIN	= $(INSTALL) -m 755
INSTALL_DATA	= $(INSTALL) -m 644
INSTALL_SUID	= $(INSTALL) -m 4755

SRCS		= $(PACKAGE).c
OBJS		= $(SRCS:.c=.o)
EXE		= $(PACKAGE)

all:
	echo "Nothing to compile"

$(PACKAGE).1: $(PACKAGE).pl
	make -f pod2man.mk MANPOD=$(PACKAGE).pl PACKAGE=$(PACKAGE) makeman

man: $(PACKAGE).1

clean:
	# clean
	-rm -f *[#~] *.\#* *.1

distclean: clean

realclean: clean

install-etc:
	# install-etc
	$(INSTALL_BIN) -d $(ETCDIR)
	$(INSTALL_BIN) $(INSTALL_OBJS_ETC) $(ETCDIR)

install-man: $(PACKAGE).1
	# install-man
	$(INSTALL_BIN) -d $(MANDIR1)
	$(INSTALL_DATA) $(INSTALL_OBJS_MAN1) $(MANDIR1)

install-bin: all
	# install-bin
	$(INSTALL_BIN) -d $(BINDIR)
	$(INSTALL_BIN) -s $(INSTALL_OBJS_BIN) $(BINDIR)

install: install-bin install-man

.PHONY: clean distclean realclean install install-bin install-man

# End of file
