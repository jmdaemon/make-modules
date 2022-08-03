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
	REP_VMA = (Get-Content $(VS_OBJ)) -replace '@CMAKE_PROJECT_VERSION_MAJOR@', '$(VERSION_MAJOR)' | Out-File -encoding ASCII $(VS_OBJ)
	REP_VMI = (Get-Content $(VS_OBJ)) -replace '@CMAKE_PROJECT_VERSION_MINOR@', '$(VERSION_MINOR)' | Out-File -encoding ASCII $(VS_OBJ)
	REP_PAT = (Get-Content $(VS_OBJ)) -replace '@CMAKE_PROJECT_VERSION_PATCH@', '$(VERSION_PATCH)' | Out-File -encoding ASCII $(VS_OBJ)
	RMDIR = rd /s /q # Command-Prompt friendly
  else # in a bash-like shell, like msys
	CLEANUP = rm -f
	MKDIR = mkdir -p
	COPY = cp -rf
	RMDIR = rm -rf
	REP_VMA = sed -i "s/@CMAKE_PROJECT_VERSION_MAJOR@/$(VERSION_MAJOR)/g" $(VS_OBJ)
	REP_VMI = sed -i "s/@CMAKE_PROJECT_VERSION_MINOR@/$(VERSION_MINOR)/g" $(VS_OBJ)
	REP_PAT = sed -i "s/@CMAKE_PROJECT_VERSION_PATCH@/$(VERSION_PATCH)/g" $(VS_OBJ)
  endif
	TARGET_EXTENSION=exe
	SHARED_LIBRARY_EXT=dll
	SHARED_LIBRARY_EXT=lib
else
	CLEANUP = rm -f
	MKDIR = mkdir -p
	COPY = cp -rf
	RMDIR = rm -rf
	REP_VMA = sed -i "s/@CMAKE_PROJECT_VERSION_MAJOR@/$(VERSION_MAJOR)/g" $(VS_OBJ)
	REP_VMI = sed -i "s/@CMAKE_PROJECT_VERSION_MINOR@/$(VERSION_MINOR)/g" $(VS_OBJ)
	REP_PAT = sed -i "s/@CMAKE_PROJECT_VERSION_PATCH@/$(VERSION_PATCH)/g" $(VS_OBJ)
	TARGET_EXTENSION=out
	SHARED_LIBRARY_EXT=so
	STATIC_LIBRARY_EXT=a
endif

