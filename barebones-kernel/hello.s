; hello.s
; This is a Hello World program to be loaded from the second sector
; of our boot floppy. 

; For now, it won't return.

jmp start

message:
    db "Hello, World!"
    db 0

start:
    mov si, message     ; Load the first byte address of message into si
                        ; this will be auto-incremented by lodsb below
    mov ax, 1000h       ; Since we've jumped out of the boot block, ds
    mov ds, ax          ; Will be pointing to the wrong location, we need
    xor ax, ax          ; to update it first before reading.

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
times 512-($-$$) db 0
