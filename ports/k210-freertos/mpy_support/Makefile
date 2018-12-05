#
# Makefile for maixpy
# ports/k210-freetos/mpy_support/Makefile
#
.PHONY:all update_mk compile
CUR_DIR := $(shell pwd)/
###################################
# USER OPTION
LIB_NAME ?= mpy_support
CROSS_COMPILE ?= 
MK_VALUE :="INC := "$(CUR_DIR)"\r\n"
MK_VALUE +="INC += "$(CUR_DIR)"include/""\r\n"
OUTPUT_STATIC_LIB := $(LIB_NAME).a
CXX ?= $(CROSS_COMPILE)c++
# qstr definitions (must come before including py.mk)
QSTR_DEFS = qstrdefsport.h
# include py core make definitionsvers/uarths.c
include ../../../py/py.mk
####################################
# Optional options
PLATFORM ?=
####################################
exist = $(shell if [ -f $(PLATFORM).mk ]; then echo "exist"; else echo "notexist"; fi;)
ifeq (exist, "notexist")
	sinclude $(PLATFORM).mk
endif

define mod_echo_func
	@echo "\033[;34m"$(1)"\033[;34m";
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

# include ../../../py/mkenv.mk需要比较靠前
include ../../../py/mkenv.mk

sinclude mk

GET_SUBDIRS1 := $(shell find . -maxdepth 1 -type d)
GET_SUBDIRS2 := $(basename $(patsubst ./%,%,$(GET_SUBDIRS1)))
SUBDIRS := $(GET_SUBDIRS2)

SRC_C := $(wildcard *.c))
SRC_CPP := $(wildcard *.cpp)

# AllDirs := $(shell ls -R | grep '^\./.*:$$' | awk '{gsub(":","");print}') .
FILE_MK := $(foreach n,$(SUBDIRS) , $(wildcard $(n)/mk))
FILE_MAKEFILE := $(foreach n,$(SUBDIRS) , $(wildcard $(n)/Makefile))

all:
	make update_mk
	make compile

compile:
	$(call mod_echo_func,"AllDirs "$(AllDirs)" ...")
	$(foreach n,$(FILE_MAKEFILE),$(call sub_make,$(n)))

update_mk:
	$(call mod_echo_func,"update mk file"" ...")
	$(shell echo $(MK_VALUE)$(foreach n,$(FILE_MK),"sinclude "$(n)"\r\n") > mk)
	
clean:
	rm -f mk

	
