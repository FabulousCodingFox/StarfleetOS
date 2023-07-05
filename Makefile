all:
	nasm -f bin src/boot.asm -o ./build/boot.bin
	dd if=./src/message.txt >> ./build/boot.bin
	dd if=/dev/zero bs=512 count=1 >> ./build/boot.bin