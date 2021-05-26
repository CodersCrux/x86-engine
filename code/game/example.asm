IDEAL ; IDEAL is the syntax the engine was built in, although MASM mode will work just as well
MODEL small ; SMALL is a model which has one code and one data segment
P386 ; Enable support for 32-bit instructions
P8087 ; Enable support for coprocessor instructions for floating-point calculations
STACK 1000h ; Stack size should preferably be at least 100h, 1,000h is suggested
LOCALS ; LOCALS means all values starting with @@ will be per-scope. It is on by default, but this is to make sure you don't run NOLOCALS

; Include the engine code
INCLUDE "code/game/engine/engine.asm"

DATASEG
  ; Make sure to include a font, the default is 'topaz'
  INCLUDE "code/game/engine/font/topaz.asm"

CODESEG

  ; Runs only once, after the engine is initialized
  PROC @start

      ret
    ENDP

  ; Runs as fast as possible in-between frames
  ; Useful for input, collision and other data manipulation
  PROC @update

      ret
    ENDP

  ; Runs as fast as the screen can refresh
  ; All render code should go here, and not update
  PROC @render
      
      ret
    ENDP

  ; Runs once a second, might be useful to you.
  PROC @second

      ret
    ENDP

  ; Runs once every hundredth of a second, might be useful to you.
  PROC @hundredth

      ret
    ENDP

; Mandatory line! It indicates the engine should be run first.
END @init
