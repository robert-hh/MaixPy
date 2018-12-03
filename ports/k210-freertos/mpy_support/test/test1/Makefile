GET_SUBDIRS1 := $(shell find . -maxdepth 1 -type d)
GET_SUBDIRS2 := $(basename $(patsubst ./%,%,$(GET_SUBDIRS1)))
SUBDIRS := $(GET_SUBDIRS2)
FILE_MAKEFILE := $(foreach n,$(SUBDIRS) , $(wildcard $(n)/Makefile))

compile:
	$(call mod_echo_func,"Compiling "$(FILE_MAKEFILE)" ...")
	$(foreach n,$(FILE_MAKEFILE),$(call sub_make, $(n)))

all: $(compile)
	@echo "11111111111111testttttttttt"
