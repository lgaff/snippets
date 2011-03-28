; incboot.s
; Incrementally build a boot block for x86
pon:
    jmp pon             ; 10 GOTO 10 essentially.
times 510-($-$$) db 0   ; Nasm macro to pad the rest of the block with 0
dw 0xAA55               ; x86 boot signature
