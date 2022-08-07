# Variables
#$$(SP_TARGET_NAME)= logc

#$$(SP_NAME) 		= log.c
#$$(SP_SRCS) 		= log.c
#$$(SP_SRCD)		= $(SUBPROJECTS)/$$(SP_NAME)/src
#$$(SP_OBJS) 		= $$(SP_SRCS:.c=.o)
#$$(SP_INCS) 		= -I$$(SP_SRCD)

## Build dynamic, static libraries
#$$(SP_LIB_NAME) = logc
##$(SP_SHARED)		= $(SP_BDIR)/lib$(SP_LIB_NAME)
##$(SP_STATIC)		= $(SP_BDIR)/lib$(SP_LIB_NAME)
#$$(SP_SHARED)	= $$(SP_BDIR)/lib$$(SP_LIB_NAME).so
#$$(SP_STATIC)	= $$(SP_BDIR)/lib$$(SP_LIB_NAME).a

$(info $(eval SP_TARGET_NAME := logc))
$(info $(eval SP_NAME := log.c))
$(info $(eval SP_SRCS := log.c))
$(info $(eval SP_SRCD := $(SUBPROJECTS)/$(SP_NAME)/src))
$(info $(eval SP_INCS := -I$(SP_SRCD)))
$(info $(eval SP_LIB_NAME := $(SP_TARGET_NAME)))
$(info $(eval SP_SHARED := $(SP_BDIR)/lib$(SP_LIB_NAME).so))
$(info $(eval SP_STATIC := $(SP_BDIR)/lib$(SP_LIB_NAME).a ))





#$(foreach t,$(SP_NAMES),$(eval SP_NAME := $(SOURCES_$t:.c=.o)))

#$(info $(eval SP_TARGET_NAME := $(SP_TARGET_NAME)))
#$(info $(eval SP_NAME := $(SP_NAME)))
#$(info $(eval SP_SRCS := $(SP_SRCS)))
#$(info $(eval SP_SRCD := $(SP_SRCD)))
#$(info $(eval SP_INCS := $(SP_INCS)))

#$(info $(eval SP_LIB_NAME := $(SP_LIB_NAME)))
#$(info $(eval SP_SHARED := $(SP_SHARED)))
#$(info $(eval SP_STATIC := $(SP_STATIC)))


#$(info $(SP_TARGET_NAME := $(SP_TARGET_NAME)))
#$(info $(SP_NAME := $(SP_NAME)))
#$(info $(SP_SRCS := $(SP_SRCS)))
#$(info $(SP_SRCD := $(SP_SRCD)))
#$(info $(SP_INCS := $(SP_INCS)))

#$(info $(SP_LIB_NAME := $(SP_LIB_NAME)))
#$(info $(SP_SHARED := $(SP_SHARED)))
#$(info $(SP_STATIC := $(SP_STATIC)))

#$(info SP_TARGET_NAME := $$(SP_TARGET_NAME))
#$(info SP_NAME := $$(SP_NAME))
#$(info SP_SRCS := $$(SP_SRCS))
#$(info SP_SRCD := $$(SP_SRCD))
#$(info SP_INCS := $$(SP_INCS))

#$(info SP_LIB_NAME := $$(SP_LIB_NAME))
#$(info SP_SHARED := $$(SP_SHARED))
#$(info SP_STATIC := $$(SP_STATIC))

#$(info $(SP_TARGET_NAME := $(eval $$(SP_TARGET_NAME))))
#$(info $(SP_NAME := $(eval $$(SP_NAME))))
#$(info $(SP_SRCS := $(eval $$(SP_SRCS))))
#$(info $(SP_SRCD := $(eval $$(SP_SRCD))))
#$(info $(SP_INCS := $(eval $$(SP_INCS))))
#$(info $(SP_LIB_NAME := $(eval $$(SP_LIB_NAME))))
#$(info $(SP_SHARED := $(eval $$(SP_SHARED))))
#$(info $(SP_STATIC := $(eval $$(SP_STATIC))))


#$(eval SP_TARGET_NAME := $($(SP_TARGET_NAME)))
#$(eval SP_NAME := $($(SP_NAME)))
#$(eval SP_SRCS := $($(SP_SRCS)))
#$(eval SP_SRCD := $($(SP_SRCD)))
#$(eval SP_INCS := $($(SP_INCS)))

#$(eval SP_LIB_NAME := $($(SP_LIB_NAME)))
#$(eval SP_SHARED := $($(SP_SHARED)))
#$(eval SP_STATIC := $($(SP_STATIC)))



# Builds subproject
include make/subproject.mk
