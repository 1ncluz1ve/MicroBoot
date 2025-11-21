# Makefile — bootloader build & debug helpers
NASM  := nasm
QEMU  := qemu-system-x86_64
OUT   := boot.bin
ASM   := boot.asm

QEMU_OPTS      := -drive format=raw,file=$(OUT)
QEMU_NOREBOOT  := -drive format=raw,file=$(OUT) -no-reboot -serial stdio
QEMU_FLOPPY    := -fda $(OUT) -serial stdio

.PHONY: all build run run-noreboot run-floppy debug gdb run-log clean

# default: just build
all: build run clean 

build: $(ASM)
	$(NASM) -f bin $(ASM) -o $(OUT)

# normal run (boots, may auto-reboot on triple-fault)
run: $(OUT)
	$(QEMU) $(QEMU_OPTS)

# run but don't reboot on fault and attach serial to stdout (useful to see messages)
run-noreboot: $(OUT)
	$(QEMU) $(QEMU_NOREBOOT)

# boot as a floppy device (useful in some QEMU configs)
run-floppy: $(OUT)
	$(QEMU) $(QEMU_FLOPPY)

# run with logging to qemu.log (instructions + interrupts). Good for diagnosing faults.
run-log: $(OUT)
	$(QEMU) -d in_asm,int -D qemu.log $(QEMU_NOREBOOT)

# debug: start qemu halted and open gdb server on tcp/1234. Attach with gdb to step through.
debug: $(OUT)
	$(QEMU) -S -s $(QEMU_NOREBOOT)

# Start gdb connected to qemu (helper, needs gdb installed)
gdb:
	gdb -ex "target remote :1234"

clean:
	rm -f $(OUT) qemu.log

