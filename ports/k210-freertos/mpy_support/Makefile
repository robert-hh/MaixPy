#
# Makefile for maixpy
# ports/k210-freetos/mpy_support/Makefile
#
.PHONY:all update_mk compile
CUR_DIR_ADDR := $(shell pwd)/
###############################################################################
# USER OPTIONS
LIB_NAME ?= mpy_support
CROSS_COMPILE ?= 
MK_VALUE :="INC += "$(CUR_DIR_ADDR)"\n"
MK_VALUE +="INC += "$(CUR_DIR_ADDR)"include/""\n"
MK_VALUE +="INC += "$(CUR_DIR_ADDR)"../../../""\n"
OUTPUT_STATIC_LIB := $(LIB_NAME).a
CXX ?= $(CROSS_COMPILE)c++
AR ?= $(CROSS_COMPILE)AR
OUTPUT_DIR := build/
###############################################################################
# MPY OPTIONS
# include ../../../py/mkenv.mk需要比较靠前
include ../../../py/mkenv.mk
# qstr definitions (must come before including py.mk)
QSTR_DEFS = qstrdefsport.h
# include py core make definitionsvers/uarths.c
include ../../../py/py.mk
MPY_EXT_SRC_C := \
		lib/utils/stdout_helpers.c \
		lib/utils/interrupt_char.c \
		lib/utils/pyexec.c \
		lib/libc/string0.c \
		lib/mp-readline/readline.c \
		lib/netutils/netutils.c \
		lib/timeutils/timeutils.c \
		lib/utils/sys_stdio_mphal.c
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
# IMPORT MK FILE
# sinclude mk MICROPYTHON NEED OTHER MK,SO I INCLUDE THE MK WHERE IS IN ROOT DIR
sinclude ../mk
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
###############################################################################
GET_SUBDIRS1 := $(shell find . -maxdepth 1 -type d)
GET_SUBDIRS2 := $(basename $(patsubst ./%,%,$(GET_SUBDIRS1)))
SUBDIRS := $(GET_SUBDIRS2)

# AllDirs := $(shell ls -R | grep '^\./.*:$$' | awk '{gsub(":","");print}') .
FILE_MK := $(foreach n,$(SUBDIRS) , $(wildcard $(n)/mk))
FILE_MAKEFILE := $(foreach n,$(SUBDIRS) , $(wildcard $(n)/Makefile))

all: update_mk sub_compile compile

$(BUILD)/_frozen_mpy.c: frozentest.mpy $(BUILD)/genhdr/qstrdefs.generated.h
	$(ECHO) "MISC freezing bytecode"
	$(Q)$(TOP)/tools/mpy-tool.py -f -q $(BUILD)/genhdr/qstrdefs.preprocessed.h -mlongint-impl=none $< > $@

###############################################################################
# COMPILE CUR SRC FILE
SRC_C := $(wildcard *.c))
SRC_CPP := $(wildcard *.cpp)
SRC_C += $(MPY_EXT_SRC_C)
C_OBJ := $(addprefix $(OUTPUT_DIR)/, $(SRC_C:.c=.o))
OBJ += $(PY_O) $(C_OBJ) #USE MPY COMPILE SRICPT COMPILE SRC FILE
CXX_OBJ := $(addprefix $(BUILD)/, $(SRC_CPP:.cpp=.o))
INCLUDE_FLAGS := $(addprefix -I, $(INC))
CFLAGS += $(INCLUDE_FLAGS)
$(CXX_OBJ):%.o:%.cpp
	mkdir -p $(dir $(OUTPUT_DIR)) 
	$(Q)$(CXX)  -o $(OUTPUT_DIR)/$@ -c $< -I$(INC) $(CXXFLAGS) -lstdc++

compile: $(OBJ) $(CXX_OBJ)

$(OUTPUT_STATIC_LIB):
	$(AR) rcs -o $@ $(CXX_OBJ) $(OBJ)
###############################################################################

sub_compile:
	$(foreach n,$(FILE_MAKEFILE),$(call sub_make,$(n)))

update_mk:
#-rm -f mk
# $(call mod_echo_func,"INC "$(INC)" ...")
	$(call mod_echo_func,"CFLAGS "$(CFLAGS)" ...")
	$(call mod_echo_func,"update mk file"" ...")
	$(shell echo $(MK_VALUE)$(foreach n,$(FILE_MK),"sinclude "$(CUR_DIR_ADDR)$(n)"\n") > mk)
	
clean:
	rm -f mk
	$(call mod_echo_func,"Cleaning "$(SUBDIRS)" ...")
	$(foreach n,$(FILE_MAKEFILE),$(call sub_clean, $(n)))

include $(TOP)/py/mkrules.mk
	
