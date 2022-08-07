# Variables
$$(SP_TARGET_NAME) = utility

$$(SP_NAME) 		= $$(SP_TARGET_NAME)
$$(SP_SRCS) 		= utility.c command.c file.c
$$(SP_SRCD)			= $(SUBPROJECTS)/$$(SP_NAME)/src
$$(SP_OBJS) 		= $$(SP_SRCS:.c=.o)
$$(SP_INCS) 		= -I$(SUBPROJECTS)/$$(SP_NAME)/include

# Build dynamic, static libraries
$$(SP_LIB_NAME) = $$(SP_TARGET_NAME)
$$(SP_SHARED) 	= $$(SP_BDIR)/lib$$(SP_LIB_NAME).so
$$(SP_STATIC) 	= $$(SP_BDIR)/lib$$(SP_LIB_NAME).a

#SP_SHARED 		= $(SP_BDIR)/lib$(SP_LIB_NAME)
#SP_STATIC 		= $(SP_BDIR)/lib$(SP_LIB_NAME)

#SP_SHARED 		= $(SP_BDIR)/lib$(SP_LIB_NAME).so
#SP_STATIC 		= $(SP_BDIR)/lib$(SP_LIB_NAME).a

#SP_SHARED 		= $(SP_SRCD)/lib$(SP_LIB_NAME).so
#SP_STATIC 		= $(SP_SRCD)/lib$(SP_LIB_NAME).a

$(eval SP_TARGET_NAME := $(SP_TARGET_NAME))
$(eval SP_NAME := $(SP_NAME))
$(eval SP_SRCS := $(SP_SRCS))
$(eval SP_SRCD := $(SP_SRCD))
$(eval SP_INCS := $(SP_INCS))

$(eval SP_LIB_NAME := $(SP_LIB_NAME))
$(eval SP_SHARED := $(SP_SHARED))
$(eval SP_STATIC := $(SP_STATIC))

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
