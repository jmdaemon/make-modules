define subproject_template

.PHONY: $$(SP_TARGET_NAME_$(1)) clean-$$(SP_TARGET_NAME_$(1))

$(info $(SP_TARGET_NAME_$(1)))

#$(info "$$(SP_TARGET_NAME_$(1))")
#$(info "$$(SP_TARGET_NAME_$(1))")
#$(info "$$(SP_TARGET_NAME_$(1))")

# SP_LOGC_DIR: Outputs build dependencies to build/{debug,release}/depends/subproject_name
SP_BDIR_$(1) 	 = $(TARGET_DIR)/depends/$$(SP_NAME_$(1))
SP_BSRCS_$(1) 	 = $(addprefix $$(SP_SRCD_$(1))/, $$(SP_SRCS_$(1)))
SP_BOBJS_$(1) 	 = $(addprefix $$(SP_BDIR_$(1))/, $$(SP_OBJS_$(1)))
#SP_BOBJS    = $(patsubst $$(SP_SRCD_$(1))/%.c, $$(SP_BDIR_$(1))/%.o, $$(SP_SRCS_$(1)))
SP_BCFLAGS_$(1) = $$(SP_INCS_$(1))

# Add to subprojects
SP_SOURCES 	+= $(SP_BSRCS_$(1))
SP_DEPENDS 	+= $(SP_BOBJS_$(1))
SP_INCLUDES += $(SP_INCS_$(1))
SP_LIBS 		+= $(SP_SHARED_$(1))

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
$$(SP_TARGET_NAME_$(1)): $(SP_BDIR_$(1)) $(SP_BOBJS_$(1)) $$(SP_SHARED_$(1)) $$(SP_STATIC_$(1))

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
$(SP_BDIR_$(1))%.o: $$(SP_SRCD_$(1))%.c $$(SP_INCS_$(1))%.h
	@echo "Compiling $$(SP_NAME_$(1)) sources"
	$(CC) -c -fPIC $(TARGET_FLAGS) $$(SP_INCS_$(1)) -o $@ $^

# Compiles and builds build/depends/log.c/log.o, depends on subproject srcs
#$(SP_BDIR)/%.o: $(SP_BSRCS)/%.c
#$(SP_BDIR)%.o: $(SP_BSRCS)%.c
$(SP_BDIR_$(1))%.o: $$(SP_SRCD_$(1))%.c
	@echo "Compiling $$(SP_NAME_$(1)) sources"
	$(CC) -c -fPIC $(TARGET_FLAGS) $$(SP_INCS_$(1)) -o $@ $^

#$(CC) -c -fPIC $(TARGET_FLAGS) $(LOGC_FLAGS) -o $@ $^

# Links and creates dynamic library: build/depends/$(SP_NAME)/$(SP_SHARED)
#$(SP_SHARED): $(SP_BDIR)
#$(SP_SHARED): $(SP_BOBJS)
#$(SP_SHARED): $(SP_BDIR)/*.o
$$(SP_SHARED_$(1)): $(SP_BOBJS_$(1))
	@echo "Creating $$(SP_NAME_$(1)) shared library"
	$(CC) -shared $$(SP_INCS_$(1)) -o $@ $^

# Links and creates static library: build/depends/$(SP_NAME)/$(SP_SHARED)
#$(SP_STATIC): $(SP_BOBJS)
#$(SP_STATIC): $(SP_BDIR)%.o
#$(SP_STATIC): $(SP_BOBJS)
#$(SP_STATIC): $(SP_BDIR)%.o
$$(SP_STATIC_$(1)): $(SP_BOBJS_$(1))
	@echo "Creating $$(SP_NAME_$(1)) static library"
	ar rcs $@ $^

# Make build directory
$(SP_BDIR_$(1)):
	$(MKDIR) $(SP_BDIR_$(1))

# Create clean target
clean-$$(SP_TARGET_NAME_$(1)):
	@echo "Removing $$(SP_NAME_$(1)) build output"
	$(CLEANUP) $(SP_BOBJS_$(1))

# Add clean rule to master, subproject clean targets
CLEAN_TARGET 		+= clean-$$(SP_TARGET_NAME_$(1))
CLEAN_SP_TARGET += clean-$$(SP_TARGET_NAME_$(1))

endef
