IDEAL

DATASEG
  macro pushall
      push ax
      push bx
      push cx
      push dx
    endm

  macro popall
      pop dx
      pop cx
      pop bx
      pop ax
    endm
