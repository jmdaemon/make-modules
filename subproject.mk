# File
.PHONY: $(SP_TARGET_NAME) clean-$(SP_TARGET_NAME)

# SP_LOGC_DIR: Outputs build dependencies to build/{debug,release}/depends/subproject_name
SP_BDIR 	 = $(TARGET_DIR)/depends/$(SP_NAME)
SP_BSRCS 	 = $(addprefix $(SP_SRCD)/, $(SP_SRCS))
SP_BOBJS 	 = $(addprefix $(SP_BDIR)/, $(SP_OBJS))
SP_BCFLAGS = $(SP_INCS)

# Add to subprojects
SP_SOURCES 	+= $(SP_BSRCS)
SP_DEPENDS 	+= $(SP_BOBJS)
SP_INCLUDES += $(SP_INCS)
SP_LIBS 		+= $(SP_SHARED)

# Create the directory, object files, dynamic & static libraries
$(SP_TARGET_NAME): $(SP_BDIR) $(SP_BOBJS) $(SP_SHARED) $(SP_STATIC)

# Compiles and builds build/depends/log.c/log.o, depends on subproject srcs and headers
$(SP_BOBJS): $(SP_BSRCS) $(SP_INCS:.h)
	@echo "Compiling $(SP_NAME) sources"
	$(CC) -c -fPIC $(TARGET_FLAGS) $(LOGC_FLAGS) -o $@ $^

# Links and creates dynamic library: build/depends/$(SP_NAME)/$(SP_SHARED)
$(SP_SHARED): $(SP_BOBJS)
	@echo "Creating $(SP_NAME) shared library"
	$(CC) -shared $(SP_INCS) -o $@ $^

# Links and creates static library: build/depends/$(SP_NAME)/$(SP_SHARED)
$(SP_STATIC): $(SP_BOBJS)
	@echo "Creating $(SP_NAME) static library"
	ar rcs $@ $^

# Make build directory
$(SP_BDIR):
	$(MKDIR) $(SP_BDIR)

# Create clean target
clean-$(SP_TARGET_NAME):
	@echo "Removing $(SP_NAME) build output"
	$(CLEANUP) $(SP_BOBJS)

# Add clean rule to master, subproject clean targets
CLEAN_TARGET 		+= clean-$(SP_TARGET_NAME)
CLEAN_SP_TARGET += clean-$(SP_TARGET_NAME)
