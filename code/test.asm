IDEAL
MODEl small
STACK 100h

DATASEG
    tempIP dw ?

CODESEG
  PROC rect ; x1: Word, y1: Word, x2: Word, y2: Word, color: Byte
      pop [tempIP]
      pop ax ; AL contains color
      pop di ; DI contains y2
      pop si ; SI contains x2
      pop dx ; DX contains y1
      pop cx ; CX contains x1

      mov ah, 0Ch
      xor bh, bh

      push cx

    drawloop:
      int 10h

      inc cx

      cmp cx, si
      jbe drawloop

      inc dx
      pop cx
      push cx

      cmp dx, di
      jbe drawloop

      push [tempIP]
      ret
    ENDP

  init:

    mov ax, 0013h
    int 10h

    push 40 40 140 140 06h
    call rect

    push 150 150 180 170 0Ah
    call rect


    mov ah, 4Ch
    int 21h

END init
