bits 16
org 0x7c00      ;It is a directive which tells that the code will be loaded at a memory address 0x7c00

mov ah,0xe
mov si,msg

print_loop:
    lodsb       ;Loads the next character in msg
    cmp al,0    ;Compares if al = 0 or not
    je hang     ;if al = 0 then cpu will hang the execution of the instruction
    int 0x10    ;BIOS Interuppt for writing character on the screen
    jmp print_loop      ;Repeat the loop

hang:
    hlt
    jmp hang

msg db "Hello World" ,0 ; Null terminated string

;Bootloader signature 
times 510-($-$$) db 0
dw 0xaa55