ORG 0x7c00
BITS 16

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

_start:
	jmp short start
	nop

times 33 db 0

start:
	jmp 0:step2

step2:
	cli
	mov ax, 0x00
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov sp, 0x7c00
	sti
.load_protected:
	cli
	lgdt[gdt_descriptor]
	mov eax, cr0
	mov cr0, eax
	jmp $ ; CODE_SEG:load32

; GDT
gdt_start:
gdt_null:
	dd 0x0
	dd 0x0
;offset 0x8
gdt_code:
	dw 0xffff
	dw 0 ; Base 0-15 bits
	db 0 ; Base 16-23 bits
	db 0x9a ; Access byte
	db 11001111b ; 4bit flags
	db 0 ; Base 24-31 bits
;offset 0x10
gdt_data:
	dw 0xffff
	dw 0 ; Base 0-15 bits
	db 0 ; Base 16-23 bits
	db 0x92 ; Access byte
	db 11001111b ; 4bit flags
	db 0 ; Base 24-31 bits
gdt_end:

gdt_descriptor:
	dw gdt_end - gdt_start - 1
	dd gdt_start

times 510-($ - $$) db 0
dw 0xAA55