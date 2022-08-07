SP_TARGET_NAME_tomlc99 = tomlc99

SP_NAME_tomlc99 				= tomlc99
SP_SRCS_tomlc99 				= toml.c
SP_SRCD_tomlc99					= $(SUBPROJECTS)/$(SP_NAME_$(1))
SP_OBJS_tomlc99 				= $(SP_SRCS_$(1):.c=.o)
SP_INCS_tomlc99 				= -I$(SUBPROJECTS)/$(SP_NAME_$(1))
SP_HDRS_tomlc99 				= $(SP_SRCS_$(1):.c=.h)
SP_HDRD_tomlc99					= $(SUBPROJECTS)/$(SP_NAME_$(1))

# Build dynamic, static libraries
SP_LIB_NAME_tomlc99 		= tomlc99
$(eval $($(call shared_lib_tmpl,$(SP_LIB_NAME_tomlc99))))
$(eval $($(call static_lib_tmpl,$(SP_LIB_NAME_tomlc99))))
