#
# Build settings
#
# Toggle between release and debug configurations

# Usage:
# 1. Include this make module after you've defined your target's sources
# You can include this module with:
# 	include config.mk
# 2. Use $(TARGET_DIR) and the $(TARGET_FLAGS) variables

# Build in release mode by default
TARGET:=release
TARGET_FLAGS:= $(REL_CFLAGS)

# Release settings
ifeq ($(filter release,$(MAKECMDGOALS)),release)
TARGET = release
TARGET_FLAGS = $(REL_CFLAGS)
endif

# Debug build settings
ifeq ($(filter debug,$(MAKECMDGOALS)),debug)
TARGET = debug
TARGET_FLAGS = $(DBG_CFLAGS)
endif

# Debug or Release target directory
TARGET_DIR = $(PATHB)/$(TARGET)
