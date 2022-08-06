# Variables
SP_LOG_C_NAME 		= log.c
SP_LOG_C_SRCS 		= log.c
SP_LOG_C_SRC 			= $(SUBPROJECTS)/$(SP_LOG_C_NAME)/src
SP_LOG_C_OBJS 		= $(SP_LOG_C_SRCS:.c=.o)
SP_LOG_C_INCLUDES = -I$(SP_LOG_C_SRC)

SP_LOGC_LIB_NAME 	= logc
SP_LOGC_LIB 			= $(SP_LOGC_DIR)/lib$(SP_LOGC_LIB_NAME).so

.PHONY: logc clean-logc

# Log.c Dependency
SP_LOGC_DIR 	 = $(PATHD)/$(SP_LOG_C_NAME)
SP_LOGC_SRCS 	 = $(addprefix $(SP_LOG_C_SRC)/, $(SP_LOG_C_SRCS))
SP_LOGC_OBJS 	 = $(addprefix $(SP_LOGC_DIR)/, $(SP_LOG_C_OBJS))
SP_LOGC_CFLAGS = $(SP_LOG_C_INCLUDES)

# Add to subprojects
SP_SOURCES 	+= $(SP_LOGC_SRCS)
SP_DEPENDS 	+= $(SP_LOGC_OBJS)
SP_INCLUDES += $(SP_LOG_C_INCLUDES)

SP_LIBS += $(SP_LOGC_LIB)

# Create the directory, object files, and library
logc: $(SP_LOGC_DIR) $(SP_LOGC_OBJS) $(SP_LOGC_LIB)

# Builds build/depends/log.c/log.o, depends on subproject srcs
$(SP_LOGC_OBJS): $(SP_LOGC_SRCS)
	$(CC) -c -fPIC $(SP_LOGC_CFLAGS) $(LOGC_FLAGS) -o $@ $^
#$(CC) -c $(LIB_CFLAGS) $(SP_LOGC_CFLAGS) $(LOGC_FLAGS) -o $@ $^

# Create dynamic library in build/depends/log.c/liblog.so
$(SP_LOGC_LIB): $(SP_LOGC_OBJS)
	$(CC) -shared $(SP_INCLUDES) -o $@ $^

$(SP_LOGC_DIR):
	$(MKDIR) $(SP_LOGC_DIR)

clean-logc:
	@echo "Removing log.c build output"
	$(CLEANUP) $(SP_LOGC_OBJS)
