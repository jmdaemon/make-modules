# Log.c

# Variables
SUB_LOG_C_NAME 			= log.c
SUB_LOG_C_SRCS 			= log.c
SUB_LOG_C_OBJS 			= $(SUB_LOG_C_SRCS:.c=.o)
SUB_LOG_C_SRC 			= $(SUBPROJECTS)/$(SUB_LOG_C_NAME)/src
SUB_LOG_C_INCLUDES 	= -I$(SUB_LOG_C_SRC)

# Setup

# Log.c Dependency
SP_LOGC_DIR 	 = $(PATHD)/$(SUB_LOG_C_NAME)
SP_LOGC_SRCS 	 = $(addprefix $(SUB_LOG_C_SRC)/, $(SUB_LOG_C_SRCS))
SP_LOGC_OBJS 	 = $(addprefix $(SP_LOGC_DIR)/, $(SUB_LOG_C_OBJS))
SP_LOGC_CFLAGS = $(SUB_LOG_C_INCLUDES)

# Add to subprojects
#SP_INCLUDES = $(SUB_LOG_C_INCLUDES)
SP_DEPENDS 	+= $(SP_LOGC_OBJS)
SP_INCLUDES += $(SUB_LOG_C_INCLUDES)

# Create the logc output file
logc: $(SP_LOGC_DIR) $(SP_LOGC_OBJS)

# Build build/depends/log.c/log.o
# Depend on the log.c source
# Note that we build it with -fPIC since we include it in our library
$(SP_LOGC_OBJS): $(SP_LOGC_SRCS)
	$(CC) -c $(LIB_CFLAGS) $(SP_LOGC_CFLAGS) -o $@ $^

$(SP_LOGC_DIR):
	$(MKDIR) $(SP_LOGC_DIR)

