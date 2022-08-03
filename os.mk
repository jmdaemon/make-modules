#
# Operating Systems
#
# Enable build system compatibility for other operating systems

# Usage:
# Add this line to the top of your Makefile:
# 	include os.mk
# Now you can use these variables at your discretion

ifeq ($(OS),Windows_NT)
  ifeq ($(shell uname -s),) # not in a bash-like shell
	CLEANUP = del /F /Q
	MKDIR = mkdir
	COPY = Xcopy /E /I
  else # in a bash-like shell, like msys
	CLEANUP = rm -f
	MKDIR = mkdir -p
	COPY = cp -rf
  endif
	TARGET_EXTENSION=exe
	SHARED_LIBRARY_EXT=dll
	SHARED_LIBRARY_EXT=lib
else
	CLEANUP = rm -f
	MKDIR = mkdir -p
	COPY = cp -rf
	TARGET_EXTENSION=out
	SHARED_LIBRARY_EXT=so
	STATIC_LIBRARY_EXT=a
endif

