# Variables
SP_TARGET_NAME_utility = utility

SP_NAME_utility 				= utility
SP_SRCS_utility 				= utility.c command.c file.c
SP_SRCD_utility					= $(SUBPROJECTS)/$(SP_NAME_$(1))/src
SP_OBJS_utility 				= $(SP_SRCS_$(1):.c=.o)
SP_INCS_utility 				= -I$(SUBPROJECTS)/$(SP_NAME_$(1))/include

SP_LIB_NAME_utility 		= utility
SP_SHARED_utility 			= $$(SP_BDIR_$(1))/lib$(SP_LIB_NAME_$(1)).so
SP_STATIC_utility 			= $$(SP_BDIR_$(1))/lib$(SP_LIB_NAME_$(1)).a

#SP_SHARED_utility 			= build/debug/depends/utility/lib$(SP_LIB_NAME_$(1)).so
#SP_STATIC_utility 			= build/debug/depends/utility/lib$(SP_LIB_NAME_$(1)).a

#SP_SHARED_utility 			= build/debug/depends/utility.c/libutility.so
#SP_STATIC_utility 			= build/debug/depends/utility.c/libutility.a
