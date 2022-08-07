# Variables
SP_TARGET_NAME_logc = logc

SP_NAME_logc 				= log.c
SP_SRCS_logc 				= log.c
SP_SRCD_logc				= $(SUBPROJECTS)/$(SP_NAME_$(1))/src
SP_OBJS_logc 				= $(SP_SRCS_$(1):.c=.o)
SP_INCS_logc 				= -I$(SP_SRCD_$(1))

# Build dynamic, static libraries
SP_LIB_NAME_logc 		= logc
SP_SHARED_logc 			= $$(SP_BDIR_$(1))/lib$(SP_LIB_NAME_$(1)).so
SP_STATIC_logc 			= $$(SP_BDIR_$(1))/lib$(SP_LIB_NAME_$(1)).a

# Include subproject_template
include make/subproject.mk

$(eval $(foreach subproject,$(SP_NAMES),$(call subproject_template,$(subproject))))
#$(info $(foreach subproject,$(SP_NAMES),$(call subproject_template,$(subproject))))
