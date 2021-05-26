IDEAL

DATASEG
  macro r_blit
      push ax
      push cx
      push di
      push si
      push es
      call @pr_blit
      pop es
      pop si
      pop di
      pop cx
      pop ax
    endm

  macro r_clr col
      push [word @tempIP]
      push ax
      push cx
      push di
      push col
      call @pr_clr
      pop di
      pop cx
      pop ax
      pop [word @tempIP]
    endm

  macro r_pix x, y, col
      push [word @tempIP]
      pushall
      push x
      push y
      push col
      call @pr_pix
      popall
      pop [word @tempIP]
    endm

  macro r_hLine x, y, len, col
      push [word @tempIP]
      push ax
      push bx
      push cx
      push di
      push x
      push y
      push len
      push col
      call @pr_hLine
      pop di
      pop cx
      pop bx
      pop ax
      pop [word @tempIP]
    endm

  macro r_vLine x, y, len, col
      push [word @tempIP]
      push ax
      push bx
      push cx
      push di
      push x
      push y
      push len
      push col
      call @pr_vLine
      pop di
      pop cx
      pop bx
      pop ax
      pop [word @tempIP]
    endm

  macro r_rect x1, y1, x2, y2, col
      push [word @tempIP]
      pushall
      push di
      push x1
      push y1
      push x2
      push y2
      push col
      call @pr_rect
      pop di
      popall
      pop [word @tempIP]
    endm

  macro r_rectF x1, y1, x2, y2, col
      push [word @tempIP]
      pushall
      push di
      push si
      push x1
      push y1
      push x2
      push y2
      push col
      call @pr_rectF
      pop si
      pop di
      popall
      pop [word @tempIP]
    endm

  macro r_rectFC x, y, width, height, col
      push [word @tempIP]
      pushall
      push di
      push si
      push x
      push y
      push width
      push height
      push col
      call @pr_rectFC
      pop si
      pop di
      popall
      pop [word @tempIP]
    endm
