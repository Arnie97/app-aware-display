.PHONY: build debug release milky

CC       := gcc
CCFLAGS  += -std=c99 -pedantic -Wall
LDFLAGS  += -mwindows
MILKYC   ?= milky

MSOURCES  := app-aware-display.c.k asprintf.c.k shell.c.k
MINCLUDES := $(wildcard *.h.k)
SOURCES   := $(sort $(wildcard *.c) $(MSOURCES:%.c.k=%.c))
INCLUDES  := $(sort $(wildcard *.h) $(MINCLUDES:%.h.k=%.h))
RESDEFS   := $(wildcard *.rc)
OBJECTS   := $(SOURCES:%.c=obj/%.o)
RESOURCES := $(RESDEFS:%.rc=obj/%.res)
TARGET    := app-aware-display

build: $(TARGET)
debug: CCFLAGS += -ggdb -D _DEBUG
debug: build
release: CCFLAGS += -O3 -s
release: build

milky:
	@$(MILKYC) $(MSOURCES) $(MINCLUDES)
	@printf '\n'

$(TARGET): milky $(OBJECTS) $(RESOURCES)
	@mkdir -p `dirname $@`
	@echo "Linking $@..."
	@$(CC) $(OBJECTS) $(RESOURCES) $(LDFLAGS) -o $@
	@echo "Construction complete."

$(OBJECTS): obj/%.o: %.c
	@mkdir -p `dirname $@`
	@echo "Generating dependencies for $<..."
	@$(call make-depend,$<,$@,$(subst .o,.d,$@))
	@echo "Compiling $<..."
	@$(CC) $(CCFLAGS) -c $< -o $@

$(RESOURCES): obj/%.res: %.rc
	@mkdir -p `dirname $@`
	@echo "Compiling resource $<..."
	@windres $< -O coff -o $@

# $(call make-depend,source-file,object-file,depend-file)
define make-depend
	$(CC) -MM -MP -MT $2 -MF $3 $(CCFLAGS) $1
endef
