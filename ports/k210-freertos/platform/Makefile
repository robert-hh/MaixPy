#
# Makefile for maixpy
# ports/k210-freetos/mpy_support/Makefile
#
.PHONY:all update_mk compile
CUR_DIR_ADDR := $(shell pwd)/
###############################################################################
# USER OPTION
LIB_NAME ?= platform
CROSS_COMPILE ?= 
MK_VALUE :="INC += "$(CUR_DIR_ADDR)"\n"
MK_VALUE +="INC += "$(CUR_DIR_ADDR)"include/""\n"
OUTPUT_STATIC_LIB := $(LIB_NAME).a
###############################################################################
# Optional options
PLATFORM ?=
###############################################################################
# COMPILE OPTIONS
CFLAGS :=
LDFLAGS :=
CXXFLAGS :=
INC :=
###############################################################################
define mod_echo_func
	@echo "\033[;34m"$(1)"\033[;34m";
endef
define sub_clean
	$(MAKE) -C $(1) clean CROSS_COMPILE=$(CROSS_COMPILE) PLATFORM=$(PLATFORM);
endef
define sub_make
	$(call mod_echo_func,$(dir $(1)))
	$(MAKE) -C $(basename $(patsubst %/,%,$(patsubst ./%,%,$(dir $(1))))) all CROSS_COMPILE=$(CROSS_COMPILE) PLATFORM=$(PLATFORM)

endef

# MAKEFILE_LIST_LASTWORD = $(lastword $(MAKEFILE_LIST))
# MAKEFILE_PATH := $(abspath $(MAKEFILE_LIST_LASTWORD))
# MAKEFILE_DIR := $(dir $(MAKEFILE_PATH))
# MAKEFILE_DIR_PATSUBST := $(patsubst %/,%,$(MAKEFILE_DIR))
# CURRENT_DIR := $(notdir $(MAKEFILE_DIR_PATSUBST))

sinclude mk

GET_SUBDIRS1 := $(shell find . -maxdepth 1 -type d)
GET_SUBDIRS2 := $(basename $(patsubst ./%,%,$(GET_SUBDIRS1)))
SUBDIRS := $(GET_SUBDIRS2)

SRC_C := $(wildcard *.c))
SRC_CPP := $(wildcard *.cpp)

# AllDirs := $(shell ls -R | grep '^\./.*:$$' | awk '{gsub(":","");print}') .
FILE_MK := $(foreach n,$(SUBDIRS) , $(wildcard $(n)/mk))
FILE_MAKEFILE := $(foreach n,$(SUBDIRS) , $(wildcard $(n)/Makefile))

all: update_mk compile
	$(call mod_echo_func,"CUR_DIR "$(CUR_DIR)" ...")

compile:
	$(call mod_echo_func,"AllDirs "$(AllDirs)" ...")
	$(foreach n,$(FILE_MAKEFILE),$(call sub_make,$(n)))

update_mk:
	$(call mod_echo_func,"update mk file"$(FILE_MK)" ...")
	$(shell echo $(MK_VALUE)$(foreach n,$(FILE_MK),"include "$(CUR_DIR_ADDR)$(n)"\n") > mk)

clean:
	rm -f mk
	$(call mod_echo_func,"Cleaning "$(SUBDIRS)" ...")
	$(foreach n,$(FILE_MAKEFILE),$(call sub_clean, $(dir $(n))))

