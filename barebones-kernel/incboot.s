; incboot.s
; Incrementally build a boot block for x86
; I'm going to keep adding bits to this one step at a time from 
; boot-and hang to hopefully loading a kernel

; Here we go.

; Ok, now we're going to do something actually a little interesting
; (and also verifiable, up til now there's little to mark that we've
; done anything at all because we really haven't). We're going to put
; a message on the terminal. To do this, we need to define the string
; data, load its address, and then call a BIOS interrupt to dump the 
; contents to the screen.

[ORG 0]                 ; Tells the assembler to consider this as the base address
    jmp 0x7C0:start     ; Jump to a known location. this is right below 
                        ; but at least now we -know- where we are.
; We put the data after the jmp to the boot code so it wont be executed,
; but before the actual code. this is the data space.
message:
    db "GREETINGS HUMAN"

start:
    ; Ok, now we need to update the segment registers.
    mov ax, cs          ; Grab the address in the code segment...
    mov ds, ax          ; ...and store it in the data/extra segments
    mov es, ax
    xor ax, ax          ; zero ax (This is an unnecessary step really, but it's nice to be tidy).

    ; Okay, now lets do something interesting. first, load the address into
    ; the source index so the BIOS can find it
    mov si, message

    ; Now, we loop through printing each character in sequence
print:
    lodsb               ; Load the next byte
    cmp al, 0           ; The string is null terminated, this checks for our exit condition
    jz pon              ; hang when we're done
    ; Set up and call BIOS interrupt 16 - VGA functions (http://en.wikipedia.org/wiki/INT_10H)
    ; First load arguments for int 10h into the registers
    mov bx, 7           ; set color mode. 7 = white
    mov ah, 0xE         ; teletype output.
    int 0x10            ; call the interrupt.
    jmp print           ; Loop until the string is written out

pon:
    jmp pon             ; 10 GOTO 10 essentially.
times 510-($-$$) db 0   ; Nasm macro to pad the rest of the block with 0
dw 0xAA55               ; x86 boot signature
