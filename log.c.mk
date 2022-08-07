# Variables
#SP_TARGET_NAME := logc

#SP_NAME 		:= log.c
#SP_SRCS 		:= log.c
#SP_SRCD			:= $(SUBPROJECTS)/$(SP_NAME)/src
#SP_OBJS 		:= $(SP_SRCS:.c=.o)
#SP_INCS 		:= -I$(SP_SRCD)

## Build dynamic, static libraries
#SP_LIB_NAME 	:= logc
##SP_SHARED 		:= $(SP_BDIR)/lib$(SP_LIB_NAME)
##SP_STATIC 		:= $(SP_BDIR)/lib$(SP_LIB_NAME)
#SP_SHARED 		:= $(SP_BDIR)/lib$(SP_LIB_NAME).so
#SP_STATIC 		:= $(SP_BDIR)/lib$(SP_LIB_NAME).a

##

#SP_TARGET_NAME_logc := logc

#SP_NAME_logc 		:= log.c
#SP_SRCS_logc 		:= log.c
#SP_SRCD_logc		:= $(SUBPROJECTS)/$(SP_NAME)/src
#SP_OBJS_logc 		:= $(SP_SRCS:.c=.o)
#SP_INCS_logc 		:= -I$(SP_SRCD)

## Build dynamic, static libraries
#SP_LIB_NAME_logc 	:= logc
#SP_SHARED_logc 		:= $(SP_BDIR)/lib$(SP_LIB_NAME).so
#SP_STATIC_logc 		:= $(SP_BDIR)/lib$(SP_LIB_NAME).a

###
SP_TARGET_NAME_logc = logc

SP_NAME_logc 		= log.c
SP_SRCS_logc 		= log.c
SP_SRCD_logc		= $(SUBPROJECTS)/$(SP_NAME_$(1))/src
SP_OBJS_logc 		= $(SP_SRCS_$(1):.c=.o)
SP_INCS_logc 		= -I$(SP_SRCD_$(1))

# Build dynamic, static libraries
SP_LIB_NAME_logc 	= logc
#SP_SHARED_logc 		= $$(SP_BDIR_$(1))/lib$$(SP_LIB_NAME_$(1)).so
#SP_STATIC_logc 		= $$(SP_BDIR_$(1))/lib$$(SP_LIB_NAME_$(1)).a
SP_SHARED_logc 		= $$(SP_BDIR_$(1))/lib$(SP_LIB_NAME_$(1)).so
SP_STATIC_logc 		= $$(SP_BDIR_$(1))/lib$(SP_LIB_NAME_$(1)).a



# Builds subproject
include make/subproject.mk

#$(foreach subproject,$(SP_NAMES),$(eval $(call subproject_template,$(subproject))))
$(eval $(foreach subproject,$(SP_NAMES),$(call subproject_template,$(subproject))))
#$(info $(foreach subproject,$(SP_NAMES),$(call subproject_template,$(subproject))))
