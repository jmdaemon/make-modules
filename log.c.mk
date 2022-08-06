# Variables
SP_LOG_C_NAME 		= log.c
SP_LOG_C_SRCS 		= log.c
SP_LOG_C_SRC 			= $(SUBPROJECTS)/$(SP_LOG_C_NAME)/src
SP_LOG_C_OBJS 		= $(SP_LOG_C_SRCS:.c=.o)
SP_LOG_C_INCLUDES = -I$(SP_LOG_C_SRC)

# Build dynamic, static libraries
SP_LOGC_LIB_NAME 	= logc
SP_LOGC_LIB 			= $(SP_LOGC_DIR)/lib$(SP_LOGC_LIB_NAME).so
SP_LOGC_STATIC 		= $(SP_LOGC_DIR)/lib$(SP_LOGC_LIB_NAME).a

.PHONY: logc clean-logc

# Log.c Dependency
# SP_LOGC_DIR: Outputs build dependencies to build/{debug,release}/depends/subproject_name
SP_LOGC_DIR 	 = $(TARGET_DIR)/depends/$(SP_LOG_C_NAME)
SP_LOGC_SRCS 	 = $(addprefix $(SP_LOG_C_SRC)/, $(SP_LOG_C_SRCS))
SP_LOGC_OBJS 	 = $(addprefix $(SP_LOGC_DIR)/, $(SP_LOG_C_OBJS))
SP_LOGC_CFLAGS = $(SP_LOG_C_INCLUDES)

# Add to subprojects
SP_SOURCES 	+= $(SP_LOGC_SRCS)
SP_DEPENDS 	+= $(SP_LOGC_OBJS)
SP_INCLUDES += $(SP_LOG_C_INCLUDES)
SP_LIBS 		+= $(SP_LOGC_LIB)

# Create the directory, object files, dynamic & static libraries
logc: $(SP_LOGC_DIR) $(SP_LOGC_OBJS) $(SP_LOGC_LIB) $(SP_LOGC_STATIC)

# Compiles and builds build/depends/log.c/log.o, depends on subproject srcs
$(SP_LOGC_OBJS): $(SP_LOGC_SRCS)
	@echo "Building $(SP_LOG_C_NAME):"
	$(CC) -c -fPIC $(TARGET_FLAGS) $(LOGC_FLAGS) -o $@ $^
	@echo "Finished compiling $(SP_LOG_C_NAME)"

# Links and creates dynamic library in build/depends/log.c/liblog.so
$(SP_LOGC_LIB): $(SP_LOGC_OBJS)
	$(CC) -shared $(SP_INCLUDES) -o $@ $^
	@echo "Created $(SP_LOG_C_NAME) shared library"

# Links and creates static library in build/depends/log.c/liblog.so
$(SP_LOGC_STATIC): $(SP_LOGC_OBJS)
	ar rcs $@ $^
	@echo "Created $(SP_LOG_C_NAME) static library"

$(SP_LOGC_DIR):
	$(MKDIR) $(SP_LOGC_DIR)

clean-logc:
	@echo "Removing log.c build output"
	$(CLEANUP) $(SP_LOGC_OBJS)
