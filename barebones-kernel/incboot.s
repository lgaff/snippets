; incboot.s
; A bootloader that I will construct incrementally, using Git to track
; the evolution from a minimal boot-and-hang, to hopefully loading a kernel

; Here we go.
nop:                    ; 10 GOTO 10 basically. boot and hang.
    jmp nop
    
times 510-($-$$) db 0   ; NASM macro to fill the rest of the file with 0's
dw 0AA55h               ; the x86 boot signature. Exists at bytes 510 + 511