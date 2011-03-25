org 0x7c00
jmp start

start:
  xor ah, ah
  mov al, 0x13
  int 0x10

  mov di, 0xa000
  mov es, di
  xor di, di
  jmp outside  
times 510-($-$$) db 0
dw 0xAA55

outside:
  mov al, 0ffh
  mov cx, 0ffffh
  stosb
  sub cx, 1
  cmp cx, 0
  jnz outside
nop:
  jmp nop
