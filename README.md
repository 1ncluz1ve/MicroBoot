# x86 Bootloader

A minimal bootloader written in x86 assembly for learning bare-metal programming and OS development.

## Description

This project implements a simple bootloader that runs directly on x86 hardware or in an emulator. It demonstrates fundamental concepts of BIOS interaction, real mode programming, and the boot process that occurs before an operating system loads.

The bootloader is loaded by the BIOS at memory address 0x7C00, initializes the display, and can perform basic I/O operations using BIOS interrupts.

## Features

- Written in NASM assembly (Intel syntax)
- 512-byte boot sector implementation
- BIOS interrupt handling for screen output
- Compatible with QEMU and real hardware
- Makefile for easy building and testing

## Prerequisites

Before building and running this bootloader, you need:

- **NASM assembler** - For assembling x86 assembly code
- **QEMU** - x86 emulator for testing (or use real hardware)
- **Make** - Build automation tool

### Installing Prerequisites

**On Ubuntu/Debian:**
