VERSION_MAJOR = 0
VERSION_MINOR = 1
VERSION_PATCH = 0

VS_SRC = include/version.h.in
VS_OBJ = $(PATHD)/version.h

version: $(VS_OBJ)

$(VS_OBJ): $(VS_SRC) Makefile
	$(COPY) $(VS_SRC) $(VS_OBJ)
	$(REP_VMA)
	$(REP_VMI)
	$(REP_PAT)

clean-ver:
	$(CLEANUP) $(VS_OBJ)
	
CLEAN_TARGET += clean-ver
