IDEAL

CODESEG

  PROC @pi_check
      ; Clear TypeAhead
      mov ax, 40h
      mov es, ax
      mov [word ptr es:1Ah], 1Eh
      mov [word ptr es:1Ch], 1Eh

      in al, 64h
      cmp al, 10b
      je @@quit

      in al, 60h
      xor ah, ah

      lea bx, [@kbd]

      cmp al, 80h
      ja @@released

      add bx, ax
      mov [byte bx], 1
      jmp @@quit

    @@released:
      sub ax, 80h
      add bx, ax
      mov [byte bx], 0

    @@quit:
      ret
    ENDP

  ; Uses: @tempIP, bx
  PROC @pi_key ; key: Byte
      pop [word @tempIP]
      pop bx
      add bx, offset @kbd
      cmp [byte ptr bx], 1

      push [word @tempIP]
      ret
    ENDP

  ; Uses: @tempIP, bx, cx, si
  PROC @pi_keyDown ; key: Byte
      pop [word @tempIP]
      pop bx
      lea si, [@kbdLast]
      mov cx, [si + bx]
      not cx
      lea si, [@kbd]
      and cx, [si + bx]

      cmp cl, 1

      push [word @tempIP]
      ret
    ENDP

  ; Uses: @tempIP, bx, cx, si
  PROC @pi_keyUp ; key: Byte
      pop [word @tempIP]
      pop bx
      lea si, [@kbd]
      mov cx, [si + bx]
      not cx
      lea si, [@kbdLast]
      and cx, [si + bx]

      cmp cl, 1

      push [word @tempIP]
      ret
    ENDP
