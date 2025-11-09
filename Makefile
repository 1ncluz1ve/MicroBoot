 DEFAULT_GOAL := all 

all: build run clean
QEMU = qemu-system-x86_64

build:boot.asm
	nasm -f bin boot.asm -o boot.bin

run: boot.bin
	$(QEMU) -drive format=raw,file=boot.bin

clean:
	rm boot.bin
