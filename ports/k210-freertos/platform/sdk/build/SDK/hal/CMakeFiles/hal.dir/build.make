# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/kendryte-freertos-sdk

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build

# Include any dependencies generated for this target.
include SDK/hal/CMakeFiles/hal.dir/depend.make

# Include the progress variables for this target.
include SDK/hal/CMakeFiles/hal.dir/progress.make

# Include the compile flags for this target's objects.
include SDK/hal/CMakeFiles/hal.dir/flags.make

SDK/hal/CMakeFiles/hal.dir/clint.c.obj: SDK/hal/CMakeFiles/hal.dir/flags.make
SDK/hal/CMakeFiles/hal.dir/clint.c.obj: /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/kendryte-freertos-sdk/lib/hal/clint.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object SDK/hal/CMakeFiles/hal.dir/clint.c.obj"
	cd /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build/SDK/hal && /home/xiaohui/workspace/dan/kendryte-toolchain/bin//riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/hal.dir/clint.c.obj   -c /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/kendryte-freertos-sdk/lib/hal/clint.c

SDK/hal/CMakeFiles/hal.dir/clint.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/hal.dir/clint.c.i"
	cd /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build/SDK/hal && /home/xiaohui/workspace/dan/kendryte-toolchain/bin//riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/kendryte-freertos-sdk/lib/hal/clint.c > CMakeFiles/hal.dir/clint.c.i

SDK/hal/CMakeFiles/hal.dir/clint.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/hal.dir/clint.c.s"
	cd /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build/SDK/hal && /home/xiaohui/workspace/dan/kendryte-toolchain/bin//riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/kendryte-freertos-sdk/lib/hal/clint.c -o CMakeFiles/hal.dir/clint.c.s

SDK/hal/CMakeFiles/hal.dir/clint.c.obj.requires:

.PHONY : SDK/hal/CMakeFiles/hal.dir/clint.c.obj.requires

SDK/hal/CMakeFiles/hal.dir/clint.c.obj.provides: SDK/hal/CMakeFiles/hal.dir/clint.c.obj.requires
	$(MAKE) -f SDK/hal/CMakeFiles/hal.dir/build.make SDK/hal/CMakeFiles/hal.dir/clint.c.obj.provides.build
.PHONY : SDK/hal/CMakeFiles/hal.dir/clint.c.obj.provides

SDK/hal/CMakeFiles/hal.dir/clint.c.obj.provides.build: SDK/hal/CMakeFiles/hal.dir/clint.c.obj


SDK/hal/CMakeFiles/hal.dir/fpioa.c.obj: SDK/hal/CMakeFiles/hal.dir/flags.make
SDK/hal/CMakeFiles/hal.dir/fpioa.c.obj: /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/kendryte-freertos-sdk/lib/hal/fpioa.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object SDK/hal/CMakeFiles/hal.dir/fpioa.c.obj"
	cd /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build/SDK/hal && /home/xiaohui/workspace/dan/kendryte-toolchain/bin//riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/hal.dir/fpioa.c.obj   -c /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/kendryte-freertos-sdk/lib/hal/fpioa.c

SDK/hal/CMakeFiles/hal.dir/fpioa.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/hal.dir/fpioa.c.i"
	cd /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build/SDK/hal && /home/xiaohui/workspace/dan/kendryte-toolchain/bin//riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/kendryte-freertos-sdk/lib/hal/fpioa.c > CMakeFiles/hal.dir/fpioa.c.i

SDK/hal/CMakeFiles/hal.dir/fpioa.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/hal.dir/fpioa.c.s"
	cd /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build/SDK/hal && /home/xiaohui/workspace/dan/kendryte-toolchain/bin//riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/kendryte-freertos-sdk/lib/hal/fpioa.c -o CMakeFiles/hal.dir/fpioa.c.s

SDK/hal/CMakeFiles/hal.dir/fpioa.c.obj.requires:

.PHONY : SDK/hal/CMakeFiles/hal.dir/fpioa.c.obj.requires

SDK/hal/CMakeFiles/hal.dir/fpioa.c.obj.provides: SDK/hal/CMakeFiles/hal.dir/fpioa.c.obj.requires
	$(MAKE) -f SDK/hal/CMakeFiles/hal.dir/build.make SDK/hal/CMakeFiles/hal.dir/fpioa.c.obj.provides.build
.PHONY : SDK/hal/CMakeFiles/hal.dir/fpioa.c.obj.provides

SDK/hal/CMakeFiles/hal.dir/fpioa.c.obj.provides.build: SDK/hal/CMakeFiles/hal.dir/fpioa.c.obj


SDK/hal/CMakeFiles/hal.dir/sysctl.c.obj: SDK/hal/CMakeFiles/hal.dir/flags.make
SDK/hal/CMakeFiles/hal.dir/sysctl.c.obj: /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/kendryte-freertos-sdk/lib/hal/sysctl.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object SDK/hal/CMakeFiles/hal.dir/sysctl.c.obj"
	cd /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build/SDK/hal && /home/xiaohui/workspace/dan/kendryte-toolchain/bin//riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/hal.dir/sysctl.c.obj   -c /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/kendryte-freertos-sdk/lib/hal/sysctl.c

SDK/hal/CMakeFiles/hal.dir/sysctl.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/hal.dir/sysctl.c.i"
	cd /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build/SDK/hal && /home/xiaohui/workspace/dan/kendryte-toolchain/bin//riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/kendryte-freertos-sdk/lib/hal/sysctl.c > CMakeFiles/hal.dir/sysctl.c.i

SDK/hal/CMakeFiles/hal.dir/sysctl.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/hal.dir/sysctl.c.s"
	cd /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build/SDK/hal && /home/xiaohui/workspace/dan/kendryte-toolchain/bin//riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/kendryte-freertos-sdk/lib/hal/sysctl.c -o CMakeFiles/hal.dir/sysctl.c.s

SDK/hal/CMakeFiles/hal.dir/sysctl.c.obj.requires:

.PHONY : SDK/hal/CMakeFiles/hal.dir/sysctl.c.obj.requires

SDK/hal/CMakeFiles/hal.dir/sysctl.c.obj.provides: SDK/hal/CMakeFiles/hal.dir/sysctl.c.obj.requires
	$(MAKE) -f SDK/hal/CMakeFiles/hal.dir/build.make SDK/hal/CMakeFiles/hal.dir/sysctl.c.obj.provides.build
.PHONY : SDK/hal/CMakeFiles/hal.dir/sysctl.c.obj.provides

SDK/hal/CMakeFiles/hal.dir/sysctl.c.obj.provides.build: SDK/hal/CMakeFiles/hal.dir/sysctl.c.obj


SDK/hal/CMakeFiles/hal.dir/uarths.c.obj: SDK/hal/CMakeFiles/hal.dir/flags.make
SDK/hal/CMakeFiles/hal.dir/uarths.c.obj: /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/kendryte-freertos-sdk/lib/hal/uarths.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object SDK/hal/CMakeFiles/hal.dir/uarths.c.obj"
	cd /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build/SDK/hal && /home/xiaohui/workspace/dan/kendryte-toolchain/bin//riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/hal.dir/uarths.c.obj   -c /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/kendryte-freertos-sdk/lib/hal/uarths.c

SDK/hal/CMakeFiles/hal.dir/uarths.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/hal.dir/uarths.c.i"
	cd /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build/SDK/hal && /home/xiaohui/workspace/dan/kendryte-toolchain/bin//riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/kendryte-freertos-sdk/lib/hal/uarths.c > CMakeFiles/hal.dir/uarths.c.i

SDK/hal/CMakeFiles/hal.dir/uarths.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/hal.dir/uarths.c.s"
	cd /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build/SDK/hal && /home/xiaohui/workspace/dan/kendryte-toolchain/bin//riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/kendryte-freertos-sdk/lib/hal/uarths.c -o CMakeFiles/hal.dir/uarths.c.s

SDK/hal/CMakeFiles/hal.dir/uarths.c.obj.requires:

.PHONY : SDK/hal/CMakeFiles/hal.dir/uarths.c.obj.requires

SDK/hal/CMakeFiles/hal.dir/uarths.c.obj.provides: SDK/hal/CMakeFiles/hal.dir/uarths.c.obj.requires
	$(MAKE) -f SDK/hal/CMakeFiles/hal.dir/build.make SDK/hal/CMakeFiles/hal.dir/uarths.c.obj.provides.build
.PHONY : SDK/hal/CMakeFiles/hal.dir/uarths.c.obj.provides

SDK/hal/CMakeFiles/hal.dir/uarths.c.obj.provides.build: SDK/hal/CMakeFiles/hal.dir/uarths.c.obj


SDK/hal/CMakeFiles/hal.dir/utility.c.obj: SDK/hal/CMakeFiles/hal.dir/flags.make
SDK/hal/CMakeFiles/hal.dir/utility.c.obj: /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/kendryte-freertos-sdk/lib/hal/utility.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building C object SDK/hal/CMakeFiles/hal.dir/utility.c.obj"
	cd /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build/SDK/hal && /home/xiaohui/workspace/dan/kendryte-toolchain/bin//riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/hal.dir/utility.c.obj   -c /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/kendryte-freertos-sdk/lib/hal/utility.c

SDK/hal/CMakeFiles/hal.dir/utility.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/hal.dir/utility.c.i"
	cd /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build/SDK/hal && /home/xiaohui/workspace/dan/kendryte-toolchain/bin//riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/kendryte-freertos-sdk/lib/hal/utility.c > CMakeFiles/hal.dir/utility.c.i

SDK/hal/CMakeFiles/hal.dir/utility.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/hal.dir/utility.c.s"
	cd /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build/SDK/hal && /home/xiaohui/workspace/dan/kendryte-toolchain/bin//riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/kendryte-freertos-sdk/lib/hal/utility.c -o CMakeFiles/hal.dir/utility.c.s

SDK/hal/CMakeFiles/hal.dir/utility.c.obj.requires:

.PHONY : SDK/hal/CMakeFiles/hal.dir/utility.c.obj.requires

SDK/hal/CMakeFiles/hal.dir/utility.c.obj.provides: SDK/hal/CMakeFiles/hal.dir/utility.c.obj.requires
	$(MAKE) -f SDK/hal/CMakeFiles/hal.dir/build.make SDK/hal/CMakeFiles/hal.dir/utility.c.obj.provides.build
.PHONY : SDK/hal/CMakeFiles/hal.dir/utility.c.obj.provides

SDK/hal/CMakeFiles/hal.dir/utility.c.obj.provides.build: SDK/hal/CMakeFiles/hal.dir/utility.c.obj


# Object files for target hal
hal_OBJECTS = \
"CMakeFiles/hal.dir/clint.c.obj" \
"CMakeFiles/hal.dir/fpioa.c.obj" \
"CMakeFiles/hal.dir/sysctl.c.obj" \
"CMakeFiles/hal.dir/uarths.c.obj" \
"CMakeFiles/hal.dir/utility.c.obj"

# External object files for target hal
hal_EXTERNAL_OBJECTS =

SDK/hal/libhal.a: SDK/hal/CMakeFiles/hal.dir/clint.c.obj
SDK/hal/libhal.a: SDK/hal/CMakeFiles/hal.dir/fpioa.c.obj
SDK/hal/libhal.a: SDK/hal/CMakeFiles/hal.dir/sysctl.c.obj
SDK/hal/libhal.a: SDK/hal/CMakeFiles/hal.dir/uarths.c.obj
SDK/hal/libhal.a: SDK/hal/CMakeFiles/hal.dir/utility.c.obj
SDK/hal/libhal.a: SDK/hal/CMakeFiles/hal.dir/build.make
SDK/hal/libhal.a: SDK/hal/CMakeFiles/hal.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Linking C static library libhal.a"
	cd /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build/SDK/hal && $(CMAKE_COMMAND) -P CMakeFiles/hal.dir/cmake_clean_target.cmake
	cd /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build/SDK/hal && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/hal.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
SDK/hal/CMakeFiles/hal.dir/build: SDK/hal/libhal.a

.PHONY : SDK/hal/CMakeFiles/hal.dir/build

SDK/hal/CMakeFiles/hal.dir/requires: SDK/hal/CMakeFiles/hal.dir/clint.c.obj.requires
SDK/hal/CMakeFiles/hal.dir/requires: SDK/hal/CMakeFiles/hal.dir/fpioa.c.obj.requires
SDK/hal/CMakeFiles/hal.dir/requires: SDK/hal/CMakeFiles/hal.dir/sysctl.c.obj.requires
SDK/hal/CMakeFiles/hal.dir/requires: SDK/hal/CMakeFiles/hal.dir/uarths.c.obj.requires
SDK/hal/CMakeFiles/hal.dir/requires: SDK/hal/CMakeFiles/hal.dir/utility.c.obj.requires

.PHONY : SDK/hal/CMakeFiles/hal.dir/requires

SDK/hal/CMakeFiles/hal.dir/clean:
	cd /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build/SDK/hal && $(CMAKE_COMMAND) -P CMakeFiles/hal.dir/cmake_clean.cmake
.PHONY : SDK/hal/CMakeFiles/hal.dir/clean

SDK/hal/CMakeFiles/hal.dir/depend:
	cd /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/kendryte-freertos-sdk /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/kendryte-freertos-sdk/lib/hal /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build/SDK/hal /home/xiaohui/workspace/dan/temp/k210-freertos-mpy-makefile/ports/k210-freertos/platform/sdk/build/SDK/hal/CMakeFiles/hal.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : SDK/hal/CMakeFiles/hal.dir/depend
