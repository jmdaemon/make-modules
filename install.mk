# Set installation directory
ifeq ($(PREFIX),)
    PREFIX := /usr/local
endif

# Installs both debug and release candidate
# for a binary and library

USR_INCLUDE := $(DESTDIR)$(PREFIX)/include
USR_LIB 		:= $(DESTDIR)$(PREFIX)/lib

#
# Install / Uninstall
#

.PHONY: install uninstall

# Install both targets
install: install-bin install-lib

# Uninstall both targets
uninstall:  uninstall-bin uninstall-lib
