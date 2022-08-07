# Variables
SP_TARGET_NAME = logc

$(SP_NAME) 		= log.c
$(SP_SRCS) 		= log.c
$(SP_SRCD)		= $(SUBPROJECTS)/$(SP_NAME)/src
$(SP_OBJS) 		= $(SP_SRCS:.c=.o)
$(SP_INCS) 		= -I$(SP_SRCD)

# Build dynamic, static libraries
$(SP_LIB_NAME) 	= logc
#$(SP_SHARED)		= $(SP_BDIR)/lib$(SP_LIB_NAME)
#$(SP_STATIC)		= $(SP_BDIR)/lib$(SP_LIB_NAME)
$(SP_SHARED)		= $(SP_BDIR)/lib$(SP_LIB_NAME).so
$(SP_STATIC)		= $(SP_BDIR)/lib$(SP_LIB_NAME).a

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
