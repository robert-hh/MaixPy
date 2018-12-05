#
# Makefile for maixpy
# ports/k210-freetos/Makefile
#
.PHONY: all clean compile do_mk
CUR_DIR := $(shell pwd)/
###################################
# USER OPTION
LIB_NAME ?= maixpy
CROSS_COMPILE ?= 
MK_VALUE :="INC := "".""\r\n"
MK_VALUE +="INC += ""include/""\r\n"
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

GET_SUBDIRS1 := $(shell find . -maxdepth 1 -type d)
GET_SUBDIRS2 := $(basename $(patsubst ./%,%,$(GET_SUBDIRS1)))
SUBDIRS := $(GET_SUBDIRS2)

AllDirs := $(shell ls -R | grep '^\./.*:$$' | awk '{gsub(":","");print}') .
PLATFORM_MK := $(foreach n,$(AllDirs) , $(wildcard $(n)/$(PLATFORM).mk))

define update_sub_platform_mk
	if [ -f $(dir $(1)),"./" ] ; \
	then \
		cat $(PLATFORM).mk>$(1);\
	fi;
endef

FILE_MK := $(foreach n,$(SUBDIRS) , $(wildcard $(n)/mk))

all:$(do_mk)
# $(call mod_echo_func,"AllDirs"$(AllDirs)" ...")
	@make update_all_platform_mk
	make update_mk
	make compile
	$(call mod_echo_func,"compile "$(SUBDIRS))

compile:
	$(call mod_echo_func,"Compiling "$(SUBDIRS)" ...")
	$(foreach n,$(SUBDIRS),$(call sub_make, $(n)))

update_mk:
	$(call mod_echo_func,"update mk file"" ...")
	$(shell echo $(MK_VALUE)$(foreach n,$(FILE_MK),"sinclude "$(n)"\r\n") > mk)

update_all_platform_mk:
	if [ -f $(PLATFORM).mk ] ; \
	then \
	     $(foreach n,$(PLATFORM_MK),$(call update_sub_platform_mk, $(n))) \
	fi;

clean:
	rm -f mk
	$(call mod_echo_func,"Cleaning "$(SUBDIRS)" ...")
	$(foreach n,$(SUBDIRS),$(call sub_clean, $(n)))


