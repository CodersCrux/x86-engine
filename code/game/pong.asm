IDEAL
MODEL small
P386
P8087
STACK 1000h
LOCALS

INCLUDE "code/game/engine/config.asm"

@QUITMODE = @QUITMODE_CLEAR

INCLUDE "code/game/engine/engine.asm"

DATASEG
  INCLUDE "code/game/engine/font/topaz.asm"

  STRUC Vec2
      x dw 0
      y dw 0
    ENDS

  shadowDist dw 7

  ballPos Vec2 ?

  ballDir db 1011b
  ; How ballDir works:
  ;      0000 - 4 bits
  ;
  ;     0 0          0 0
  ;      X            Y
  ; Left bits for X direction, right bits for Y
  ; For each axis:
  ;      0            0
  ;  Stay/Move       +/-

  ; X = Y value, Y = length
  batL Vec2 ?
  batR Vec2 ?

  ; Boolean to select if we should fill the center of plotted blocks or not
  fill db 00000000b


  MACRO plot x, y, colFill, colFrame
      push ax bx si di x y colFill colFrame
      call pplot
      pop di si bx ax
    ENDM

  MACRO plotEffects x, y, col3D
      push ax bx si di x y col3D
      call pplotEffects
      pop di si bx ax
    ENDM

CODESEG
    ; Plots the effects like 3D and shadows.
    PROC pplotEffects
        push bp
        mov bp, sp

        sub sp, 4

        @@x equ [word bp + 8]
        @@y equ [word bp + 6]
        @@col3D equ [word bp + 4]

        @@rectX equ [word bp - 2]
        @@rectY equ [word bp - 4]

        mov ax, @@x
        mov bl, 20
        mul bl
        inc ax
        mov @@rectX, ax ; @@rectX contains [rectX]
        mov ax, @@y
        mul bl
        inc ax
        mov @@rectY, ax ; @@rectY contains [rectY]

        mov si, @@rectX
        mov di, @@rectY
        add si, 17
        add di, 17


        cmp @@x, 8
        jb @@left3D

        ; Right 3D
        push @@rectX @@rectY @@x si di

        sub si, 17
        sub @@x, 7
        mov ax, @@x
        sub @@rectX, ax

        r_rectF @@rectX, @@rectY, si, di, @@col3D

        pop di si @@x @@rectY @@rectX

        push @@rectX @@rectY @@x si di

        sub @@x, 7
        mov ax, @@x
        mov @@rectX, si
        sub @@rectX, ax

        r_rectF @@rectX, @@rectY, si, di, @@col3D

        pop di si @@x @@rectY @@rectX

        jmp @@quit

      @@left3D:
        push @@rectX @@rectY @@x si di

        inc si
        mov @@rectX, si
        mov ax, 7
        sub ax, @@x
        add si, ax

        r_rectF @@rectX, @@rectY, si, di, @@col3D

        pop di si @@x @@rectY @@rectX

        push @@rectX @@rectY @@x si di

        sub si, 17
        sub @@x, 7
        mov ax, @@x
        sub @@rectX, ax

        r_rectF @@rectX, @@rectY, si, di, @@col3D

        pop di si @@x @@rectY @@rectX

      @@quit:
        add sp, 4
        pop bp
        ret 6
      ENDP

    PROC pplot
        push bp
        mov bp, sp

        sub sp, 4

        @@x equ [word bp + 10]
        @@y equ [word bp + 8]
        @@colFrame equ [word bp + 6]
        @@colFill equ [word bp + 4]

        @@rectX equ [word bp - 2]
        @@rectY equ [word bp - 4]

        mov ax, @@x
        mov bl, 20
        mul bl
        inc ax
        mov @@rectX, ax ; @@rectX contains [rectX]
        mov ax, @@y
        mul bl
        inc ax
        mov @@rectY, ax ; @@rectY contains [rectY]


        ; Draw outer neon frame
        mov si, @@rectX
        mov di, @@rectY
        add si, 17
        add di, 17

        r_rect @@rectX, @@rectY, si, di, @@colFrame


        ; Draw inner neon frame
        inc @@rectX
        dec si
        inc @@rectY
        dec di

        r_rect @@rectX, @@rectY, si, di, @@colFrame


        cmp [fill], 00000001b
        jne @@quit

        ; Draw filling color
        inc @@rectX
        dec si
        inc @@rectY
        dec di

        r_rectF @@rectX, @@rectY, si, di, @@colFill

      @@quit:
        add sp, 4
        pop bp
        ret 8
      ENDP

    PROC updateBall
        mov cl, [ballDir]

        push cx
        and cl, 0010b

        cmp cl, 0010b
        pop cx
        jne @@checkY

        push cx
        and cl, 0001b

        cmp cl, 0001b
        pop cx
        je @@moveRight

        ; Move left
        dec [ballPos.x]

        jmp @@checkY

      @@moveRight:
        inc [ballPos.x]

      @@checkY:

        ret
      ENDP

    PROC @start

        ret
      ENDP

    PROC @update

        ifels_keyDown KC_W, @@cont1
          cmp [batL.x], 0
          je @@cont1

          dec [batL.x]

      @@cont1:
        ifels_keyDown KC_S, @@cont2
          mov ax, [batL.x]
          add ax, [batL.y]
          dec ax
          cmp ax, 9
          je @@cont2

          inc [batL.x]

      @@cont2:
        ifels_keyDown KC_UP, @@cont3
          cmp [batR.x], 0
          je @@cont3

          dec [batR.x]

      @@cont3:
        ifels_keyDown KC_DOWN, @@cont4
        mov ax, [batR.x]
        add ax, [batR.y]
        dec ax
        cmp ax, 9
        je @@cont4

        inc [batR.x]

      @@cont4:


        ret
      ENDP

    PROC @render
        r_clr 0C8h

        ; |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        ; ----------------------- Plot effects calculations -----------------------
        ; |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

        ; Draw left bat
        mov bx, [batL.x] ; BX contains [batL.y]
        mov cx, [batL.y] ; CX contains [batL.length]

      @@drawBatLEffects:
        plotEffects 1, bx, 35h

        inc bx
        loop @@drawBatLEffects

        ; Draw right bat
        mov bx, [batR.x] ; BX contains [batR.y]
        mov cx, [batR.y] ; CX contains [batR.length]

      @@drawBatREffects:
        plotEffects 14, bx, 04h

        inc bx
        loop @@drawBatREffects

        ; Draw ball
        plotEffects [ballPos.x], [ballPos.y], 1Ch

        ; |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        ; --------------------------- Plot calculations ---------------------------
        ; |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

        ; Draw left bat
        mov bx, [batL.x] ; BX contains [batL.y]
        mov cx, [batL.y] ; CX contains [batL.length]

      @@drawBatL:
        plot 1, bx, 0Bh, 4Ch

        inc bx
        loop @@drawBatL

        ; Draw right bat
        mov bx, [batR.x] ; BX contains [batR.y]
        mov cx, [batR.y] ; CX contains [batR.length]

      @@drawBatR:
        plot 14, bx, 27h, 0Ch

        inc bx
        loop @@drawBatR

        ; Draw ball
        plot [ballPos.x], [ballPos.y], 1Eh, 0Fh

        ; |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        ; ---------------------------- UI calculations ----------------------------
        ; |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

        ;r_char 30, 30, 'A', 1, 0Ch

        ; Draw frame
        r_rect 0, 0, 319, 199, 0B1h
        r_rect 1, 1, 318, 198, 0B1h

        ret
      ENDP

    PROC @second

        ret
      ENDP

    PROC @hundredth
        xor ah, ah
        mov al, [@hundAux]
        mov bl, 2
        div bl

        cmp ah, 0
        je @@cont1

        jmp @@cont2

      @@cont1:
        call updateBall

      @@cont2:
        ret
      ENDP

END @init
