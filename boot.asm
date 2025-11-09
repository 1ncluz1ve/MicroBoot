bits 16
org 0x7c00      ;It is a directive which tells that the code will be loaded at a memory address 0x7c00


mov ah,0x06
mov al,0x00
int 0x10

mov ah, 0x0e    ; The code starts here
mov si, msg

print_loop:
    lodsb       ;Loads the next character in msg
    cmp al,0    ;Compares if al = 0 or not
    je print_new_line     ;if al = 0 then cpu will hang the execution of the instruction
    int 0x10    ;BIOS Interuppt for writing character on the screen
    jmp print_loop      ;Repeat the loop

print_new_line:
    mov al,0x0A
    int 0x10
    mov al,0x0D
    int 0x10

mov si,real_mode_msg

print_sec_msg:
    lodsb
    cmp al,0
    je a20_enable
    int 0x10
    jmp print_sec_msg
    

a20_enable:     ; This Label enable the A20 line which helps in accessing memory more that 1MB
    in al,0x92
    or al,2;
    out 0x92,al

load_gdt:
    lgdt [gdt_ptr]      ; Loads the address of the gdt in the cpu register gdtr

hang:
    hlt
    jmp hang

real_mode_msg db "This is Real/ and After that the Protected Mode will begin", 0; Null terminated String
msg db "Hello, World!" , 0 ; Null terminated String

; Global Descriptor Table (GDT)
gdt_start:
  dd 0x0
  dd 0x0

gdt_code:
  dw 0xFFFF
  dw 0x0000
  db 0x00
  db 10011010b
  db 11001111b
  db 0x00

gdt_data:
  dw 0xFFFF
  dw 0x0000
  db 0x00
  db 10010010b
  db 11001111b
  db 0x00

gdt_end:

gdt_ptr:
  dw gdt_end - gdt_start - 1
  dd gdt_start

  






;Bootloader signature 
times 510-($-$$) db 0
dw 0xaa55

