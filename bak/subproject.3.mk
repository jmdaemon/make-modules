#.SECONDEXPANSION:
.PHONY: $(SP_TARGET_NAME) clean-$(SP_TARGET_NAME)

# SP_LOGC_DIR: Outputs build dependencies to build/{debug,release}/depends/subproject_name
SP_$(SP_TARGET_NAME)_BDIR 	 = $(TARGET_DIR)/depends/$(SP_NAME)
SP_$(SP_TARGET_NAME)_BSRCS 	 = $(addprefix $(SP_SRCD)/, $(SP_SRCS))
SP_$(SP_TARGET_NAME)_BOBJS 	 = $(addprefix $(SP_BDIR)/, $(SP_OBJS))
#SP_BOBJS    = $(patsubst $(SP_SRCD)/%.c, $(SP_BDIR)/%.o, $(SP_SRCS))
SP_$(SP_TARGET_NAME)_BCFLAGS = $(SP_INCS)

# Add to subprojects
SP_SOURCES 	+= $(SP_$(SP_TARGET_NAME)_BSRCS)
SP_DEPENDS 	+= $(SP_$(SP_TARGET_NAME)_BOBJS)
SP_INCLUDES += $(SP_$(SP_TARGET_NAME)_INCS)
SP_LIBS 		+= $(SP_$(SP_TARGET_NAME)_SHARED)

# Create the directory, object files, dynamic & static libraries
#$(SP_TARGET_NAME): $(SP_BDIR) $(SP_BOBJS) $(SP_SHARED) $(SP_STATIC)
#$(SP_TARGET_NAME) $(SP_BOBJS): $(SP_BDIR) $(SP_SHARED) $(SP_STATIC)
#$(SP_TARGET_NAME): $(SP_BDIR) $(SP_BOBJS) $(SP_SHARED) $(SP_STATIC)
#$(SP_TARGET_NAME): $(SP_BDIR) $(SP_BSRCS) $(SP_SHARED) $(SP_STATIC)
#$(SP_TARGET_NAME): $(SP_BDIR) $(addprefix $(SP_BDIR)/, $(SP_OBJS)) $(SP_SHARED) $(SP_STATIC)
#$(SP_TARGET_NAME): $(SP_BDIR) $(SP_BOBJS) $(SP_SHARED) $(SP_STATIC)
#$(SP_TARGET_NAME): $(SP_BDIR) $$(SP_BOBJS) $(SP_SHARED) $(SP_STATIC)

#$(SP_TARGET_NAME): $(SP_BDIR) $(SP_BOBJS) $(SP_SHARED).so $(SP_STATIC).a
#$(SP_TARGET_NAME): $(SP_BDIR) $(SP_BOBJS) $(SP_SHARED) $(SP_STATIC)
#$(SP_TARGET_NAME): $(SP_BDIR) $(SP_BDIR)/*.o $(SP_SHARED) $(SP_STATIC)
$(SP_TARGET_NAME): $(SP_$(SP_TARGET_NAME)_BDIR) $(SP_$(SP_TARGET_NAME)_BOBJS) $(SP_$(SP_TARGET_NAME)_SHARED) $(SP_$(SP_TARGET_NAME)_STATIC)

#$(SP_BOBJS): $(foreach x

# Compiles and builds build/depends/log.c/log.o, depends on subproject srcs and headers
#$(SP_BOBJS): $(SP_BSRCS) $(SP_INCS:.h)
#$(SP_BDIR)/%.o: $(SP_BSRCS)/%.c $(SP_INCS)/%.h
#$(SP_BDIR)/%.o: $(SP_BSRCS)/%.c $(SP_INCS)/%.h
#$(SP_BOBJS): $(SP_BSRCS) $(SP_INCS:.h)
#$(SP_BDIR)/%.o: $(SP_BSRCS)/%.c $(SP_INCS)/%.h
#$(SP_BDIR)%.o: $(SP_BSRCS)%.c $(SP_INCS)%.h
#$(TARGET_DIR)/depends/$(SP_NAME)/%.o: $(SP_BSRCS) $(SP_INCS)%.h
#$(TARGET_DIR)/depends/$(SP_NAME)/%.o: $(SP_BSRCS) $(SP_INCS)%.h
$(SP_$(SP_TARGET_NAME)_BDIR)%.o: $(SP_$(SP_TARGET_NAME)_SRCD)%.c $(SP_$(SP_TARGET_NAME)_INCS)%.h
	@echo "Compiling $(SP_NAME) sources"
	$(CC) -c -fPIC $(TARGET_FLAGS) $(SP_$(SP_TARGET_NAME)_INCS) -o $@ $^

# Compiles and builds build/depends/log.c/log.o, depends on subproject srcs
#$(SP_BDIR)/%.o: $(SP_BSRCS)/%.c
#$(SP_BDIR)%.o: $(SP_BSRCS)%.c
$(SP_$(SP_TARGET_NAME)_BDIR)%.o: $(SP_$(SP_TARGET_NAME)_SRCD)%.c
	@echo "Compiling $(SP_NAME) sources"
	$(CC) -c -fPIC $(TARGET_FLAGS) $(SP_$(SP_TARGET_NAME)_INCS) -o $@ $^

#$(CC) -c -fPIC $(TARGET_FLAGS) $(LOGC_FLAGS) -o $@ $^

# Links and creates dynamic library: build/depends/$(SP_NAME)/$(SP_SHARED)
#$(SP_SHARED): $(SP_BDIR)
#$(SP_SHARED): $(SP_BOBJS)
#$(SP_SHARED): $(SP_BDIR)/*.o
$(SP_$(SP_TARGET_NAME)_SHARED): $(SP_$(SP_TARGET_NAME)_BOBJS)
	@echo "Creating $(SP_$(SP_TARGET_NAME)_NAME) shared library"
	$(CC) -shared $(SP_$(SP_TARGET_NAME)_INCS) -o $@ $^

# Links and creates static library: build/depends/$(SP_NAME)/$(SP_SHARED)
#$(SP_STATIC): $(SP_BOBJS)
#$(SP_STATIC): $(SP_BDIR)%.o
#$(SP_STATIC): $(SP_BOBJS)
#$(SP_STATIC): $(SP_BDIR)%.o
$(SP_$(SP_TARGET_NAME)_STATIC): $(SP_$(SP_TARGET_NAME)_BOBJS)
	@echo "Creating $(SP_$(SP_TARGET_NAME)_NAME) static library"
	ar rcs $@ $^

# Make build directory
$(SP_$(SP_TARGET_NAME)_BDIR):
	$(MKDIR) $(SP_$(SP_TARGET_NAME)_BDIR)

# Create clean target
clean-$(SP_TARGET_NAME):
	@echo "Removing $(SP_NAME) build output"
	$(CLEANUP) $(SP_BOBJS)

# Add clean rule to master, subproject clean targets
CLEAN_TARGET 		+= clean-$(SP_TARGET_NAME)
CLEAN_SP_TARGET += clean-$(SP_TARGET_NAME)
