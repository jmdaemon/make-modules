# Log.c

# Usage:
# 1. Define SP_DEPENDS, SP_INCLUDES
# 2. Include this make module:
# 	include log.c.mk
# 3. Add $(SP_DEPENDS) to your link target:
# 	bin: $(SP_DEPENDS)
# 4. Add $(SP_INCLUDES) headers to your targets:
# $(EXE_DEPS)/%.o: $(PATHS)/%.c $(SP_DEPENDS)
#		@echo "Compiling main binary target source"
#		$(CC) -c $(EXE_FLAGS) $(SP_INCLUDES) -o $@ $<
# 5. Run your make commands to build your targets

# Variables
SUB_LOG_C_NAME 			= log.c
SUB_LOG_C_SRCS 			= log.c
SUB_LOG_C_OBJS 			= $(SUB_LOG_C_SRCS:.c=.o)
SUB_LOG_C_SRC 			= $(SUBPROJECTS)/$(SUB_LOG_C_NAME)/src
SUB_LOG_C_INCLUDES 	= -I$(SUB_LOG_C_SRC)

# Setup
.PHONY: logc clean-logc

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
	$(CC) -c $(LIB_CFLAGS) $(SP_LOGC_CFLAGS) $(LOGC_FLAGS) -o $@ $^

$(SP_LOGC_DIR):
	$(MKDIR) $(SP_LOGC_DIR)

clean-logc:
	@echo "Removing log.c build output"
	$(CLEANUP) $(SP_LOGC_OBJS)
