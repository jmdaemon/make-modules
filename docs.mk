#
# Documentation
# 

DOC_HTML = build/docs/html
DOC_SRC = index.html
DOC_OBJ = $(DOC_HTML)/$(DOC_SRC)

docs: $(DOC_OBJ)

$(DOC_OBJ): $(EXE_DEPS)/*.o $(PATHS)/*.c $(PATHI)/*.h Doxyfile
	@echo Building Docs
	@doxygen

clean-docs:
	$(RMDIR) build/docs

CLEAN_TARGET += clean-docs
