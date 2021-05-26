
; Configurable based on your DOS configuration
SB16_BASE equ 220h                          ;|
SB16_HDMA equ 5                             ;|
SB16_IRQ  equ 7                             ;|
;---------------------------------------------



; -------------- Pre-computed, do not change! -------------- ;

; Common computes
SB16_HDMAm4 equ SB16_HDMA mod 4

; Registers
REG_DSP_RESET      equ SB16_BASE + 06h
REG_DSP_READ       equ SB16_BASE + 0Ah
REG_DSP_WRITE_BS   equ SB16_BASE + 0Ch
REG_DSP_WRITE_CMD  equ SB16_BASE + 0Ch
REG_DSP_WRITE_DATA equ SB16_BASE + 0Ch
REG_DSP_READ_BS    equ SB16_BASE + 0Eh
REG_DSP_ACK        equ SB16_BASE + 0Eh
REG_DSP_ACK_16     equ SB16_BASE + 0Fh

; DSP commands
DSP_SET_SAMPLING_OUTPUT equ 41h
DSP_DMA_16_OUTPUT_AUTO  equ 0B6h
DSP_STOP_DMA_16         equ 0D5h

; DMA registers
REG_DMA_ADDRESS  equ 0C0h + (SB16_HDMA - 4) * 4
REG_DMA_COUNT    equ REG_DMA_ADDRESS + 02h
REG_DMA_MASK     equ 0D4h
REG_DMA_MODE     equ 0D6h
REG_DMA_CLEAR_FF equ 0D8h

IF SB16_HDMA - 5
  REG_DMA_PAGE equ 8Bh
ELSE
  IF SB16_HDMA - 6
    REG_DMA_PAGE equ 89h
  ELSE
    REG_DMA_PAGE equ 8Ah
  ENDIF
ENDIF

; ISR vector
ISR_VECTOR equ ((SB16_IRQ shr 3) * (70h - 08h) + (SB16_IRQ and 7) + 08h) * 4
PIC_DATA equ (SB16_IRQ and 8) + 21h
PIC_MASK equ 1 shl (SB16_IRQ and 7)
