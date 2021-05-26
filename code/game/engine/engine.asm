; Main code for a game engine made by CodersCrux (https://ccrx.dev)
; This engine was made in TASM 16bit x86 Assembly.
; It uses graphics mode 13h, 320x200 256-color.
; It has macros for easy to use features such as rendering, math, input and more.
; Is includes VSync to make sure screen tearing doesn't occur.
; To use the engine, make sure your game includes this file, and follows the
; structure shown in the example.asm file.
;
; Some notes:
; - Any game can be closed by hitting the Escape key.

IDEAL

DATASEG
    @kbd      db 128 dup(0) ; Stores the current keys held
    @kbdLast  db 128 dup(0) ; Stores the last keys held, useful for keyDown and keyUp

    @rendered db 00000000b  ; A boolean to make sure we only render when it's 100% needed

    @sAux     db 0FFh       ; Second auxilary, used to determine when a second has passed
    @hundAux  db 0FFh       ; Hundredth of a second auxilary, used to determine when a hundredth has passed

    @tempIP   dw ?          ; Used in procedures to store the return address

    @tscAux   dq ?          ; Time-Stamp Counter auxilary, used for millisecond time measurement
    @freqMs   dq ?          ; Stores the CPU's frequency in milliseconds

    @mathresb db ?          ; Is set to the result when a byte math function is run
    @mathresw dw ?          ; Is set to the result when a word math function is run

    @mseed    dw ?          ; Used for math random function to vary results

    @tempb1   db ?          ; Temporary extra byte storage
    @tempb2   db ?          ; Temporary extra byte storage
    @tempb3   db ?          ; Temporary extra byte storage
    @tempw1   db ?          ; Temporary extra word storage
    @tempw2   db ?          ; Temporary extra word storage
    @tempw3   db ?          ; Temporary extra word storage

    INCLUDE "code/game/engine/mem/if.asm"
    INCLUDE "code/game/engine/mem/util.asm"
    INCLUDE "code/game/engine/mem/math.asm"
    INCLUDE "code/game/engine/mem/input.asm"
    INCLUDE "code/game/engine/mem/render.asm"


CODESEG
  INCLUDE "code/game/engine/math.asm"
  INCLUDE "code/game/engine/input.asm"
  INCLUDE "code/game/engine/render.asm"

  @init:
    ; Free up all unused memory to DOS
    mov bx, ss
    mov ax, es
    sub bx, ax
    mov ax, sp
    add ax, 0Fh
    shr ax, 4
    add bx, ax
    mov ah, 4Ah
    int 21h

    ; Load data segment address into DS
    push @data
    pop ds

    ; Request 4,000 paragraphs of memory (4,000 * 16 = 64,000 bytes = 320 * 200 bytes)
    mov bx, 4000
    mov ah, 48h
    int 21h
    mov es, ax

    ; Clear the buffer with black
    xor ax, ax
    mov cx, 32000
    xor di, di
    rep stosw

    ; Set video mode to VGA 320x200 256-color
    mov ax, 0013h
    int 10h

    call @start

  @run:
    i_check ; Check for new keyboard input

    ifthen_key KC_ESC, @quit

    call @update

    mov ah, 2Ch
    int 21h ; Get DOS time

    cmp dh, [@sAux] ; If a second passed, call 'second' procedure
    je @checkHundredths

    mov [@sAux], dh
    push dx
    call @second
    pop dx

  @checkHundredths:
    cmp dl, [@hundAux]
    je @renderCheck

    mov [@hundAux], dl
    call @hundredth

  @renderCheck:
    cmp [@rendered], 00000000b
    jne @vsync

    call @render ; Render to the buffer
    mov [@rendered], 00000001b

  @vsync:
    ; Check for vertical retrace
    mov dx, 03DAh
    in al, dx
    test al, 8
    jz @endLoop

    r_blit ; Blit buffer into video memory
    mov [@rendered], 00000000b

  @endLoop:
    inc [@mseed] ; Increment [mseed] for use with the m_rand function

    ; Update keyboard buffer
    i_update

    jmp @run

  @quit:
    IFDEF @QUITMODE
        IF @QUITMODE EQ @QUITMODE_CLEAR
            r_clr 0
            r_blit
          ENDIF

        IF @QUITMODE EQ @QUITMODE_TEXTMODE
            mov ax, 0002h
            int 10h
          ENDIF
      ENDIF

    ; Return the extra memory segment to DOS
    mov ah, 49h
    int 21h

    ; Exit the program and return control to DOS
    mov ah, 4Ch
    int 21h
