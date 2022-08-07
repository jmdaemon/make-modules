#
# Unit Testing
#

# Unity Source Directory
PATHU = subprojects/unity/src

BUILD_PATHS = $(PATHB) $(PATHD) $(PATHO) $(PATHR)

SRCT = $(wildcard $(PATHT)/*.c)

# Unit Test Compiler Flags:
# -MM : Output single header dependencies for the compile files
# -MG : Run without being able to run into headers gcc can't find
# -MF : Write header dependencies to a file
TEST_COMPILE=gcc -c
TEST_LINK=gcc $(GLOBAL_LDFLAGS)
TEST_DEPEND=gcc -MM -MG -MF
TEST_CFLAGS= $(GLOBAL_CFLAGS) $(INCLUDES) -I$(PATHU) -I$(PATHS) -DTEST

# Unit Tests Results
# Note: Our files will be named:
# [source].c, test_[source].c
# Due to these substitutions they must be named like this
# in order for the tests to work and compile
RESULTS = $(patsubst $(PATHT)/test_%.c,$(PATHR)/test_%.txt,$(SRCT) )
PASSED = `grep -s PASS $(PATHR)/*.txt`
FAIL = `grep -s FAIL $(PATHR)/*.txt`
IGNORE = `grep -s IGNORE $(PATHR)/*.txt`

# Unit Test Rules

.PHONY: test clean-test

test: $(BUILD_PATHS) $(RESULTS) $(SP_DEPENDS)
	@echo "-----------------------\nIGNORES:\n-----------------------"
	@echo "$(IGNORE)"
	@echo "-----------------------\nFAILURES:\n-----------------------"
	@echo "$(FAIL)"
	@echo "-----------------------\nPASSED:\n-----------------------"
	@echo "$(PASSED)"
	@echo "\nDONE"

# Rules for finding source files in sub directories

# Create test results
$(PATHR)/%.txt: $(PATHB)/%.$(TARGET_EXTENSION)
	-./$< > $@ 2>&1

# Link unit tests with the unity test framework and our sources
$(PATHB)/test_%.$(TARGET_EXTENSION): $(PATHO)/test_%.o $(PATHO)/%.o $(PATHU)/unity.o $(SP_DEPENDS)
	$(TEST_LINK) $(SP_INCLUDES) $(TEST_CFLAGS) -o $@ $^

# Compile unity sources
$(PATHO)/%.o:: $(PATHU)/%.c $(PATHU)/%.h $(SP_SOURCES)
	$(TEST_COMPILE) $(TEST_CFLAGS) $(SP_INCLUDES) $< -o $@

# Compile files in src directory
$(PATHO)/%.o:: $(PATHS)/%.c $(SP_SOURCES)
	$(TEST_COMPILE) $(TEST_CFLAGS) $(GLOBAL_LDFLAGS) $(SP_INCLUDES) $< -o $@

# Compile files in test directory
$(PATHO)/%.o:: $(PATHT)/%.c $(SP_SOURCES)
	$(TEST_COMPILE) $(TEST_CFLAGS) $(GLOBAL_LDFLAGS) $(SP_INCLUDES) $< -o $@

# Create a depends directory
$(PATHD)/%.d:: $(PATHT)/%.c $(SP_SOURCES) $(SP_INCLUDES)
	$(TEST_DEPEND) $@ $<

#
# Unit test build paths
#

$(PATHB):
	$(MKDIR) $(PATHB)

$(PATHD):
	$(MKDIR) $(PATHD)

$(PATHO):
	$(MKDIR) $(PATHO)

$(PATHR):
	$(MKDIR) $(PATHR)

# Remove output files for tests
clean-test:
	@echo "Removing project test output"
	$(CLEANUP) $(PATHO)/*.o
	$(CLEANUP) $(PATHB)/*.$(TARGET_EXTENSION)
	$(CLEANUP) $(PATHR)/*.txt

# Keep test results & output
.PRECIOUS: $(PATHB)/test_%.$(TARGET_EXTENSION)
.PRECIOUS: $(PATHD)/%.d
.PRECIOUS: $(PATHO)/%.o
.PRECIOUS: $(PATHR)/%.txt

CLEAN_TARGET += clean-test
