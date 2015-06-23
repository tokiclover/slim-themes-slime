PACKAGE     = slim-themes-slime
VERSION     = $(shell sed -nre '3s/(.*):/\1/p' ChangeLog)

PREFIX      = /usr/local
DATADIR     = $(PREFIX)/share
DOCDIR      = $(DATADIR)/doc
THEMEDIR    = $(DATADIR)/slim/themes/slime

INSTALL     = install
install_DATA   = $(INSTALL) -m 644
MKDIR_P     = mkdir -p

dist_EXTRA  = \
	AUTHORS \
	COPYING \
	README.md \
	ChangeLog
dist_THEME  = \
	mystic.png \
	texture_background.png \
	panel.png \
	slim.theme
DISTFILES   = $(dist_EXTRA) $(dist_THEME)
.SECONDEXPANSION:
DISTDIRS    = $(THEMEDIR) $(DOCDIR)/$(PACKAGE)-$(VERSION)

all:

install: install-dir install-doc install-theme
	ln -s texture_background.png $(DESTDIR)$(THEMEDIR)/background.png
install-dir :
	$(MKDIR_P) $(DISTDIRS:%=$(DESTDIR)%)
install-theme : install-dir
	$(install_DATA) $(dist_THEME) $(DESTDIR)/$(THEMEDIR)
install-doc: install-dir
	$(install_DATA) $(dist_EXTRA) $(DESTDIR)$(DOCDIR)/$(PACKAGE)-$(VERSION)

uninstall: uninstall-doc uninstall-theme
	rm $(DESTDIR)$(THEMEDIR)/background.png
	-rmdir $(DISTDIRS:%=$(DESTDIR)%)
uninstall-theme:
	rm -f $(dist_THEME:%=$(DESTDIR)$(THEMEDIR)/%)
uninstall-doc:
	rm -f $(dist_EXTRA:%=$(DESTDIR)$(DOCDIR)/$(PACKAGE)-$(VERSION)/%)

clean:

