#
# Makefile for maixpy
# ports/k210-freetos/Makefile
#
.PHONY: all clean compile do_mk update_all_platform_mk
CUR_DIR := $(shell pwd)/
###################################
# USER OPTION
LIB_NAME ?= maixpy
CROSS_COMPILE ?= 
MK_VALUE :="INC := "".""\n"
MK_VALUE +="INC += ""include/""\n"
OUTPUT_STATIC_LIB := $(LIB_NAME).a
####################################
# Optional options
PLATFORM ?=
####################################

sinclude $(PLATFORM).mk

define sub_clean
	$(MAKE) -C $(1) clean CROSS_COMPILE=$(CROSS_COMPILE) PLATFORM=$(PLATFORM);
endef

define sub_make
	$(MAKE) -C $(1) all CROSS_COMPILE=$(CROSS_COMPILE) PLATFORM=$(PLATFORM);
endef

define mod_echo_func
	@echo "\033[;31m"$(1)"\033[;31m";
endef

define update_sub_platform_mk
	if [ "$(dir $(1))" != "./" ] ; \
	then \
		cat $(PLATFORM).mk>$(1); \
	fi;
endef

GET_SUBDIRS1 := $(shell find . -maxdepth 1 -type d)
GET_SUBDIRS2 := $(basename $(patsubst ./%,%,$(GET_SUBDIRS1)))
SUBDIRS := $(GET_SUBDIRS2)

AllDirs := $(shell ls -R | grep '^\./.*:$$' | awk '{gsub(":","");print}') .
PLATFORM_MK := $(foreach n,$(AllDirs) , $(wildcard $(n)/$(PLATFORM).mk))
FILE_MAKEFILE := $(foreach n,$(SUBDIRS) , $(wildcard $(n)/Makefile))

FILE_MK := $(foreach n,$(SUBDIRS) , $(wildcard $(n)/mk))

all: do_mk update_all_platform_mk update_mk compile
	

compile:
	$(call mod_echo_func,"Compiling "$(SUBDIRS)" ...")
	$(foreach n,$(FILE_MAKEFILE),$(call sub_make, $(dir $(n))))
	$(call mod_echo_func,"compile "$(SUBDIRS)" .")

update_mk:
	$(call mod_echo_func,"update mk file"" ...")
	$(shell echo -e $(MK_VALUE)$(foreach n,$(FILE_MK),"sinclude "$(CUR_DIR_ADDR)$(n)"\n") > mk)

update_all_platform_mk:
	$(call mod_echo_func,"PLATFORM_MK"$(PLATFORM_MK)" ...")
	if [ -f $(PLATFORM).mk ] ; \
	then \
	     $(foreach n,$(PLATFORM_MK),$(call update_sub_platform_mk, $(n))) \
	fi;
	
clean:
	rm -f mk
	$(call mod_echo_func,"Cleaning "$(SUBDIRS)" ...")
	$(foreach n,$(FILE_MAKEFILE),$(call sub_clean, $(n)))


