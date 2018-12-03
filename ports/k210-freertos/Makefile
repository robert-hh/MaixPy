#
# Makefile for maixpy
# ports/k210-freetos/Makefile
#
.PHONY: all clean compile platform mpy_support

include mpy_support.mk

CROSS_COMPILE ?= 
define sub_make
	$(MAKE) -C $(1) all;
endef
define mod_echo_func
	@echo "\033[;31m"$(1)"\033[;31m";
endef
LIB_PATH = $(dir $(CROSS_COMPILE))

GET_SUBDIRS1 := $(shell find . -maxdepth 1 -type d)
GET_SUBDIRS2 := $(basename $(patsubst ./%,%,$(GET_SUBDIRS1)))
SUBDIRS := $(GET_SUBDIRS2)

AllDirs := $(shell ls -R | grep '^\./.*:$$' | awk '{gsub(":","");print}') .

set_env:export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(LIB_PATH)

update_mk:
	$(call mod_echo_func,"FILE_MK "$(FILE_MK)" ...")
	$(foreach n,$(FILE_MK),$(call import_mk_func, $(n)))

compile:
	$(call mod_echo_func,"Compiling "$(SUBDIRS)" ...")
	$(foreach n,$(SUBDIRS),$(call sub_make, $(n)))

all:$(set_env) $(compile)
	$(call mod_echo_func,"compile "$(SUBDIRS)) CROSS_COMPILE=$(CROSS_COMPILE)
	


