
%include 'io/console.inc'
%include 'io/keyboard.inc'

extern consetc
extern conclear
extern conout
extern kbread
extern kbwait

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
    opt3: dw __utf16__('Reboot PC'), CONSOLE_CHAR_LF, CONSOLE_CHAR_CR, 0
    opts: dq opt1, opt2, opt3
    optc: db ($ - opts) / 8

    ; keys
    optmoved: db KB_KEY_DARROW
    optmoveu: db KB_KEY_UARROW

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
            jne .procuarrow
            mov eax, [sopt]
            mov edx, eax
            inc edx
            cmp dl, [optc]
            je .prockeys
            inc eax
            .nsoptinc:
            mov [sopt], eax
            jmp .initshowopts
            .procuarrow:
            cmp cl, [optmoveu]
            jne .prockeys
            mov eax, [sopt]
            cmp al, 0
            je .prockeys
            dec eax
            mov [sopt], eax
            jmp .initshowopts

        ret
