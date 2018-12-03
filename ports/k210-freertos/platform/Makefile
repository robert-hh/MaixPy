#
# Makefile for maixpy
# ports/k210-freetos/mpy_support/Makefile
#
.PHONY:all import_mk

OUTPUT_STATIC_LIB := mpy_support.a
define mod_echo_func
	@echo "\033[;34m"$(1)"\033[;34m";
endef

define sub_make
	$(call mod_echo_func,$(dir $(1)))
	$(MAKE) -C $(basename $(patsubst %/,%,$(patsubst ./%,%,$(dir $(1))))) all
endef
MAKEFILE_LIST_LASTWORD = $(lastword $(MAKEFILE_LIST))
MAKEFILE_PATH := $(abspath $(MAKEFILE_LIST_LASTWORD))
MAKEFILE_DIR := $(dir $(MAKEFILE_PATH))
MAKEFILE_DIR_PATSUBST := $(patsubst %/,%,$(MAKEFILE_DIR))
CURRENT_DIR := $(notdir $(MAKEFILE_DIR_PATSUBST))

GET_SUBDIRS1 := $(shell find . -maxdepth 1 -type d)
GET_SUBDIRS2 := $(basename $(patsubst ./%,%,$(GET_SUBDIRS1)))
SUBDIRS := $(GET_SUBDIRS2)

SRC_C := $(wildcard *.c))
SRC_CPP := $(wildcard *.cpp)

AllDirs := $(shell ls -R | grep '^\./.*:$$' | awk '{gsub(":","");print}') .
FILE_MK := $(foreach n,$(AllDirs) , $(wildcard $(n)/*.mk))

FILE_MAKEFILE := $(foreach n,$(SUBDIRS) , $(wildcard $(n)/Makefile))

define import_mk_func
include $(1)
endef

compile:
	$(call mod_echo_func,"Compiling "$(FILE_MAKEFILE)" ...")
	$(foreach n,$(FILE_MAKEFILE),$(call sub_make, $(n)))

import_mk:
	$(call mod_echo_func,"FILE_MK "$(FILE_MK)" ...")
	$(foreach n,$(FILE_MK),$(call import_mk_func, $(n)))

all:$(import_mk)$(compile)
	$(call mod_echo_func,"cd "$(CURRENT_DIR)" ...")
	
