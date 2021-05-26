IDEAL

CODESEG
  ; Uses: ax, cx, di, si, es
  PROC @pr_blit
      mov ax, es
      mov ds, ax
      xor si, si
      mov ax, 0A000h
      mov es, ax
      xor di, di
      mov cx, 32000
      rep movsw
      ret
    ENDP

  ; Uses: @tempIP, ax, cx, di
  PROC @pr_clr ; col: Byte
      pop [word @tempIP]
      pop ax
      mov ah, al
      xor di, di
      mov cx, 32000
      rep stosw

      push [word @tempIP]
      ret
    ENDP ; col: Byte ; col: Byte

  ; Uses: @tempIP, ax-dx
  PROC @pr_pix ; x: Word, y: Byte, col: Byte
      pop [word @tempIP]
      pop dx ; DL contains [col]
      pop cx ; CL contains [y]
      xor ch, ch
      pop bx ; BX contains [x]

      mov ax, 320
      push dx
      mul cx
      pop dx
      add bx, ax

      mov [es:bx], dl

      push [word @tempIP]
      ret
    ENDP

  ; Uses: @tempIP, ax, bx, cx, di
  PROC @pr_hLine ; x: Word, y: Byte, len: Word, col: Byte
      pop [word @tempIP]

      pop ax
      mov bh, al ; BH contains [col]
      pop cx ; CX contains [len]
      pop ax
      mov bl, al ; BL contains [y]
      pop ax ; AX contains [x]

      ; Calculate the starting position of the line, store it in di
      push ax
      mov ax, 320
      push bx
      xor bh, bh
      mul bx
      pop bx
      pop dx
      add ax, dx
      mov di, ax

      mov al, bh ; Mov to al the color
      inc cx

      rep stosb

      push [word @tempIP]
      ret
    ENDP

  ; Uses: @tempIP, ax, bx, cx, di
  PROC @pr_vLine ; x: Word, y: Byte, len: Word, col: Byte
      pop [word @tempIP]
      pop ax
      mov bh, al ; BH contains [col]
      pop cx ; CX contains [len]
      inc cx
      pop ax
      mov bl, al ; BL contains [y]
      pop ax ; AX contains [x]

      ; Calculate the starting position of the line, store it in di
      push ax
      mov ax, 320
      push bx
      xor bh, bh
      mul bx
      pop bx
      pop dx
      add ax, dx
      mov di, ax
      mov ax, dx

    @@r_vLine_draw:
      mov [es:di], bh
      add di, 320
      loop @@r_vLine_draw

      push [word @tempIP]
      ret
    ENDP

  ; Uses: @tempIP, ax-dx, di
  PROC @pr_rect ; x1: Word, y1: Byte, x2: Word, y2: Byte, col: Byte
      pop [word @tempIP]
      pop ax
      mov dl, al ; DL contains [col]
      pop ax
      mov ch, al ; CH contains [y2]
      pop bx ; BX contains [x2]
      pop ax
      mov cl, al ; CL contains [y1]
      pop ax ; AX contains [x1]

      ;-- Requirements: [x1 <= x2, y1 <= y2]

      cmp ax, bx
      jbe @@r_rect_checkY ; Check if [x1 <= x2]. If it isn't, swap the registers
      push ax
      mov ax, bx
      pop bx

    @@r_rect_checkY:
      cmp cl, ch
      jbe @@r_rect_start ; Check if [y1 <= y2]. If it isn't, swap the registers
      mov dh, cl
      mov cl, ch
      mov ch, dh
      xor dh, dh

    @@r_rect_start:
      push [word @tempIP]

      pushall
      push ax cx
      sub ch, cl
      shr cx, 8
      push cx dx
      call @pr_vLine
      popall

      pushall
      push bx cx
      sub ch, cl
      shr cx, 8
      push cx dx
      call @pr_vLine
      popall

      inc ax
      pushall
      push ax cx
      sub bx, ax
      dec bx
      push bx dx
      call @pr_hLine
      popall

      pushall
      push ax
      shr cx, 8
      push cx
      sub bx, ax
      push bx dx
      call @pr_hLine
      popall

      ret
    ENDP

  ; Uses: @tempIP, ax-dx, di, si
  PROC @pr_rectF ; x1: Word, y1: Byte, x2: Word, y2: Byte, col: Byte
      pop [word @tempIP]
      pop dx ; DL contains [col]
      pop ax
      mov ch, al ; CH contains [y2]
      pop bx ; BX contains [x2]
      pop ax
      mov cl, al ; CL contains [y1]
      pop ax ; AX contains [x1]

      ;-- Requirements: [x1 <= x2, y1 <= y2]

      cmp ax, bx
      jbe @@r_rectF_checkY ; Check if [x1 <= x2]. If it isn't, swap the registers
      push ax
      mov ax, bx
      pop bx

    @@r_rectF_checkY:
      cmp cl, ch
      jbe @@r_rectF_start ; Check if [y1 <= y2]. If it isn't, swap the registers
      mov dh, cl
      mov cl, ch
      mov ch, dh
      xor dh, dh

    @@r_rectF_start:
      mov si, bx
      sub si, ax ; SI contains [x2 - x1]
      inc si

      mov di, cx
      and di, 00FFh ; DI contains [y1]

      ; Calculate starting index
      push dx
      push ax
      mov ax, 320
      mul di ; AX contains [y1 * 320]
      pop dx ; DX contains [x1]
      mov di, ax ; DI contains [y1 * 320]
      add di, dx ; DI contains [y1 * 320 + x1]
      pop dx ; DX contains [col]

    @@r_rectF_draw:
      push di
      push cx
      mov al, dl
      mov cx, si

      rep stosb
      pop cx
      pop di

      add di, 320 ; Increase DI by one horizontal line (320)
      inc cl
      cmp cl, ch
      jbe @@r_rectF_draw

      push [word @tempIP]
      ret
    ENDP

  ; Uses: @tempIP, ax-dx, di, si
  PROC @pr_rectFC ; x: Word, y: Byte, width: Word, height: Byte, col: Byte
      pop [word @tempIP]
      pop dx ; DL contains [col]
      pop cx ; CL contains [height]
      pop ax ; AX contains [width]
      pop bx
      mov ch, bl ; CH contains [y]
      pop di ; DI contains [x]

      mov bl, 2
      div bl
      mov bh, al ; BH contains [width / 2]

      mov ax, cx
      xor ah, ah
      div bl
      mov cl, al ; CL contains [height / 2]

      xor bl, bl
      shr bx, 8

      mov si, di ; SI contains [x]
      sub di, bx ; DI contains [x - width / 2]
      add si, bx ; SI contains [x + width / 2]

      mov bh, ch ; BH contains [y]
      sub ch, cl ; CH contains [y - height / 2]
      add bh, cl ; BH contains [y + height / 2]

      push [word @tempIP]

      push di
      shr cx, 8
      push cx si
      shr bx, 8
      push bx dx
      call @pr_rectF

      ret
    ENDP

  ; Uses: @tempIP, @tempw1, @tempw2, ax-dx, si, di
  PROC @pr_char ; x: Word, y: Byte, char: Byte, scale: Byte, col: Byte
      pop [word @tempIP]
      pop dx ; DL contains [col]
      pop di
      mov dh, al ; DH contains [char]
      pop cx ; CL contains [y]
      pop si ; SI contains [x]
      mov ax, di ; AX contains [scale]

      ; Check if the character is in the font's range (32-126)
      cmp dh, 20h
      jb @@r_char_unknown
      cmp dh, 7Eh
      ja @@r_char_unknown

      jmp @@r_char_known

    @@r_char_unknown:
      mov di, cx
      add di, 8
      mov bx, si
      add bx, 8
      r_rectF si, cx, bx, di, dx

      push [word @tempIP]
      ret

    @@r_char_known:
      push ax
      sub dh, 20h
      push dx
      shr dx, 8
      mov ax, 8
      mul dx
      pop dx
      lea di, [@font_32]
      add di, ax ; DI contains [PTR(@font_[char])]
      pop ax

      xor dh, dh ; DH contains [lineIndex]

    @@r_char_line:
      mov ch, [di] ; CH contains [bitStrip]
      xor bl, bl ; BL contains [bitIndex]
    @@r_char_bit:
      push cx
      and ch, 10000000b
      cmp ch, 10000000b
      pop cx
      jne @@r_char_endBit

      ; Draw
      push si cx
      


    @@r_char_endBit:
      inc bl
      shl ch, 1
      cmp ch, 00000000b
      jne @@r_char_bit

      inc di
      inc dh

      cmp dh, 8
      jb @@r_char_line

      push [word @tempIP]
      ret
    ENDP

  ; Uses @tempIP, @tempb1, ax-dx, si, di
  PROC @pr_text ; x: Word, y: Byte, col: Byte
      pop [word @tempIP]
      pop dx ; DL contains [col]
      pop cx ; CL contains [y]
      pop di ; DI contains [x]

      mov si, sp

      push [word @tempIP]
      ret
    ENDP

  ; Uses: @tempIP, ax, cx, dx, si, di
  PROC @pr_textDraw ; scale: Byte
      pop [word @tempIP]
      mov bp, sp

      sub si, bp
      mov ax, si
      mov ch, al ; CH contains static [count * 2]

    @@r_textDraw_draw:
      sub si, 2
      mov ax, [bp + si]
      r_char di, cx, ax, dx

      add di, 8

      cmp si, 0
      ja @@r_textDraw_draw

      xor ah, ah
      mov al, ch
      add sp, ax

      push [word @tempIP]
      ret
    ENDP
