.PHONY: clean compile

define mod_echo_func
	@echo "\033[;36m"$(1)"\033[;36m";
endef

define sub_make
	$(call mod_echo_func,$(dir $(1)))
	$(MAKE) -C $(basename $(patsubst %/,%,$(patsubst ./%,%,$(dir $(1))))) all
endef

GET_SUBDIRS1 := $(shell find . -maxdepth 1 -type d)
GET_SUBDIRS2 := $(basename $(patsubst ./%,%,$(GET_SUBDIRS1)))
SUBDIRS := $(GET_SUBDIRS2)
FILE_MAKEFILE := $(foreach n,$(SUBDIRS) , $(wildcard $(n)/Makefile))

compile:
	$(call mod_echo_func,"Compiling "$(FILE_MAKEFILE)" ...")
	$(foreach n,$(FILE_MAKEFILE),$(call sub_make, $(n)))

all:
	$(MAKE) -C test1 all
	$(compile)
	$(call mod_echo_func,"tttttttestttttttttt")
