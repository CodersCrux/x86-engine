IDEAL
MODEL compact
STACK 100h

INCLUDE "code/game/engine/engine.asm"

DATASEG
  INCLUDE "code/game/engine/font/topaz.asm"

CODESEG

    PROC @start

        ret
      ENDP


    PROC @update

        ret
      ENDP

    PROC @render
        ;r_clr 0

        r_pix 40, 170, 0Ah


        ret
      ENDP

    PROC @second

        ret
      ENDP

END @init
