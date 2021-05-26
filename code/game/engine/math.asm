IDEAL

CODESEG

  ; Uses: @tempIP, ax, bx
  ; Returns- [@mathresb]: The lower byte
  PROC @pm_minub ; num1: Byte, num2: Byte
      pop [word @tempIP]
      pop ax
      pop bx

      cmp al, bl
      jb @@m_minub_lower

      mov [byte @mathresb], bl
      jmp @@m_minub_ret

    @@m_minub_lower:
      mov [byte @mathresb], al

    @@m_minub_ret:
      push [word @tempIP]
      ret
    ENDP

  ; Uses: @tempIP, ax, bx
  ; Returns- [@mathresb]: The lower byte
  PROC @pm_minsb ; num1: Byte, num2: Byte
      pop [word @tempIP]
      pop ax
      pop bx

      cmp al, bl
      jl @@m_minsb_lower

      mov [byte @mathresb], bl
      jmp @@m_minsb_ret

    @@m_minsb_lower:
      mov [byte @mathresb], al

    @@m_minsb_ret:
      push [word @tempIP]
      ret
    ENDP

  ; Uses: @tempIP, ax, bx
  ; Returns- [@mathresw]: The lower word
  PROC @pm_minuw ; num1: Word, num2: Word
      pop [word @tempIP]
      pop ax
      pop bx

      cmp ax, bx
      jb @@m_minuw_lower

      mov [word @mathresw], bx
      jmp @@m_minuw_ret

    @@m_minuw_lower:
      mov [word @mathresw], ax

    @@m_minuw_ret:
      push [word @tempIP]
      ret
    ENDP

  ; Uses: @tempIP, ax, bx
  ; Returns- [@mathresw]: The lower word
  PROC @pm_minsw ; num1: Word, num2: Word
      pop [word @tempIP]
      pop ax
      pop bx

      cmp ax, bx
      jl @@m_minsw_lower

      mov [word @mathresw], bx
      jmp @@m_minsw_ret

    @@m_minsw_lower:
      mov [word @mathresw], ax

    @@m_minsw_ret:
      push [word @tempIP]
      ret
    ENDP

  ; Uses: @tempIP, ax, bx
  ; Returns- [@mathresb]: The greater byte
  PROC @pm_maxub ; num1: Byte, num2: Byte
      pop [word @tempIP]
      pop ax
      pop bx

      cmp al, bl
      ja @@m_maxub_greater

      mov [byte @mathresb], bl
      jmp @@m_maxub_ret

    @@m_maxub_greater:
      mov [byte @mathresb], al

    @@m_maxub_ret:
      push [word @tempIP]
      ret
    ENDP

  ; Uses: @tempIP, ax, bx
  ; Returns- [@mathresb]: The greater byte
  PROC @pm_maxsb ; num1: Byte, num2: Byte
      pop [word @tempIP]
      pop ax
      pop bx

      cmp al, bl
      jg @@m_maxsb_greater

      mov [byte @mathresb], bl
      jmp @@m_maxsb_ret

    @@m_maxsb_greater:
      mov [byte @mathresb], al

    @@m_maxsb_ret:
      push [word @tempIP]
      ret
    ENDP

  ; Uses: @tempIP, ax, bx
  ; Returns- [@mathresw]: The greater word
  PROC @pm_maxuw ; num1: Word, num2: Word
      pop [word @tempIP]
      pop ax
      pop bx

      cmp ax, bx
      ja @@m_maxuw_greater

      mov [word @mathresw], bx
      jmp @@m_maxuw_ret

    @@m_maxuw_greater:
      mov [word @mathresw], ax

    @@m_maxuw_ret:
      push [word @tempIP]
      ret
    ENDP

  ; Uses: @tempIP, ax, bx
  ; Returns- [@mathresw]: The greater word
  PROC @pm_maxsw ; num1: Word, num2: Word
      pop [word @tempIP]
      pop ax
      pop bx

      cmp ax, bx
      jg @@m_maxsw_greater

      mov [word @mathresw], bx
      jmp @@m_maxsw_ret

    @@m_maxsw_greater:
      mov [word @mathresw], ax

    @@m_maxsw_ret:
      push [word @tempIP]
      ret
    ENDP

  ; Uses: ax, bx
  ; Returns- [@mathresb]: The random byte generated
  PROC @pm_randb
      mov ax, [word @mseed]
      mov bx, 25173
      mul bx
      add ax, 13849

      mov [word @mseed], ax
      mov [byte @mathresb], al
    ENDP

  ; Uses: ax, bx
  ; Returns- [@mathresw]: The random word generated
  PROC @pm_randw
      mov ax, [word @mseed]
      mov bx, 25173
      mul bx
      add ax, 13849

      mov [word @mseed], ax
      mov [word @mathresw], ax
    ENDP

  ;
