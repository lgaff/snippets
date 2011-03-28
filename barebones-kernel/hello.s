; hello.s
; This is a Hello World program to be loaded from the second sector
; of our boot floppy. 

; For now, it won't return.

[org 0]
jmp start

msg:
    db "Hello, World!\0"

start:
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
    jmp pon             ; Nop when done.

