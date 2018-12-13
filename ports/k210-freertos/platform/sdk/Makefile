#
.PHONY:all update_mk compile
###################################
# USER OPTION
LIB_NAME ?= sdk
CROSS_COMPILE ?=
OUTPUT_DIR :=build/
####################################
# Optional options
PLATFORM ?=
####################################
SDK_GIT_ADDR := https://github.com/kendryte/kendryte-freertos-sdk.git
SDK_GIT_BRANCH := develop
CUR_DIR_ADDR := $(shell pwd)/
SDK_DIR_NAME :=kendryte-freertos-sdk
SDK_DIR_ADDR := $(CUR_DIR_ADDR)$(SDK_DIR_NAME)/

MK_VALUE :=
MK_VALUE +="INC += "$(SDK_DIR_ADDR)"lib/arch/include/""\r\n"
MK_VALUE +="INC += "$(SDK_DIR_ADDR)"lib/bsp/include/""\r\n"
MK_VALUE +="INC += "$(SDK_DIR_ADDR)"lib/drivers/include/""\r\n"
MK_VALUE +="INC += "$(SDK_DIR_ADDR)"lib/freertos/conf/""\r\n"
MK_VALUE +="INC += "$(SDK_DIR_ADDR)"lib/freertos/include/""\r\n"
MK_VALUE +="INC += "$(SDK_DIR_ADDR)"lib/freertos/kernel/""\r\n"
MK_VALUE +="INC += "$(SDK_DIR_ADDR)"lib/freertos/portable/""\r\n"
MK_VALUE +="INC += "$(SDK_DIR_ADDR)"lib/hal/include/""\r\n"
MK_VALUE +="INC += "$(SDK_DIR_ADDR)"lib/posix/include/""\r\n"
MK_VALUE +="INC += "$(SDK_DIR_ADDR)"lib/utils/include/""\r\n"
MK_VALUE +="INC += "$(SDK_DIR_ADDR)"third_party/fatfs/source/""\r\n"
MK_VALUE +="INC += "$(SDK_DIR_ADDR)"third_party/""\r\n"

MK_VALUE +="liba-bsp := "$(CUR_DIR_ADDR)$(OUTPUT_DIR)"SDK/bsp/libbsp.a""\r\n"
MK_VALUE +="liba-hal := "$(CUR_DIR_ADDR)$(OUTPUT_DIR)"SDK/hal/libhal.a""\r\n"
MK_VALUE +="liba-posix := "$(CUR_DIR_ADDR)$(OUTPUT_DIR)"SDK/posix/libposix.a""\r\n"
MK_VALUE +="liba-fatfs := "$(CUR_DIR_ADDR)$(OUTPUT_DIR)"third_party/fatfs/libfatfs.a""\r\n"
MK_VALUE +="liba-drivers := "$(CUR_DIR_ADDR)$(OUTPUT_DIR)"SDK/drivers/libdrivers.a""\r\n"
MK_VALUE +="liba-libfreertos := "$(CUR_DIR_ADDR)$(OUTPUT_DIR)"SDK/freertos/libfreertos.a""\r\n"
MK_VALUE +="output-file += "'$$(liba-bsp) $$(liba-hal) $$(liba-posix) $$(liba-fatfs) $$(liba-drivers) $$(liba-libfreertos)'"\r\n"
MK_VALUE +="platform-lds += "$(CUR_DIR_ADDR)"kendryte-freertos-sdk/lds/kendryte.ld""\r\n"
####################################

define mod_echo_func
	@echo "\033[;34m"$(1)"\033[;34m";
endef

all: build_env compile update_mk

build_env:
	if [ ! -d $(SDK_DIR_NAME) ] ; \
	then \
	     git clone -b $(SDK_GIT_BRANCH) $(SDK_GIT_ADDR);\
		 cd $(SDK_DIR_NAME) && patch -p1 -u < ../freeRTOS.patch && cd -; \
	fi;

compile:
	-mkdir build
	cd build && cmake ../$(SDK_DIR_NAME)/ -DPROJ=hello_world -DTOOLCHAIN=$(dir $(CROSS_COMPILE)) && make

update_mk:
	$(call mod_echo_func,"update mk file"" ...")
	$(shell echo $(MK_VALUE) > mk)

clean:
	rm -rf build
	rm -f mk
	
	
