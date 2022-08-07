define shared_lib_tmpl
SP_SHARED_$(1) = $$(SP_BDIR_$(1))/lib$(SP_LIB_NAME_$(1)).so
endef

define static_lib_tmpl
SP_STATIC_$(1) = $$(SP_BDIR_$(1))/lib$(SP_LIB_NAME_$(1)).a
endef
