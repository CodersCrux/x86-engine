IDEAL

macro r_blit
    push ax cx di si es ds
    call @pr_blit
    pop ds es si di cx ax
  endm

macro r_clr col
    push [@tempIP] ax cx di col
    call @pr_clr
    pop di cx ax [@tempIP]
  endm

macro r_pix x, y, col
    push [@tempIP] ax bx cx dx x y col
    call @pr_pix
    pop dx cx bx ax [@tempIP]
  endm

macro r_hLine x, y, len, col
    push [@tempIP] ax bx cx di x y len col
    call @pr_hLine
    pop di cx bx ax [@tempIP]
  endm

macro r_vLine x, y, len, col
    push [@tempIP] ax bx cx di x y len col
    call @pr_vLine
    pop di cx bx ax [@tempIP]
  endm

macro r_rect x1, y1, x2, y2, col
    push [@tempIP] ax bx cx dx di x1 y1 x2 y2 col
    call @pr_rect
    pop di dx cx bx ax [@tempIP]
  endm

macro r_rectF x1, y1, x2, y2, col
    push [@tempIP] ax bx cx dx di si x1 y1 x2 y2 col
    call @pr_rectF
    pop si di dx cx bx ax [@tempIP]
  endm

macro r_rectFC x, y, width, height, col
    push [@tempIP] ax bx cx dx di si x y width height col
    call @pr_rectFC
    pop si di dx cx bx ax [@tempIP]
  endm

macro r_char x, y, char, scale, col
    push [@tempIP] ax bx cx dx di si x y char scale col
    call @pr_char
    pop si di dx cx bx ax [@tempIP]
  endm

macro r_text x, y, col
    push [@tempIP] ax bx cx dx di si x y col
    call @pr_text
  endm

macro r_textDraw scale
    push scale
    call @pr_textDraw
    pop si di dx cx bx ax [@tempIP]
  endm
