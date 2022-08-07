# Usage:

# Define the following variables:
# - $(TARGET_DIR), $(TARGET_FLAGS)
# - $(BINARY_SRCS), $(BINARY_OBJS), $(BINARY_NAME)
# - $(PATHS)

# This make module assumes the following:
# Project Structure:
# - build
# - build/{debug, release}/bin
# - build/{debug, release}/_bin_deps

PREFIX_BIN = bin

# Executable settings
BINARY_DIR 	= $(TARGET_DIR)/$(PREFIX_BIN)
EXE_DEPS 		= $(TARGET_DIR)/_$(PREFIX_BIN)_deps
EXE_FLAGS 	= $(GLOBAL_CFLAGS) $(GLOBAL_LDFLAGS) $(TARGET_FLAGS) $(INCLUDES)
EXE_SRCS 		= $(addprefix $(PATHS)/, $(BINARY_SRCS))
EXE_OBJS 		= $(addprefix $(EXE_DEPS)/, $(BINARY_OBJS))
EXE 				= $(BINARY_DIR)/$(BINARY_NAME)

#
# Binary builds
#

.PHONY: install-bin uninstall-bin bin clean-bin

# Install the binary
install-bin: release $(EXE)
	install $(EXE) $(DESTDIR)$(PREFIX)/bin/$(BINARY_NAME)

uninstall-bin: release $(EXE)
	$(CLEANUP) $(DESTDIR)$(PREFIX)/bin/$(BINARY_NAME)

bin: subprojects version $(BINARY_DIR) $(EXE_DEPS) $(EXE)

# Link the executable binary target
# Depend on our binary's object files and logc
#$(EXE): $(EXE_OBJS) $(SP_DEPENDS)
$(EXE): $(EXE_OBJS)
	@echo "Linking binary target"
	$(CC) $(SP_LIBS) $(EXE_FLAGS) $(SP_INCLUDES) -o $@ $^

# Compile all $(EXE_OBJS) object files
# Depend on the binary's source files and the headers
$(EXE_DEPS)/%.o: $(PATHS)/%.c $(PATHI)/%.h $(SP_DEPENDS)
	@echo "Compiling binary target sources"
	$(CC) -c $(EXE_FLAGS) $(SP_INCLUDES) -o $@ $<

# Depend on the binary's source files
$(EXE_DEPS)/%.o: $(PATHS)/%.c $(SP_DEPENDS)
	@echo "Compiling main binary target source"
	$(CC) -c $(EXE_FLAGS) $(SP_INCLUDES) -o $@ $<

$(BINARY_DIR):
	$(MKDIR) $(BINARY_DIR)

$(EXE_DEPS):
	$(MKDIR) $(EXE_DEPS)

# Remove output files for executables
clean-bin: 
	@echo "Removing binary build output"
	$(CLEANUP) $(PATHB)/debug/bin/$(BINARY_NAME) $(PATHB)/release/bin/$(BINARY_NAME)
	$(CLEANUP) $(PATHB)/debug/_$(PREFIX_BIN)_deps/*.o $(PATHB)/release/_$(PREFIX_BIN)_deps/*.o

CLEAN_TARGET += clean-bin
