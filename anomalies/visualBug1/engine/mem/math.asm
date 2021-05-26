IDEAL

DATASEG
  macro m_minub num1, num2
      push [word @tempIP]
      push ax
      push bx
      push num1
      push num2
      call @pm_minub
      pop bx
      pop ax
      pop [word @tempIP]
    endm

  macro m_minsb num1, num2
      push [word @tempIP]
      push ax
      push bx
      push num1
      push num2
      call @pm_minsb
      pop bx
      pop ax
      pop [word @tempIP]
    endm

  macro m_minuw num1, num2
      push [word @tempIP]
      push ax
      push bx
      push num1
      push num2
      call @pm_minuw
      pop bx
      pop ax
      pop [word @tempIP]
    endm

  macro m_minsw num1, num2
      push [word @tempIP]
      push ax
      push bx
      push num1
      push num2
      call @pm_minsw
      pop bx
      pop ax
      pop [word @tempIP]
    endm

  macro m_maxub num1, num2
      push [word @tempIP]
      push ax
      push bx
      push num1
      push num2
      call @pm_maxub
      pop bx
      pop ax
      pop [word @tempIP]
    endm

  macro m_maxsb num1, num2
      push [word @tempIP]
      push ax
      push bx
      push num1
      push num2
      call @pm_maxsb
      pop bx
      pop ax
      pop [word @tempIP]
    endm

  macro m_maxuw num1, num2
      push [word @tempIP]
      push ax
      push bx
      push num1
      push num2
      call @pm_maxuw
      pop bx
      pop ax
      pop [word @tempIP]
    endm

  macro m_maxsw num1, num2
      push [word @tempIP]
      push ax
      push bx
      push num1
      push num2
      call @pm_maxsw
      pop bx
      pop ax
      pop [word @tempIP]
    endm

  macro m_randb
      push ax
      push bx
      call @pm_randb
      pop bx
      pop ax
    endm

  macro m_randw
      push ax
      push bx
      call @pm_randw
      pop bx
      pop ax
    endm
