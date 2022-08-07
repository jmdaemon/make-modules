# Variables
SP_TARGET_NAME := logc
#$(SP_TARGET_NAME)_

SP_$$(SP_TARGET_NAME)_NAME 		:= log.c
SP_$$(SP_TARGET_NAME)_SRCS 		:= log.c
SP_$$(SP_TARGET_NAME)_SRCD		:= $(SUBPROJECTS)/$(SP_$(SP_TARGET_NAME)_NAME)/src
SP_$$(SP_TARGET_NAME)_OBJS 		:= $(SP_SRCS:.c=.o)
SP_$$(SP_TARGET_NAME)_INCS 		:= -I$(SP_SRCD)

# Build dynamic, static libraries
SP_$(SP_TARGET_NAME)_LIB_NAME 	:= logc
#SP_SHARED 		:= $(SP_BDIR)/lib$(SP_LIB_NAME)
#SP_STATIC 		:= $(SP_BDIR)/lib$(SP_LIB_NAME)
SP_$(SP_TARGET_NAME)_SHARED 		:= $(SP_$(SP_TARGET_NAME)_BDIR)/lib$(SP_$(SP_TARGET_NAME)_LIB_NAME).so
SP_$(SP_TARGET_NAME)_STATIC 		:= $(SP_$(SP_TARGET_NAME)_BDIR)/lib$(SP_$(SP_TARGET_NAME)_LIB_NAME).a

# Builds subproject
include make/subproject.mk
