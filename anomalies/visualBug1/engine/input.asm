IDEAL

CODESEG
  ; Uses: ax, bx
  PROC @pi_check
      ; Clear the BIOS keyboard buffer
      push ax
      push es
      mov ax, 40h
      mov es, ax
      mov [word ptr es:1Ah], 1Eh
      mov [word ptr es:1Ch], 1Eh
      pop es
      pop ax

      in al, 64h
      cmp al, 10h
      je @i_check_quit

      in al, 60h

      cmp al, 80h
      ja @i_check_released

      lea bx, [@kbd]
      xor ah, ah
      add bx, ax

      mov [byte ptr bx], 1

      jmp @i_check_quit

    @i_check_released:
      sub al, 80h

      lea bx, [@kbd]
      xor ah, ah
      add bx, ax

      mov [byte ptr bx], 0

    @i_check_quit:
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
      mov cx, [si+bx]
      not cx
      lea si, [@kbd]
      and cx, [si+bx]

      cmp cl, 1

      push [word @tempIP]
      ret
    ENDP

  ; Uses: @tempIP, bx, cx, si
  PROC @pi_keyUp ; key: Byte
      pop [word @tempIP]
      pop bx
      lea si, [@kbd]
      mov cx, [si+bx]
      not cx
      lea si, [@kbdLast]
      and cx, [si+bx]

      cmp cl, 1

      push [word @tempIP]
      ret
    ENDP
