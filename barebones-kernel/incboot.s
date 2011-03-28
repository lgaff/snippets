; incboot.s
; Incrementally build a boot block for x86
; I'm going to keep adding bits to this one step at a time from 
; boot-and hang to hopefully loading a kernel

; Here we go.

; On x86, the BIOS will load the boot block (where found) into address
; 0x7C00. The segment and offset will change depending on implementation.
; This..is a problem. So what do we do? We issue an assembler directive
; telling it where to offset from, and then we jump to a known 
; segment:offset address and start booting.


[ORG 0]                 ; Tells the assembler to consider this as the base address
    jmp 0x7C0:start     ; Jump to a known location. this is right below 
                        ; but at least now we -know- where we are.

start:
    ; Ok, now we need to update the segment registers.
    mov ax, cs          ; Grab the address in the code segment...
    mov ds, ax          ; ...and store it in the data/extra segments
    mov es, ax
    xor ax, ax          ; zero ax (This is an unnecessary step really, but it's nice to be tidy).

    ; Ok, we're now in the right place, and we know it. but we're still
    ; not going to do anything but hang.

pon:
    jmp pon             ; 10 GOTO 10 essentially.
times 510-($-$$) db 0   ; Nasm macro to pad the rest of the block with 0
dw 0xAA55               ; x86 boot signature
