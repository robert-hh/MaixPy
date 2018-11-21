.PHONY: clean_all build packfs pack patch_py recover_py micropython micropython.bin
include ../../py/mkenv.mk

CROSS_COMPILE_BIN ?=/home/xiaohui/workspace/dan/kendryte-toolchain/bin
CROSS_COMPILE ?= $(CROSS_COMPILE_BIN)/riscv64-unknown-elf-
SDK_PATH ?= kendryte-freertos-sdk
MPY_MOD_PATH ?= mpy-mod
FS_PORT_PATH ?= spiffs-port
BOARD_DRIVERS_PATH ?= board-drivers
OUT_BIN_FILENAME ?= micropython.bin
CXX ?= $(CROSS_COMPILE)c++
# qstr definitions (must come before including py.mk)
QSTR_DEFS = qstrdefsport.h

FROZEN_MPY_DIR ?= builtin-py

# include py core make definitionsvers/uarths.c
include $(TOP)/py/py.mk

# mpy header
INC += -I.
INC += -I$(TOP)
INC += -I$(BUILD)
INC += -Iconfig
INC += -Iinclude
INC += -I$(TOP)/lib/timeutils

# mpy mod header
INC += -I$(MPY_MOD_PATH)/machine/include
INC += -I$(MPY_MOD_PATH)/uos/include
INC += -I$(MPY_MOD_PATH)/app/include

# board drivers header
INC += -I$(BOARD_DRIVERS_PATH)/include

# spiffs ports header
INC += -Ispiffs-port/include

# sdk header
INC += -I$(SDK_PATH)/lib/arch/include
INC += -I$(SDK_PATH)/lib/bsp/include
INC += -I$(SDK_PATH)/lib/bsp/syscalls
INC += -I$(SDK_PATH)/lib/drivers/include
INC += -I$(SDK_PATH)/lib/freertos/conf
INC += -I$(SDK_PATH)/lib/freertos/include
INC += -I$(SDK_PATH)/lib/freertos/kernel
INC += -I$(SDK_PATH)/lib/freertos/portable
INC += -I$(SDK_PATH)/lib/hal/include

INC += -I$(SDK_PATH)/lib/posix/include
INC += -I$(SDK_PATH)/lib/utils/include

INC += -I$(SDK_PATH)/third_party/fatfs/source
INC += -I$(SDK_PATH)/third_party/

# spiffs header
INC += -Ispiffs/src
INC += -Ispiffs/src/default

# compile option
C_DEFINES ?=
C_DEFINES += -DCONFIG_LOG_COLORS \
			 -DCONFIG_LOG_ENABLE \
			 -DCONFIG_LOG_LEVEL=LOG_VERBOSE \
			 -DDEBUG=1 \
			 -DFPGA_PLL \
			 -DLOG_KERNEL \
			 -D__riscv64

CFLAGS = $(INC) \
		 -std=gnu11 \
		 $(CFLAGS_RV64_K210) \
		 -g -Wno-error=unused-label \
		 -Wno-error=unused-const-variable= \
		 -Wno-error=format= \
		 -Wno-error=parentheses \
		 -Wno-error=format= \
		 -Wno=error=pointer-sign


CFLAGS_MOD += $(C_DEFINES)
CFLAGS += $(CFLAGS_MOD)

LDFLAGS = \
		-mcmodel=medany \
		-march=rv64imafdc \
		-fno-common \
		-ffunction-sections \
		-fdata-sections \
		-fstrict-volatile-bitfields \
		-fno-zero-initialized-in-bss \
		-O2 \
		-ggdb \
		-std=gnu11 \
		-Wall \
		-Werror=all \
		-Wno-error=unused-function \
		-Wno-error=unused-but-set-variable \
		-Wno-error=unused-variable \
		-Wno-error=deprecated-declarations \
		-Wno-error=maybe-uninitialized \
		-Wextra \
		-Werror=frame-larger-than=65536 \
		-Wno-unused-parameter \
		-Wno-unused-function \
		-Wno-implicit-fallthrough \
		-Wno-sign-compare \
		-Wno-error=missing-braces \
		-Wno-old-style-declaration \
		-g

	# -Wno-error=unused-but\
	# -Wunused-variable \
	# -T "/home/xiaohui/workspace/dan/temp/kendryte-freertos-sdk/lds/kendryte.ld"
	# "/home/xiaohui/workspace/dan/kendryte-toolchain/bin/../lib/gcc/riscv64-unknown-elf/8.2.0/crti.o"
	# "/home/xiaohui/workspace/dan/kendryte-toolchain/bin/../lib/gcc/riscv64-unknown-elf/8.2.0/crtbegin.o"
	# CMakeFiles/hello_world.dir/src/hello_world/main.c.obj
	# "/home/xiaohui/workspace/dan/kendryte-toolchain/bin/../lib/gcc/riscv64-unknown-elf/8.2.0/crtend.o"
	# "/home/xiaohui/workspace/dan/kendryte-toolchain/bin/../lib/gcc/riscv64-unknown-elf/8.2.0/crtn.o"
	# -lstdc++ SDK/drivers/libdrivers.a
	# -Wl,--end-group SDK/freertos/libfreertos.a SDK/hal/libhal.a
	# -lm SDK/freertos/libfreertos.a
	# -latomic SDK/bsp/libbsp.a

# -lfreertos -latomic -lbsp  -ldrivers
LIBS =

MODULES_SRC_C= \
		$(MPY_MOD_PATH)/uos/moduos.c \


		# $(MPY_MOD_PATH)/machine/modmachine.c \
		# $(MPY_MOD_PATH)/machine/machine_uarths.c \
		# $(MPY_MOD_PATH)/machine/machine_uart.c \
		# $(MPY_MOD_PATH)/machine/machine_pin.c \
		# $(MPY_MOD_PATH)/machine/machine_pwm.c \
		# $(MPY_MOD_PATH)/machine/machine_timer.c \
		# $(MPY_MOD_PATH)/machine/machine_st7789.c \
		# $(MPY_MOD_PATH)/machine/machine_ov2640.c \
		# $(MPY_MOD_PATH)/machine/machine_burner.c \
		# $(MPY_MOD_PATH)/machine/machine_face_detect.c \
		# $(MPY_MOD_PATH)/machine/machine_spiflash.c \
		# $(MPY_MOD_PATH)/machine/machine_zmodem.c \
		# $(MPY_MOD_PATH)/machine/machine_fpioa.c \
		# $(MPY_MOD_PATH)/machine/machine_ws2812.c \
		# $(MPY_MOD_PATH)/machine/machine_test.c \
		# $(MPY_MOD_PATH)/machine/machine_devmem.c\
		# $(MPY_MOD_PATH)/machine/machine_esp8285.c\
		# $(MPY_MOD_PATH)/app/modapp.c \
		# $(MPY_MOD_PATH)/app/vi.c \
		# $(MPY_MOD_PATH)/app/app_vi.c\
		# $(MPY_MOD_PATH)/socket/modsocket.c


LIB_SRC_C ?=
MICROPY_FATFS=1
ifeq ($(MICROPY_FATFS), 1)
LIB_SRC_C += \
lib/oofatfs/ff.c \
lib/oofatfs/option/unicode.c
endif

FS_SRC_C = \
		$(FS_PORT_PATH)/spiffs-port.c \
		spiffs/src/spiffs_cache.c \
		spiffs/src/spiffs_check.c \
		spiffs/src/spiffs_gc.c \
		spiffs/src/spiffs_hydrogen.c \
		spiffs/src/spiffs_nucleus.c \
		file_io.c

BOARD_DRIVERS = $(BOARD_DRIVERS_PATH)/w25qxx.c 
				# $(BOARD_DRIVERS_PATH)/lcd.c \
				# $(BOARD_DRIVERS_PATH)/st7789.c \
				# $(BOARD_DRIVERS_PATH)/ov2640.c \
				# $(BOARD_DRIVERS_PATH)/face_detect.c \
				# $(BOARD_DRIVERS_PATH)/region_layer.c \
				# $(BOARD_DRIVERS_PATH)/uart_core.c \
				# $(BOARD_DRIVERS_PATH)/ws2812b.c \
				# $(BOARD_DRIVERS_PATH)/esp8285.c

MPY_LIB_SRC = lib/timeutils/timeutils.c \
			  lib/utils/sys_stdio_mphal.c


SRC_C = \
		$(MODULES_SRC_C) \
		$(BOARD_DRIVERS) \
		main.c \
		board-drivers/uart_core.c \
		$(MPY_LIB_SRC) \
		$(FS_SRC_C)

BSP_SRC_C = \
		$(SDK_PATH)/lib/bsp/entry_user.c \
		$(SDK_PATH)/lib/bsp/interrupt.c \
		$(SDK_PATH)/lib/bsp/printf.c \
		$(SDK_PATH)/lib/bsp/sleep.c \
		$(SDK_PATH)/lib/bsp/syscalls.c \
		$(SDK_PATH)/lib/bsp/dump.c \
		$(SDK_PATH)/lib/bsp/except.c \
		$(SDK_PATH)/lib/bsp/config/pin_cfg.c

THRID_PARTY_SRC_C = \
		$(SDK_PATH)/third_party/fatfs/source/ff.c \
		$(SDK_PATH)/third_party/fatfs/source/ffsystem.c \
		$(SDK_PATH)/third_party/fatfs/source/ffunicode.c

HAL_SRC_C = \
		$(SDK_PATH)/lib/hal/clint.c \
		$(SDK_PATH)/lib/hal/fpioa.c \
		$(SDK_PATH)/lib/hal/sysctl.c \
		$(SDK_PATH)/lib/hal/uarths.c \
		$(SDK_PATH)/lib/hal/utility.c

FREEERTOS_SRC_C =	\
		$(SDK_PATH)/lib/freertos/core_sync.c \
		$(SDK_PATH)/lib/freertos/croutine.c \
		$(SDK_PATH)/lib/freertos/event_groups.c \
		$(SDK_PATH)/lib/freertos/list.c \
		$(SDK_PATH)/lib/freertos/os_entry.c \
		$(SDK_PATH)/lib/freertos/portable/heap_4.c \
		$(SDK_PATH)/lib/freertos/portable/port.c \
		$(SDK_PATH)/lib/freertos/pthread.c \
		$(SDK_PATH)/lib/freertos/queue.c \
		$(SDK_PATH)/lib/freertos/stream_buffer.c \
		$(SDK_PATH)/lib/freertos/tasks.c \
		$(SDK_PATH)/lib/freertos/timers.c


SRC_CXX = \
		$(SDK_PATH)/lib/bsp/device/aes.cpp \
		$(SDK_PATH)/lib/bsp/device/dmac.cpp \
		$(SDK_PATH)/lib/bsp/device/dvp.cpp \
		$(SDK_PATH)/lib/bsp/device/fft.cpp \
		$(SDK_PATH)/lib/bsp/device/gpio.cpp \
		$(SDK_PATH)/lib/bsp/device/gpiohs.cpp \
		$(SDK_PATH)/lib/bsp/device/i2c.cpp \
		$(SDK_PATH)/lib/bsp/device/i2s.cpp \
		$(SDK_PATH)/lib/bsp/device/plic.cpp \
		$(SDK_PATH)/lib/bsp/device/pwm.cpp \
		$(SDK_PATH)/lib/bsp/device/registry.cpp \
		$(SDK_PATH)/lib/bsp/device/rtc.cpp \
		$(SDK_PATH)/lib/bsp/device/sccb.cpp \
		$(SDK_PATH)/lib/bsp/device/sha256.cpp \
		$(SDK_PATH)/lib/bsp/device/spi.cpp \
		$(SDK_PATH)/lib/bsp/device/timer.cpp \
		$(SDK_PATH)/lib/bsp/device/uart.cpp \
		$(SDK_PATH)/lib/bsp/device/wdt.cpp \
		$(SDK_PATH)/lib/bsp/syscalls/syscalls.cpp \
		$(SDK_PATH)/lib/drivers/src/misc/ws2812b/ws2812b.cpp \
		$(SDK_PATH)/lib/drivers/src/storage/sdcard.cpp \
		$(SDK_PATH)/lib/freertos/kernel/devices.cpp \
		$(SDK_PATH)/lib/freertos/kernel/driver_impl.cpp \
		$(SDK_PATH)/lib/freertos/kernel/storage/filesystem.cpp \
		$(SDK_PATH)/lib/posix/memory.cpp \
		$(SDK_PATH)/lib/posix/posix_conf.cpp \
		$(SDK_PATH)/lib/posix/pthread_cond.cpp \
		$(SDK_PATH)/lib/posix/pthread.cpp \
		$(SDK_PATH)/lib/posix/pthread_mutex.cpp \
		$(SDK_PATH)/lib/posix/utils.cpp

CFLAGS = $(INC) \
		-DCONFIG_LOG_COLORS \
		-DCONFIG_LOG_ENABLE \
		-DCONFIG_LOG_LEVEL=LOG_INFO \
		-DDEBUG=1 \
		-DLOG_KERNEL \
		-D__riscv64 \
		-mcmodel=medany \
		-march=rv64imafdc \
		-fno-common \
		-ffunction-sections \
		-fdata-sections \
		-fstrict-volatile-bitfields \
		-fno-zero-initialized-in-bss \
		-O2 \
		-ggdb \
		-std=gnu11 \
		-Wall \
		-Wno-error=unused-function \
		-Wno-error=unused-but-set-variable \
		-Wno-error=unused-variable \
		-Wno-error=deprecated-declarations \
		-Wno-error=maybe-uninitialized \
		-Wextra \
		-Werror=frame-larger-than=65536 \
		-Wno-unused-parameter \
		-Wno-unused-function \
		-Wno-implicit-fallthrough \
		-Wno-sign-compare \
		-Wno-error=missing-braces \
		-Wno-old-style-declaration \
		-g \
		-Wno-error=format= \
		-Wno-error=pointer-sign

CXXFLAGS := \
		-DCONFIG_LOG_COLORS \
		-DCONFIG_LOG_ENABLE \
		-DCONFIG_LOG_LEVEL=LOG_INFO \
		-DDEBUG=1 \
		-DLOG_KERNEL \
		-D__riscv64 \
		-mcmodel=medany \
		-march=rv64imafdc \
		-fno-common \
		-ffunction-sections \
		-fdata-sections \
		-fstrict-volatile-bitfields \
		-fno-zero-initialized-in-bss \
		-O2 \
		-ggdb \
		-std=gnu++17 \
		-Wall \
		-Wno-error=unused-function \
		-Wno-error=unused-but-set-variable \
		-Wno-error=unused-variable \
		-Wno-error=deprecated-declarations \
		-Wno-error=maybe-uninitialized \
		-Wextra \
		-Werror=frame-larger-than=65536 \
		-Wno-unused-parameter \
		-Wno-unused-function \
		-Wno-implicit-fallthrough \
		-Wno-sign-compare \
		-Wno-error=missing-braces \
		-g \
		-Wno-error=format= \
		-Wno-error=pointer-sign

PY_SRC_C = \
        help.c \
        lib/utils/stdout_helpers.c \
		lib/utils/interrupt_char.c \
		lib/utils/pyexec.c \
		lib/libc/string0.c \
		lib/mp-readline/readline.c \
		lib/netutils/netutils.c
	
ASM_SRCS = $(SDK_PATH)/lib/bsp/crt.S $(SDK_PATH)/lib/freertos/portable/portasm.S

# List of sources for qstr extraction
SRC_QSTR += $(SRC_C)  
# Append any auto-generated sources that are needed by sources listed in SRC_QSTR
SRC_QSTR_AUTO_DEPS +=

SRC_C_OBJ = $(PY_O) $(addprefix $(BUILD)/, $(SRC_C:.c=.o)) $(addprefix $(BUILD)/, $(PY_SRC_C:.c=.o)) 

BSP_OBJ = $(addprefix $(BUILD)/, $(BSP_SRC_C:.c=.o)) $(addprefix $(BUILD)/, $(ASM_SRCS:.S=.o))
THRID_PARTY_OBJ = $(addprefix $(BUILD)/, $(THRID_PARTY_SRC_C:.c=.o))
HAL_OBJ = $(addprefix $(BUILD)/, $(HAL_SRC_C:.c=.o))
FREERTOS_OBJ = $(addprefix $(BUILD)/, $(FREEERTOS_SRC_C:.c=.o))
OBJ += $(SRC_C_OBJ) $(BSP_OBJ) $(THRID_PARTY_OBJ) $(HAL_OBJ) $(FREERTOS_OBJ) 

CXX_OBJ = $(SRC_CXX:.cpp=.o)#  libbsp.a libdrivers.a libfreertos.a libhal.a libposix.a $(addprefix $(BUILD)/, $(SRC_CXX:.cpp=.o))
CXX_OUTPUT_OBJS = $(addprefix $(BUILD)/, $(SRC_CXX:.cpp=.o))
# OBJ += $(CXX_OUTPUT_OBJS)
$(BUILD)/_frozen_mpy.c: frozentest.mpy $(BUILD)/genhdr/qstrdefs.generated.h
	$(ECHO) "MISC freezing bytecode"
	$(Q)$(TOP)/tools/mpy-tool.py -f -q $(BUILD)/genhdr/qstrdefs.preprocessed.h -mlongint-impl=none $< > $@


$(CXX_OBJ):%.o:%.cpp
	mkdir -p $(dir $(BUILD)/$@) 
	$(Q)$(CXX)  -o $(BUILD)/$@ -c $< -I$(INC) $(LIBS) $(CXXFLAGS) -lstdc++

# PROG = micropython
TF_LITE_LD_FLAGS ?= tensorflow-lite/lib/libtensorflow-lite.a
TEST_FALGS ?= $(CROSS_COMPILE_BIN)/../lib/gcc/riscv64-unknown-elf/8.2.0/crti.o 
TEST_FALGS += $(CROSS_COMPILE_BIN)/../lib/gcc/riscv64-unknown-elf/8.2.0/crtbegin.o $(SRC_C_OBJ)
TEST_FALGS += $(CROSS_COMPILE_BIN)/../lib/gcc/riscv64-unknown-elf/8.2.0/crtend.o
TEST_FALGS += $(CROSS_COMPILE_BIN)/../lib/gcc/riscv64-unknown-elf/8.2.0/crtn.o

LDFLAGS += \
		-nostartfiles \
		-static \
		-Wl,--gc-sections \
		-Wl,-static \
		-Wl,--start-group \
		-Wl,--whole-archive \
		-Wl,--no-whole-archive \
		-Wl,--end-group \
		-Wl,-EL \
		-T \
		"$(SDK_PATH)/lds/kendryte.ld" \
		$(TEST_FALGS) \
		-Wl,--start-group \
		-lm \
		$(FREERTOS_OBJ) \
		-latomic \
		$(BSP_OBJ) \
		-lc \
		-lstdc++ \
		$(CXX_OUTPUT_OBJS) \
		-Wl,--end-group \
		$(THRID_PARTY_OBJ) \
		$(HAL_OBJ) \
		-lm \
		-lstdc++ \
		-lm

all: $(OBJ) $(CXX_OBJ)
	make $(OUT_BIN_FILENAME)


micropython:
	$(ECHO) "LINK $@"
	$(Q)$(CC)  -o $@ $(LIBS) $(LDFLAGS) $(CFLAGS) $(TF_LITE_LD_FLAGS)
	# $(Q)$(CC) -o $@ $(OBJ) -mcmodel=medany -march=rv64imafdc -fno-common -ffunction-sections -fdata-sections -fstrict-volatile-bitfields -fno-zero-initialized-in-bss -O2 -ggdb -std=gnu11 -Wall -Werror=all -Wno-error=unused-function -Wno-error=unused-but-set-variable -Wno-error=unused-variable -Wno-error=deprecated-declarations -Wno-error=maybe-uninitialized -Wextra -Werror=frame-larger-than=65536 -Wno-unused-parameter -Wno-unused-function -Wno-implicit-fallthrough -Wno-sign-compare -Wno-error=missing-braces -Wno-old-style-declaration -g   -nostartfiles -static -Wl,--gc-sections -Wl,-static -Wl,--start-group -Wl,--whole-archive -Wl,--no-whole-archive -Wl,--end-group -Wl,-EL -T "/home/xiaohui/workspace/dan/temp/kendryte-freertos-sdk/lds/kendryte.ld" "/home/xiaohui/workspace/dan/kendryte-toolchain/bin/../lib/gcc/riscv64-unknown-elf/8.2.0/crti.o" "/home/xiaohui/workspace/dan/kendryte-toolchain/bin/../lib/gcc/riscv64-unknown-elf/8.2.0/crtbegin.o" "/home/xiaohui/workspace/dan/kendryte-toolchain/bin/../lib/gcc/riscv64-unknown-elf/8.2.0/crtend.o" "/home/xiaohui/workspace/dan/kendryte-toolchain/bin/../lib/gcc/riscv64-unknown-elf/8.2.0/crtn.o" -Wl,--start-group -lm libfreertos.a -latomic libbsp.a -lc -lstdc++ libdrivers.a -Wl,--end-group libfreertos.a libhal.a -lm libfatfs.a -lstdc++ -lm 
	$(Q)$(SIZE) $@

$(OUT_BIN_FILENAME): micropython
	$(OBJCOPY) --output-format=binary micropython $(OUT_BIN_FILENAME)
	cp $(OUT_BIN_FILENAME) bin_file

clean_all:  
			# rm -f $(CXX_OBJ)
			rm -f $(OBJ)
			make clean
			rm -rf micropython $(OUT_BIN_FILENAME)
			make -C ../../mpy-cross clean
			rm -rf ./bin_file/$(OUT_BIN_FILENAME)
			rm -rf ./bin_file/fs.bin
			rm -rf ./bin_file/firmware.bin
			rm -rf ./sipeedm1.kfpkg
build:
	rm -rf kendryte-standalone-sdk kendryte-standalone-sdk-0.4.1 v0.4.1.zip
	wget https://github.com/kendryte/kendryte-standalone-sdk/archive/v0.4.1.zip
	unzip v0.4.1.zip
	rm -rf v0.4.1.zip
	mv kendryte-standalone-sdk-0.4.1 kendryte-standalone-sdk
	cd kendryte-standalone-sdk && patch -p1 -u < ../sdk.patch && cd -

packfs:
	rm -rf fs.bin
	make -C pack/mkfs/mkspiffs/ clean && make -C pack/mkfs/mkspiffs/ all
	pack/mkfs/mkspiffs/mkspiffs -c fs_path/ fs.bin
	mv fs.bin bin_file

pack_bin:   packfs	
	pack/pack.sh

pack_kfpkg: packfs
	pack/pack_zip.sh

include $(TOP)/py/mkrules.mk
