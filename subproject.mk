define subproject_template

.PHONY: $(SP_TARGET_NAME_$(1)) install-$(SP_TARGET_NAME_$(1))-headers uninstall-$(SP_TARGET_NAME_$(1))-headers clean-$(SP_TARGET_NAME_$(1))

# SP_LOGC_DIR: Outputs build dependencies to build/{debug,release}/depends/subproject_name
SP_BDIR_$(1) 	 	= $(TARGET_DIR)/depends/$(SP_NAME_$(1))
SP_BSRCS_$(1) 	= $(addprefix $(SP_SRCD_$(1))/, $(SP_SRCS_$(1)))
SP_BOBJS_$(1) 	= $(addprefix $$(SP_BDIR_$(1))/, $(SP_OBJS_$(1)))
SP_BCFLAGS_$(1) = $(SP_FLAGS_$(1)) $(SP_INCS_$(1))

#SP_LIB_NAME_$(1) = lib$(SP_TARGET_NAME_$(1))
#SP_LIBFLAGS_$(1) = -fPIC -Wl,soname,$(LIBRARY_NAME)
#SP_LIBFLAGS_$(1) = -fPIC -Wl,soname,$(SP_SHARED_$(1))
SP_LIBFLAGS_$(1) = -fPIC -Wl,-soname,lib$(SP_TARGET_NAME_$(1)).$(SHARED_LIBRARY_EXT)

# Subproject headers

ifneq ($(SP_HDRD_$(1)),)
SP_LIB_INCLUDES_$(1) = $(SP_HDRD_$(1))
SP_LIB_HDR_SRCS_$(1) = $(addprefix $(SP_HDRD_$(1))/, $(SP_HDRS_$(1)))
else
SP_LIB_INCLUDES_$(1) = $(PATHI)
SP_LIB_HDR_SRCS_$(1) = $(addprefix $(PATHI)/, $(SP_HDRS_$(1)))
endif

SP_LIB_HDR_OUTS_$(1) = $(addprefix $(USR_INCLUDE)/, $(SP_HDRS_$(1)))

# Add to subprojects
SP_SOURCES 	+= $$(SP_BSRCS_$(1))
SP_DEPENDS 	+= $$(SP_BOBJS_$(1))
SP_INCLUDES += $(SP_INCS_$(1))
SP_LIBS 		+= $(SP_SHARED_$(1))

# Add install/uninstall targets to master subproject installs/uninstalls
INSTALL_SP_TARGET += install-$(SP_TARGET_NAME_$(1))
UNINSTALL_SP_TARGET += uninstall-$(SP_TARGET_NAME_$(1))

# Create install targets

# Install the library
install-$(SP_TARGET_NAME_$(1)): $(SP_SHARED_$(1)) $(SP_STATIC_$(1)) install-$(SP_TARGET_NAME_$(1))-headers
	install $(SP_SHARED_$(1)) $$(USR_LIB)/lib$(SP_LIB_NAME_$(1)).so
	install $(SP_STATIC_$(1)) $$(USR_LIB)/lib$(SP_LIB_NAME_$(1)).a

uninstall-$(SP_TARGET_NAME_$(1)): $(SP_SHARED_$(1)) $(SP_STATIC_$(1)) uninstall-$(SP_TARGET_NAME_$(1))-headers
	$$(CLEANUP) $$(USR_LIB)/lib$(SP_LIB_NAME_$(1)).so
	$$(CLEANUP) $$(USR_LIB)/lib$(SP_LIB_NAME_$(1)).a

# Install the library headers
install-$(SP_TARGET_NAME_$(1))-headers: $$(SP_LIB_HDR_OUTS_$(1))

$(USR_INCLUDE)/%.h: $$(SP_LIB_INCLUDES_$(1))/%.h
	install $$^ $$@

uninstall-$(SP_TARGET_NAME_$(1))-headers: $$(SP_LIB_HDR_OUTS_$(1))
	$$(CLEANUP) $$^

# Create the directory, object files, dynamic & static libraries
$(SP_TARGET_NAME_$(1)): $$(SP_BDIR_$(1)) $$(SP_BOBJS_$(1)) $(SP_SHARED_$(1)) $(SP_STATIC_$(1))

# Compiles and builds build/depends/log.c/log.o, depends on subproject srcs and headers
$$(SP_BDIR_$(1))/%.o: $(SP_SRCD_$(1))/%.c $(SP_INCS_$(1))/%.h
	@echo "Compiling $(SP_NAME_$(1)) sources"
	$$(CC) -c $$(SP_LIBFLAGS_$(1)) $(TARGET_FLAGS) $$(SP_BCFLAGS_$(1)) -o $$@ $$^

# Compiles and builds build/depends/log.c/log.o, depends on subproject srcs
$$(SP_BDIR_$(1))/%.o: $(SP_SRCD_$(1))/%.c
	@echo "Compiling $(SP_NAME_$(1)) sources"
	$$(CC) -c $$(SP_LIBFLAGS_$(1)) $(TARGET_FLAGS) $$(SP_BCFLAGS_$(1)) -o $$@ $$^

# Links and creates dynamic library: build/depends/$$(SP_NAME_$(1))/$$(SP_SHARED_$(1))
$(SP_SHARED_$(1)): $$(SP_BOBJS_$(1))
	@echo "Creating $(SP_NAME_$(1)) shared library"
	$$(CC) -shared $(SP_INCS_$(1)) -o $$@ $$^

# Links and creates static library: build/depends/$$(SP_NAME_$(1))/$$(SP_SHARED_$(1))
$(SP_STATIC_$(1)): $$(SP_BOBJS_$(1))
	@echo "Creating $(SP_NAME_$(1)) static library"
	ar rcs $$@ $$^

# Make build directory
$$(SP_BDIR_$(1)):
	$$(MKDIR) $$(SP_BDIR_$(1))

# Create clean target
clean-$(SP_TARGET_NAME_$(1)):
	@echo "Removing $(SP_NAME_$(1)) build output"
	$(CLEANUP) $$(SP_BOBJS_$(1))
	$(CLEANUP) $(SP_SHARED_$(1))
	$(CLEANUP) $(SP_STATIC_$(1))

# Add clean rule to master, subproject clean targets
CLEAN_TARGET 		+= clean-$(SP_TARGET_NAME_$(1))
CLEAN_SP_TARGET += clean-$(SP_TARGET_NAME_$(1))

endef
