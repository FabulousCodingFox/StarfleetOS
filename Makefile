GCC_FLAGS = -g -fno-pie -ffreestanding -falign-jumps -falign-functions -falign-labels -falign-loops -fstrength-reduce -fomit-frame-pointer -finline-functions -Wno-unused-function -fno-builtin -Werror -Wno-unused-label -Wno-cpp -Wno-unused-parameter -nostdlib -nostartfiles -nodefaultlibs -Wall -O0 -Iinc
LD_INCLUDES = -I src/intf/

KERNEL_ASM_FILES = $(strip $(patsubst src/impl/%.asm, build/%.asm.o, src/impl/x86_64/kernel.asm src/impl/kernel/idt/idt.asm src/impl/kernel/io/io.asm))
KERNEL_BOOTLOADER_FILES = $(strip $(patsubst src/impl/x86_64/boot/%.asm, bin/%.bin, $(shell find src/impl/x86_64/boot -name *.asm)))
KERNEL_C_FILES = $(strip $(patsubst src/impl/kernel/%.c, build/kernel/%.o, $(shell find src/impl/kernel -name *.c)))
ALL_COMPILEABLE_FILES = $(strip $(KERNEL_ASM_FILES) $(KERNEL_C_FILES))
ALL_FILES = $(strip $(KERNEL_ASM_FILES) $(KERNEL_C_FILES) $(KERNEL_BOOTLOADER_FILES))

all: bin/boot.bin bin/kernel.bin
	dd if=bin/boot.bin >> bin/os.bin
	dd if=bin/kernel.bin >> bin/os.bin
	dd if=/dev/zero bs=512 count=100 >> bin/os.bin

bin/kernel.bin: $(ALL_COMPILEABLE_FILES)
	ld -m elf_i386 -g -relocatable $(ALL_COMPILEABLE_FILES) -o build/kernelfull.o
	gcc -m32 $(GCC_FLAGS) -T src/linker.ld -o bin/kernel.bin -ffreestanding -nostdlib -O0 build/kernelfull.o

$(KERNEL_BOOTLOADER_FILES): bin/%.bin : src/impl/x86_64/boot/%.asm
	mkdir -p $(dir $@)
	nasm -f bin $(patsubst bin/%.bin, src/impl/x86_64/boot/%.asm, $@) -o $@

$(KERNEL_ASM_FILES): build/x86_64/%.asm.o : src/impl/x86_64/%.asm
	mkdir -p $(dir $@)
	nasm -f elf32 -g $(patsubst build/%.asm.o, src/impl/%.asm, $@) -o $@

$(KERNEL_C_FILES): build/kernel/%.o : src/impl/kernel/%.c
	mkdir -p $(dir $@)
	gcc -m32 $(LD_INCLUDES) $(GCC_FLAGS) -std=gnu99 -c $(patsubst build/kernel/%.o, src/impl/kernel/%.c, $@) -o $@

clean:
	rm -rf bin/boot.bin
	rm -rf bin/kernel.bin
	rm -rf bin/os.bin
	rm -rf $(ALL_FILES)
	rm -rf build/kernelfull.bin