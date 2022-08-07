SP_TARGET_NAME_utility = utility

SP_NAME_utility 				= utility
SP_SRCS_utility 				= utility.c command.c file.c
SP_SRCD_utility					= $(SUBPROJECTS)/$(SP_NAME_$(1))/src
SP_OBJS_utility 				= $(SP_SRCS_$(1):.c=.o)
SP_INCS_utility 				= -I$(SUBPROJECTS)/$(SP_NAME_$(1))/include
SP_HDRS_utility					= $(SP_SRCS_$(1):.c=.h)
SP_HDRD_utility					= $(SUBPROJECTS)/$(SP_NAME_$(1))/include

SP_LIB_NAME_utility 		= utility
SP_SHARED_utility 			= $$(SP_BDIR_$(1))/lib$(SP_LIB_NAME_$(1)).so
SP_STATIC_utility 			= $$(SP_BDIR_$(1))/lib$(SP_LIB_NAME_$(1)).a
#$(eval $(call shared_lib_tmpl,$(SP_LIB_NAME_utility)))
#$(eval $(call static_lib_tmpl,$(SP_LIB_NAME_utility)))
