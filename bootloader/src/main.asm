
%include 'io/console.inc'

extern consetc
extern conclear
extern conout

bits 64
default rel

section .data
    ; welcome dw __utf16__('Welcome To BestOS'), CONSOLE_CHAR_LF, CONSOLE_CHAR_CR, 0
    welcome dw __utf16__('Hello World!'), CONSOLE_CHAR_LF, CONSOLE_CHAR_CR, 0

section .text

    global main
    main:
        ; setup console environment
        mov rax, CONSOLE_COLOR_RED
        mov rcx, CONSOLE_COLOR_BLACK
        call consetc
        call conclear
        
        ; greet user
        mov rax, welcome
        call conout

        ret
