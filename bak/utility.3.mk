# Variables
#SP_TARGET_NAME = utility

SP_$(SP_TARGET_NAME)_NAME 		= $(SP_TARGET_NAME)
SP_$(SP_TARGET_NAME)_SRCS 		= utility.c command.c file.c
SP_$(SP_TARGET_NAME)_SRCD			= $(SUBPROJECTS)/$(SP_$(SP_TARGET_NAME)_NAME)/src
SP_$(SP_TARGET_NAME)_OBJS 		= $(SP_SRCS:.c=.o)
SP_$(SP_TARGET_NAME)_INCS 		= -I$(SUBPROJECTS)/$(SP_$(SP_TARGET_NAME)_NAME)/include

# Build dynamic, static libraries
SP_$(SP_TARGET_NAME)_LIB_NAME = $(SP_TARGET_NAME)
SP_$(SP_TARGET_NAME)_SHARED 	= $(SP_$(SP_TARGET_NAME)_BDIR)/lib$(SP_$(SP_TARGET_NAME)_LIB_NAME).so
SP_$(SP_TARGET_NAME)_STATIC 	= $(SP_$(SP_TARGET_NAME)_BDIR)/lib$(SP_$(SP_TARGET_NAME)_LIB_NAME).a

#SP_SHARED 		= $(SP_BDIR)/lib$(SP_LIB_NAME)
#SP_STATIC 		= $(SP_BDIR)/lib$(SP_LIB_NAME)

#SP_SHARED 		= $(SP_BDIR)/lib$(SP_LIB_NAME).so
#SP_STATIC 		= $(SP_BDIR)/lib$(SP_LIB_NAME).a

#SP_SHARED 		= $(SP_SRCD)/lib$(SP_LIB_NAME).so
#SP_STATIC 		= $(SP_SRCD)/lib$(SP_LIB_NAME).a

# Builds subproject
include make/subproject.mk

#SUB_UTILITY_C_NAME 			= utility
#SUB_UTILITY_C_SRCS 			= utility.c command.c file.c
#SUB_UTILITY_C_OBJS 			= $(SUB_UTILITY_C_SRCS:.c=.o)
#SUB_UTILITY_C_SRC 			= $(SUBPROJECTS)/$(SUB_UTILITY_C_NAME)/src
#SUB_UTILITY_C_INCLUDES 	= -I$(SUBPROJECTS)/$(SUB_UTILITY_C_NAME)/include

## Setup
#.PHONY: utility clean-utility

## Log.c Dependency
#SP_UTILITYC_DIR 	 = $(PATHD)/$(SUB_UTILITY_C_NAME)
#SP_UTILITYC_SRCS 	 = $(addprefix $(SUB_UTILITY_C_SRC)/, $(SUB_UTILITY_C_SRCS))
#SP_UTILITYC_OBJS 	 = $(addprefix $(SP_UTILITYC_DIR)/, $(SUB_UTILITY_C_OBJS))
#SP_UTILITYC_CFLAGS = $(SUB_UTILITY_C_INCLUDES)

## Add to subprojects
##SP_INCLUDES = $(SUB_UTILITY_C_INCLUDES)
#SP_SOURCES 	+= $(SP_UTILITYC_SRCS)
#SP_DEPENDS 	+= $(SP_UTILITYC_OBJS)
#SP_INCLUDES += $(SUB_UTILITY_C_INCLUDES)

## Create the utility output file
#utility: $(SP_UTILITYC_DIR) $(SP_UTILITYC_OBJS)

## Build build/depends/utility/utility.o
## Depend on the utility.c source
## Note that we build it with -fPIC since we include it in our library
#$(SP_UTILITYC_OBJS): $(SP_UTILITYC_SRCS)
	#$(CC) -c $(LIB_CFLAGS) $(SP_UTILITYC_CFLAGS) $(UTILITYC_FLAGS) $@ $^

#$(SP_UTILITYC_CDIR)/lib$(SUB_UTILITY_C_NAME).so: $(SP_UTILITYC_OBJS)
	#$(CC) $(LIB_LDFLAGS) $(LIB_FLAGS) $(SUB_UTILITY_C_INCLUDES) -o $@ $^
##$(CC) -c $(LIB_CFLAGS) $(SP_UTILITYC_CFLAGS) $(UTILITYC_FLAGS) -o libutility.so $@ $^
	##$(CC) -c $(LIB_CFLAGS) $(SP_UTILITYC_CFLAGS) $(UTILITYC_FLAGS) $@ $^
	
##$(SP_UTILITYC_CDIR)/$(SUB_UTILITY_C_NAME).o: 

#$(SP_UTILITYC_DIR):
	#$(MKDIR) $(SP_UTILITYC_DIR)

#clean-utility:
	#@echo "Removing log.c build output"
	#$(CLEANUP) $(SP_UTILITYC_OBJS)
