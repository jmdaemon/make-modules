# Initialize the project structure

#
# Project Structure
#

# These are used to generate the build structure:
# - src
# - test
# - include
# - subprojects
# - build
# - build/{debug, release}
# - build/{debug, release}/lib/
# - build/{debug, release}/bin/

# Directories

PATHS := src
PATHT := test
PATHB := build/make
PATHI := include

PATHD := $(PATHB)/depends
PATHO := $(PATHB)/objs
PATHR := $(PATHB)/results

SUBPROJECTS := subprojects
