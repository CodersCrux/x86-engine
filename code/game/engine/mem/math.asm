IDEAL


macro m_minub num1, num2
    push [word @tempIP] ax bx num1 num2
    call @pm_minub
    pop bx ax [word @tempIP]
  endm

macro m_minsb num1, num2
    push [word @tempIP] ax bx num1 num2
    call @pm_minsb
    pop bx ax [word @tempIP]
  endm

macro m_minuw num1, num2
    push [word @tempIP] ax bx num1 num2
    call @pm_minuw
    pop bx ax [word @tempIP]
  endm

macro m_minsw num1, num2
    push [word @tempIP] ax bx num1 num2
    call @pm_minsw
    pop bx ax [word @tempIP]
  endm

macro m_maxub num1, num2
    push [word @tempIP] ax bx num1 num2
    call @pm_maxub
    pop bx ax [word @tempIP]
  endm

macro m_maxsb num1, num2
    push [word @tempIP] ax bx num1 num2
    call @pm_maxsb
    pop bx ax [word @tempIP]
  endm

macro m_maxuw num1, num2
    push [word @tempIP] ax bx num1 num2
    call @pm_maxuw
    pop bx ax [word @tempIP]
  endm

macro m_maxsw num1, num2
    push [word @tempIP] ax bx num1 num2
    call @pm_maxsw
    pop bx ax [word @tempIP]
  endm

macro m_randb
    push ax bx
    call @pm_randb
    pop bx ax
  endm

macro m_randw
    push ax bx
    call @pm_randw
    pop bx ax
  endm
