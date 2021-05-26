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
MODEL compact

DATASEG
  @kbd db 128 dup(0)
  @kbdLast db 128 dup(0)

  @rendered db 00000000b

  @tempIP dw ?

  @sAux db ?

  @mathresb db ?
  @mathresw dw ?

  @mseed dw ?

  @tempb1 db ?
  @tempb2 db ?
  @tempb3 db ?
  @tempw1 dw ?
  @tempw2 dw ?
  @tempw3 dw ?

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
    mov ax, @data
    mov ds, ax

    ; Request 4,000 paragraphs of memory (4,000 * 16 = 64,000 bytes)
    mov bx, 4000
    mov ah, 48h
    int 21h
    mov es, ax

    ; Set video mode to VGA 320x200 256-color
    mov ax, 0013h
    int 10h

    call @start

  @run:
    i_check ; Check for new keyboard input

    if_key KC_ESC
    then @quit

    call @update

    inc [@mseed] ; Increment [mseed] for use with the m_rand function

    ; Update keyboard buffer
    i_update

    mov ah, 2Ch
    int 21h ; Get DOS time interrupt. DL contains current hundredths of a second

    cmp dh, [@sAux] ; If a second passed, call 'second' PROCedure
    je @renderCheck

    mov [@sAux], dh
    call @second

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
    jmp @run

  @quit:
    mov ah, 49h
    int 21h ; Return the buffer memory segment to DOS

    mov ah, 4Ch
    int 21h
