FILES = build/kernel.asm.o

all: bin/boot.bin bin/kernel.bin
	dd if=bin/boot.bin >> bin/os.bin
	dd if=bin/kernel.bin >> bin/os.bin
	dd if=/dev/zero bs=512 count=100 >> bin/os.bin

bin/kernel.bin: $(FILES)
	ld -m elf_i386 -g -relocatable $(FILES) -o build/kernelfull.o
	gcc -m32 -T src/linker.ld -o bin/kernel.bin -ffreestanding -nostdlib build/kernelfull.o

bin/boot.bin: src/impl/x86_64/boot/boot.asm bin/boot.bin
	nasm -f bin src/impl/x86_64/boot/boot.asm -o bin/boot.bin

build/kernel.asm.o: src/impl/x86_64/kernel.asm build/kernel.asm.o
	nasm -f elf32 -g src/impl/x86_64/kernel.asm -o build/kernel.asm.o

clean:
	rm -rf bin/boot.bin
	rm -rf bin/kernel.bin
	rm -rf bin/os.bin
	rm -rf $(FILES)
	rm -rf build/kernelfull.bin

#kernel_source_files := $(shell find src/impl/kernel -name *.c)
#kernel_object_files := $(patsubst src/impl/kernel/%.c, build/kernel/%.o, $(kernel_source_files))
#
#x86_64_c_source_files := $(shell find src/impl/x86_64 -name *.c)
#x86_64_c_object_files := $(patsubst src/impl/x86_64/%.c, build/x86_64/%.o, $(x86_64_c_source_files))
#
#x86_64_asm_source_files := src/impl/x86_64/kernel.asm#$(shell find src/impl/x86_64 -name *.asm)
#x86_64_asm_object_files := $(patsubst src/impl/x86_64/%.asm, build/x86_64/%.o, $(x86_64_asm_source_files))
#
#x86_64_bootloader_source_files := $(shell find src/impl/x86_64/boot -name *.asm)
#x86_64_bootloader_bin_files := $(patsubst src/impl/x86_64/boot/%.asm, build/x86_64/boot/%.bin, $(x86_64_bootloader_source_files))
#
#x86_64_fullkernel_files := build/x86_64/kernelfull.o
#
#x86_64_object_files := $(x86_64_c_object_files) $(x86_64_asm_object_files) $(x86_64_bootloader_bin_files) $(x86_64_fullkernel_files)
#
#$(kernel_object_files): build/kernel/%.o : src/impl/kernel/%.c
#	mkdir -p $(dir $@)
#	x86_64-elf-gcc -c -I src/intf -ffreestanding -nostdlib $(patsubst build/kernel/%.o, src/impl/kernel/%.c, $@) -o $@
#
#$(x86_64_c_object_files): build/x86_64/%.o : src/impl/x86_64/%.c
#	mkdir -p $(dir $@)
#	x86_64-elf-gcc -c -I src/intf -ffreestanding -nostdlib $(patsubst build/x86_64/%.o, src/impl/x86_64/%.c, $@) -o $@
#
#$(x86_64_asm_object_files): build/x86_64/%.o : src/impl/x86_64/%.asm
#	mkdir -p $(dir $@) && \
#	nasm -f elf64 $(patsubst build/x86_64/%.o, src/impl/x86_64/%.asm, $@) -o $@
#
#$(x86_64_bootloader_bin_files): build/x86_64/%.o : src/impl/x86_64/%.asm
#	mkdir -p $(dir $@) && \
#	nasm -f bin -g $(patsubst build/x86_64/%.bin, src/impl/x86_64/%.asm, $@) -o $@
#
#$(x86_64_fullkernel_files): $(x86_64_asm_object_files) $(x86_64_bootloader_bin_files)
#	x86_64-elf-ld -g -relocatable $(x86_64_asm_object_files) -o $(x86_64_fullkernel_files)
#	x86_64-elf-gcc -T targets/x86_64/linker.ld -o $(x86_64_bootloader_bin_files) -ffreestanding -nostdlib $(x86_64_fullkernel_files)
#
#.PHONY: build-x86_64
#build-x86_64: $(kernel_object_files) $(x86_64_object_files)
#	rm -rf targets/x86_64/os.bin
#	dd if=$(strip $(x86_64_bootloader_bin_files)) >> targets/x86_64/os.bin
#	dd if=$(strip $(x86_64_asm_object_files)) >> targets/x86_64/os.bin
#	dd if=/dev/zero bs=512 count=100 >> targets/x86_64/os.bin
#
#
#x86_64-elf-ld -n -o targets/x86_64/os.bin -T targets/x86_64/linker.ld $(kernel_object_files) $(x86_64_object_files)