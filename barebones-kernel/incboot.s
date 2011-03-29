; incboot.s
; Incrementally build a boot block for x86
; I'm going to keep adding bits to this one step at a time from 
; boot-and hang to hopefully loading a kernel

; Here we go.

; Right, now we're going to read some data off the floppy into memory, and then jump
; to it. For now, we won't worry about returning control from this, so it will be a 
; blind jump, not a call.

[ORG 0]                 ; Tells the assembler to consider this as the base address
    jmp 0x7C0:start     ; Jump to a known location. this is right below 
                        ; but at least now we -know- where we are.
; We put the data after the jmp to the boot code so it wont be executed,
; but before the actual code. this is the data space.
start:
    ; Ok, now we need to update the segment registers.
    mov ax, cs          ; Grab the address in the code segment...
    mov ds, ax          ; ...and store it in the data/extra segments
    mov es, ax
    xor ax, ax          ; zero ax (This is an unnecessary step really, but it's nice to be tidy).

; First, let's reset the floppy drive so it's ready for reading

reset:
    mov ax, 0           ; ah == 0, reset floppy drive.
    mov dl, 0           ; drive 0 selected
    int 0x13            ; Call interrupt 13h (20dec), which controls sector based disk i/o
    jc reset            ; Try again if it fails. We might want to extend this so it does not retry indefinately

; We're reset, now lets load arguments so that the computer can find and read the data, and puts it in the right place
read:
    mov ax, 0x1000      ; This is the segment address we're going to read into (ES:BX = 1000:0000)
    mov es, ax          ; Now the above is actually true :)
    xor bx, bx          ; Safety feature, zero bx.

    mov ah, 2           ; ah == 2, read sectors from drive.
    mov al, 1          ; Sector read count
    mov ch, 0           ; cylinder offset
    mov cl, 2           ; sector offset
    mov dh, 0           ; head offset
    mov dl, 0           ; drive number
    int 0x13            ; Make it so.
    jc read             ; Try again if it stuffed up. again, this usually wouldn't be indefinite and silent

    jmp 1000h:0000      ; Hopefully, the correct sector was read, and we can jump to and execute it.

times 510-($-$$) db 0   ; Nasm macro to pad the rest of the block with 0
dw 0xAA55               ; x86 boot signature
