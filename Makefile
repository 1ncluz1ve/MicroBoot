.DEFAULT_GOAL := all 

all: build run clean
QEMU = /mnt/c/Program\ Files/qemu/qemu-system-x86_64.exe

build:boot.asm
	nasm -f bin boot.asm -o boot.bin

run: boot.bin
	$(QEMU) -drive format=raw,file=boot.bin

clean:
	rm boot.bin