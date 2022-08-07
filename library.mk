# Usage:

# Define the following variables:
# - $(TARGET_DIR), $(TARGET_FLAGS)
# - $(LIBRARY_SRCS), $(LIBRARY_OBJS), $(LIBRARY_NAME)
# - $(PATHS)

# This make module assumes the following:
# Project Structure:
# - build
# - build/{debug, release}/lib
# - build/{debug, release}/_lib_deps


# Library compiler flags
LIB_CFLAGS = -fPIC
LIB_LDFLAGS = -shared

PREFIX_LIB = lib

# Library build settings
LIBRARY_DIR = $(TARGET_DIR)/$(PREFIX_LIB)
LIB_DEPS 		= $(TARGET_DIR)/_$(PREFIX_LIB)_deps
LIB_FLAGS 	= $(GLOBAL_CFLAGS) $(GLOBAL_LDFLAGS) $(TARGET_FLAGS) $(INCLUDES)
LIB_SRCS 		= $(addprefix $(PATHS)/, $(LIBRARY_SRCS))
LIB_OBJS 		= $(addprefix $(LIB_DEPS)/, $(LIBRARY_OBJS))
LIB 				= $(LIBRARY_DIR)/$(LIBRARY_NAME)

#
# Library builds
#

.PHONY: install-lib uninstall-lib lib clean-lib

# Install the library
install-lib: $(LIB) install-lib-headers
	install $(LIB) $(DESTDIR)$(PREFIX)/lib/$(LIBRARY_NAME)

uninstall-lib: release $(LIB) uninstall-lib-headers
	$(CLEANUP) $(DESTDIR)$(PREFIX)/lib/$(LIBRARY_NAME)

lib: subprojects $(LIBRARY_DIR) $(LIB_DEPS) $(LIB)

# Compile the shared library target
# Depend upon logc and the library object files and the subproject object files
$(LIB): $(LIB_OBJS) $(SP_DEPENDS)
	@echo "Linking library target"
	$(CC) $(LIB_LDFLAGS) $(LIB_FLAGS) $(SP_INCLUDES) -o $@ $^

# Compile all library object files
# Depends on the source files, headers and subproject object files
$(LIB_DEPS)/%.o: $(PATHS)/%.c $(PATHI)/%.h $(SP_DEPENDS)
	@echo "Compiling library target sources"
	$(CC) $(LIB_CFLAGS) -c $(LIB_FLAGS) $(SP_INCLUDES) -o $@ $<

# Depends on the source files, and subproject object files
$(LIB_DEPS)/%.o: $(PATHS)/%.c $(SP_DEPENDS)
	@echo "Compiling main library target source"
	$(CC) $(LIB_CFLAGS) -c $(LIB_FLAGS) $(SP_INCLUDES) -o $@ $<

$(LIBRARY_DIR):
	$(MKDIR) $(LIBRARY_DIR)

$(LIB_DEPS):
	$(MKDIR) $(LIB_DEPS)

# Remove output files for library
clean-lib: 
	@echo "Removing library build output"
	$(CLEANUP) $(PATHB)/debug/lib/$(LIBRARY_NAME) $(PATHB)/release/lib/$(LIBRARY_NAME)
	$(CLEANUP) $(PATHB)/debug/_$(PREFIX_LIB)_deps/*.o $(PATHB)/release/_$(PREFIX_LIB)_deps/*.o

CLEAN_TARGET += clean-lib
