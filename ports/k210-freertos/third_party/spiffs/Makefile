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
OUTPUT_DIR := build/
MK_VALUE :="INC += "$(CUR_DIR_ADDR)"\n"
MK_VALUE +="INC += "$(CUR_DIR_ADDR)"spiffs/src""\n"
MK_VALUE +="INC += "$(CUR_DIR_ADDR)"spiffs/src/default""\n"
MK_VALUE +="INC += "$(CUR_DIR_ADDR)"spiffs-port/include""\n"
OUTPUT_STATIC_LIB := $(LIB_NAME).a
SPIFFS_SRC_ROOT_DIR := spiffs
spiffs := $(SPIFFS_SRC_ROOT_DIR)
CXX := $(CROSS_COMPILE)c++
CC := $(CROSS_COMPILE)gcc
AR := $(CROSS_COMPILE)AR
###############################################################################
# Optional options
PLATFORM ?=
###############################################################################
# COMPILE OPTIONS
CFLAGS :=
LDFLAGS :=
CXXFLAGS :=
INC :=
SRC_C :=
C_OBJ :=
CPATH :=
###############################################################################
# IMPORT MK FILE
sinclude spiffs/files.mk
sinclude mk
###############################################################################
# IMPORT PLATFORM OPTIONS
sinclude $(PLATFORM).mk
###############################################################################
# SOME FUNCTIONS
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

SRC_C += $(addprefix $(CPATH)/, $(CFILES))
C_OBJ :=  $(SRC_C:.c=.o)

FILE_MK := $(foreach n,$(SUBDIRS) , $(wildcard $(n)/mk))

INCLUDE_FLAGS := $(addprefix -I, $(INC))

CFLAGS += $(INCLUDE_FLAGS)

$(C_OBJ):%.o:%.c
	mkdir -p $(dir $(OUTPUT_DIR)$@) 
	$(CC)  -o $(OUTPUT_DIR)$@ -c $< $(CFLAGS)

all: update_mk compile $(C_OBJ)

compile:
	$(call mod_echo_func,"AllDirs "$(AllDirs)" ...")
# $(foreach n,$(FILE_MAKEFILE),$(call sub_make,$(n)))

update_mk:
	$(call mod_echo_func,"update mk file"$(FILE_MK)" ...")
	$(shell echo -e $(MK_VALUE)$(foreach n,$(FILE_MK),"include "$(CUR_DIR_ADDR)$(n)"\n") > mk)

clean:
	rm -f mk
	rm -rf build

