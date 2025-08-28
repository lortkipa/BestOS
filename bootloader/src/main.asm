
bits 64
default rel

section .text

    global main
    main:
        ; align stack to 16byte
        sub rsp, 8

        ; infinite loop
        jmp $
    
        ret
