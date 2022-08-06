# Make Modules

This repository contains some make module recipes for various C libraries.

- `binary.mk`: Rules for creating, installing, configuring debug/release binaries.
- `config.mk`: Configure and toggle debug/release versions.
- `docs.mk`: Rule for building docs + automatically builds docs with other targets.
- `install.mk`: Create installation rules, sets install path.
- `library.mk`: Rules for creating, installing, configuring debug/release libraries.
- `os.mk`: Sets operating specific commands & functions
- `structure.mk`: Sets the project folder/tree structure
- `version.mk`: Single source project versions.

Note that most of these files assume that you are following/using the
common structure listed in `structure.mk`, and `config.mk`.

## Binary

To use `binary.mk`, configure these variables:

``` make
BINARY_SRCS = main.c
BINARY_OBJS = $(BINARY_SRCS:.c=.o)
BINARY_NAME = main
```

## Library

To use `library.mk`:

``` make
LIBRARY_SRCS = $(BINARY_SRCS)
LIBRARY_OBJS = $(LIBRARY_SRCS:.c=.o)
LIBRARY_NAME = libmain.$(SHARED_LIBRARY_EXT)
```

## Using Library Modules

To include a library module:

1. Define SP_DEPENDS, SP_INCLUDES
2. Include this make module:
    ``` make
      include log.c.mk
    ```
3. Add $(SP_DEPENDS) to your link target:
    ``` make
    bin: $(SP_DEPENDS)
    ```
4. Add `$(SP_INCLUDES)` headers to your targets:
    ``` make
    $(EXE_DEPS)/%.o: $(PATHS)/%.c $(SP_DEPENDS)
        @echo "Compiling main binary target source"
        $(CC) -c $(EXE_FLAGS) $(SP_INCLUDES) -o $@ $<
    ```
5. Run your make commands to build your targets
