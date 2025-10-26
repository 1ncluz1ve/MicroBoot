bits 16
org 0x7c00      ;It is a directive which tells that the code will be loaded at a memory address 0x7c00


mov ah,0x06
mov al,0x00
int 0x10

mov ah, 0x0e    ; The code code starts here
mov si, msg

print_loop:
    lodsb       ;Loads the next character in msg
    cmp al,0    ;Compares if al = 0 or not
    je hang     ;if al = 0 then cpu will hang the execution of the instruction
    int 0x10    ;BIOS Interuppt for writing character on the screen
    jmp print_loop      ;Repeat the loop

    

hang:
    hlt
    jmp hang

real_mode_msg db "This is Real Mode", 0; Null terminated String
msg db "World, World!" , 0 ; Null terminated String
;Bootloader signature 
times 510-($-$$) db 0
dw 0xaa55