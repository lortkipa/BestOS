
%include 'io/console.inc'
%include 'io/keyboard.inc'
%include 'system/reset.inc'

extern consetc
extern conclear
extern conout
extern kbread
extern kbwait
extern reset

bits 64
default rel

section .data

    ; colors
    optfg:  db CONSOLE_COLOR_WHITE
    optbg:  db CONSOLE_COLOR_BLACK
    soptfg: db CONSOLE_COLOR_WHITE
    soptbg: db CONSOLE_COLOR_RED

    ; options
    sopt: db 0
    opt1: dw __utf16__('Boot BestOS'), CONSOLE_CHAR_LF, CONSOLE_CHAR_CR, 0
    opt2: dw __utf16__('Loader Configuration'), CONSOLE_CHAR_LF, CONSOLE_CHAR_CR, 0
    opt3: dw __utf16__('Reboot Computer'), CONSOLE_CHAR_LF, CONSOLE_CHAR_CR, 0
    opts: dq opt1, opt2, opt3
    optc: db ($ - opts) / 8

    ; keys
    optmoved: db KB_KEY_DARROW
    optmoveu: db KB_KEY_UARROW
    optact:   db KB_CHAR_ENTER

section .text

    global main
    main:
        .initshowopts:
        ; clear whole screen
        movzx rax, byte [optfg]
        movzx rcx, byte [optbg]
        eficall consetc
        eficall conclear

        ; setup options counter
        xor r10d, r10d

        .showopts:
            ; setup current option colors depending on if its selected or not
            cmp r10b, [sopt]
            jne .nsel
            .sel:
            movzx rax, byte [soptfg]
            movzx rcx, byte [soptbg]
            jmp .setc
            .nsel:
            movzx rax, byte [optfg]
            movzx rcx, byte [optbg]
            .setc:
            eficall consetc

            ; show current option
            mov rax, 8
            mul r10d
            mov rcx, opts
            add rax, rcx
            mov rax, [rax]
            eficall conout

            ; incriment counter and if it reached option count, stop the loop
            inc r10d
            cmp r10b, [optc]
            jne .showopts

        .prockeys:
            ; wait for input
            eficall kbwait
            eficall kbread

            ; if correct key is pressed, adjust selected option and draw them again
            cmp cl, [optmoved]
            jne .procoptdec
            mov r11d, [sopt]
            mov r12d, r11d
            inc r12d
            cmp r12b, [optc]
            je .prockeys
            inc r11d
            .nsoptinc:
            mov [sopt], r11d
            jmp .initshowopts
            .procoptdec:
            cmp cl, [optmoveu]
            jne .procoptact
            mov r11d, [sopt]
            cmp r11b, 0
            je .prockeys
            dec r11d
            mov [sopt], r11d
            jmp .initshowopts

            .procoptact:
            ; if correct key is pressed, call its action
            cmp dl, [optact]
            jne .initshowopts
            mov rax, RESET_REBOOT
            eficall reset
            jmp .initshowopts

        ret
