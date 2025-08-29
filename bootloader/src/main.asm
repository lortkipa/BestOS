
%include 'io/console.inc'

extern consetc
extern conclear
extern conout
extern kbread
extern kbwait

bits 64
default rel

section .data

    welcome dw __utf16__('Welcome To BestOS'), CONSOLE_CHAR_LF, CONSOLE_CHAR_CR, 0

section .text

    global main
    main:
        ; setup console environment
        mov rax, CONSOLE_COLOR_RED
        mov rcx, CONSOLE_COLOR_BLACK
        eficall consetc
        eficall conclear

        ; greet user
        eficall kbwait
        mov rax, welcome
        eficall conout

        ret
