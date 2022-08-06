# Variables
SP_TARGET_NAME = logc

SP_NAME 		= log.c
SP_SRCS 		= log.c
SP_SRCD			= $(SUBPROJECTS)/$(SP_NAME)/src
SP_OBJS 		= $(SP_SRCS:.c=.o)
SP_INCS 		= -I$(SP_SRCD)

# Build dynamic, static libraries
SP_LIB_NAME 	= logc
SP_SHARED 		= $(SP_SRCD)/lib$(SP_LIB_NAME).so
SP_STATIC 		= $(SP_SRCD)/lib$(SP_LIB_NAME).a

.PHONY: $(SP_TARGET_NAME) clean-$(SP_TARGET_NAME)

# Log.c Dependency
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

# Compiles and builds build/depends/log.c/log.o, depends on subproject srcs
#$(SP_BOBJS): $(SP_BSRCS) $(SP_INCS)/*.h
#$(SP_BOBJS)/%.o: $(SP_BSRCS) $(SP_INCS)/%.o
#$(SP_BOBJS): $(SP_BSRCS) $(SP_INCS)/%.o
#$(SP_BOBJS)/%.o: $(SP_BSRCS)/%.c $(SP_INCS)/%.o
$(SP_BOBJS): $(SP_BSRCS) $(SP_INCS:.h)
	@echo "Compiling $(SP_NAME) sources"
	$(CC) -c -fPIC $(TARGET_FLAGS) $(LOGC_FLAGS) -o $@ $^

# Links and creates dynamic library in build/depends/log.c/liblog.so
$(SP_SHARED): $(SP_BOBJS)
	@echo "Creating $(SP_NAME) shared library"
	$(CC) -shared $(SP_INCS) -o $@ $^

# Links and creates static library in build/depends/log.c/liblog.so
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

# TODO: Add clean rule to master clean rule
# TODO: Add clean rule to clean-subprojects
