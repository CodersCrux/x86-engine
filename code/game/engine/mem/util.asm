IDEAL

macro pushall
    push ax bx cx dx
  endm

macro popall
    pop dx cx bx ax
  endm

macro memmovb mem1, mem2
    push ax
    mov al, mem2
    mov mem1, al
    pop ax
  endm

macro memmovw mem1, mem2
    push ax
    mov ax, [mem2]
    mov [mem1], ax
    pop ax
  endm
