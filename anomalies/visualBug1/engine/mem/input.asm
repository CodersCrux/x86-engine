IDEAL

; Key Code Constants
DATASEG
  enum KeyCode {
    KC_ESC = 1h                            ; Escape
    KC_1 = 2h                              ; 1
    KC_EXCLAMATION = 2h                    ; !
    KC_2 = 3h                              ; 2
    KC_AT = 3h                             ; @
    KC_3 = 4h                              ; 3
    KC_HASH = 4h                           ; #
    KC_4 = 5h                              ; 4
    KC_DOLLAR = 5h                         ; $
    KC_5 = 6h                              ; 5
    KC_PERCENT = 6h                        ; %
    KC_6 = 7h                              ; 6
    KC_CARET = 7h                          ; ^
    KC_7 = 8h                              ; 7
    KC_AMPERSTAND = 8h                     ; &
    KC_8 = 9h                              ; 8
    KC_ASTERISK = 9h                       ; *
    KC_9 = 0Ah                             ; 9
    KC_BRACKET_OPEN = 0Ah                  ; (
    KC_0 = 0Bh                             ; 0
    KC_BRACKET_CLOSED = 0Bh                ; )
    KC_DASH = 0Ch                          ; -
    KC_UNDERSCORE = 0Ch                    ; _
    KC_EQUALS = 0Dh                        ; =
    KC_PLUS = 0Dh                          ; +
    KC_BACKSPACE = 0Eh                     ; Backspace
    KC_TAB = 0Fh                           ; Tab
    KC_Q = 10h                             ; Q
    KC_W = 11h                             ; W
    KC_E = 12h                             ; E
    KC_R = 13h                             ; R
    KC_T = 14h                             ; T
    KC_Y = 15h                             ; Y
    KC_U = 16h                             ; U
    KC_I = 17h                             ; I
    KC_O = 18h                             ; O
    KC_P = 19h                             ; P
    KC_SQUARE_BRACKET_OPEN  = 1Ah          ; [
    KC_CURLY_BRACKET_OPEN = 1Ah            ; {
    KC_SQUARE_BRACKET_CLOSED = 1Bh         ; ]
    KC_CURLY_BRACKET_CLOSED = 1Bh          ; }
    KC_ENTER = 1Ch                         ; Enter
    KC_CONTROL = 1Dh                       ; Control
    KC_A = 1Eh                             ; A
    KC_S = 1Fh                             ; S
    KC_D = 20h                             ; D
    KC_F = 21h                             ; F
    KC_G = 22h                             ; G
    KC_H = 23h                             ; H
    KC_J = 24h                             ; J
    KC_K = 25h                             ; K
    KC_L = 26h                             ; L
    KC_COLON = 27h                         ; :
    KC_QUOTE = 28h                         ; '
    KC_DOUBLE_QUOTE = 28h                  ; "
    KC_BACKTICK = 29h                      ; `
    KC_TILDE = 29h                         ; ~
    KC_LEFT_SHIFT = 2Ah                    ; Left Shift
    KC_BACKSLASH = 2Bh                     ; \
    KC_BAR = 2Bh                           ; |
    KC_Z = 2Ch                             ; Z
    KC_X = 2Dh                             ; X
    KC_C = 2Eh                             ; C
    KC_V = 2Fh                             ; V
    KC_B = 30h                             ; B
    KC_N = 31h                             ; N
    KC_M = 32h                             ; M
    KC_COMMA = 33h                         ; ,
    KC_LESS = 33h                          ; <
    KC_PERIOD = 34h                        ; .
    KC_GREATER = 34h                       ; >
    KC_SLASH = 35h                         ; /
    KC_QUESTION = 35h                      ; ?
    KC_RIGHT_SHIFT = 36h                   ; Right Shift
    KC_ALT = 38h                           ; Alt
    KC_SPACE = 39h                         ; Space
    KC_CAPSLOCK = 3Ah                      ; CapsLock
    KC_F1 = 3Bh                            ; F1
    KC_F2 = 3Ch                            ; F2
    KC_F3 = 3Dh                            ; F3
    KC_F4 = 3Eh                            ; F4
    KC_F5 = 3Fh                            ; F5
    KC_F6 = 40h                            ; F6
    KC_F7 = 41h                            ; F7
    KC_F8 = 42h                            ; F8
    KC_F9 = 43h                            ; F9
    KC_F10 = 44h                           ; F10
    KC_NUMLOCK = 45h                       ; NumLock
    KC_SCROLLLOCK = 46h                    ; ScrollLock
    KC_HOME = 47h                          ; Home
    KC_UP = 48h                            ; Up Arrow
    KC_PAGE_UP = 49h                       ; Page Up
    KC_LEFT = 4Bh                          ; Left Arrow
    KC_RIGHT = 4Dh                         ; Right Array
    KC_END = 4Fh                           ; End
    KC_DOWN = 50h                          ; Down Arrow
    KC_PAGE_DOWN = 51h                     ; Page Down
    KC_INSERT = 52h                        ; Insert
    KC_DELETE = 53h                        ; Delete
    KC_F11 = 57h                           ; F11
    KC_F12 = 58h                           ; F12
  }

  macro i_check
      push ax
      push bx
      call @pi_check
      pop bx
      pop ax
    endm

  macro i_update
      push es
      push si
      push di
      push cx
      push ax
      mov ax, ds
      mov es, ax
      pop ax
      lea si, [@kbd]
      lea di, [@kbdLast]
      mov cx, 64
      rep movsw
      pop cx
      pop di
      pop si
    endm

  macro if_key key
      push [word @tempIP]
      push bx
      push key
      call @pi_key
      pop bx
      pop [word @tempIP]
    endm

  macro if_keyDown key
      push [word @tempIP]
      push bx
      push cx
      push si
      push key
      call @pi_keyDown
      pop si
      pop cx
      pop bx
      pop [word @tempIP]
    endm

  macro if_keyUp key
      push [word @tempIP]
      push bx
      push cx
      push si
      push key
      call @pi_keyUp
      pop si
      pop cx
      pop bx
      pop [word @tempIP]
    endm
