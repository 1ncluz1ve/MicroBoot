; Bootloader which starts in 16-Bits Real Mode and then enters into 32-bits Protected Mode
[BITS 16]
org 0x7c00

start:
  cli
  cld

  ;Set up Segments for Real Mode
  xor ax,ax
  mov ds, ax
  mov es, ax
  mov ss, ax
  mov sp, 0x7c00

  mov si, msg16

;===================================
;     Printing 16 bit message
;===================================


.print_msg16:
  lodsb
  cmp al,0
  je .new_line
  mov ah, 0x0E
  int 0x10
  jmp .print_msg16


.new_line:
  mov al,0x0A
  int 0x10
  mov al,0x0D
  int 0x10



;========================
;     Enable A20 Line
;========================

.a20_enable:
  in al, 0x92
  or al, 2
  out 0x92, al

;==========================
;       Load GDT
;==========================

  lgdt [gdt_descriptor]

.enable_protected_mode:
  cli
  mov eax, cr0
  or eax, 1
  mov cr0, eax

  ;Far jump to CS and enter 32-bit Mode
  jmp 0x08:protected_mode_start


;==========================
;         GDT SECTION
;==========================
gdt_start:

gdt_null:
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

gdt_descriptor:
  dw gdt_end - gdt_start - 1
  dd gdt_start


;================================
;       32-bit Protected Mode
;================================
[BITS 32]

protected_mode_start:
  mov ax, 0x10
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax
  mov ss, ax

  mov esp, 0x90000


  mov esi, msg32      ; Source: The String Address 
  mov edi, 0xB8000    ;Destination: Video Memory Address


.print_loop_32:
  lodsb
  cmp al,0
  je .done_print

  mov [edi], al
  mov byte [edi+1], 0x0F

  add edi, 2
  jmp .print_loop_32

.done_print:

.hlt:
  hlt
  jmp .hlt




;==========================
;     DATA STRINGS
;==========================

msg16 db "This is 16-Bits Real Mode...." , 0
msg32 db "This is the 32-bit protected mode!!!", 0


times 510 - ($ - $$) db 0
dw 0xAA55   ;Bootloader Signature

