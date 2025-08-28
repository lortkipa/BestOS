
; %1 - function to call
%macro eficall 1
    ; save non-volatile registers that Microsoft ABI does't
    push r10
    push r11

    ; allocate for shadow space
    sub rsp, 16

    ; call function
    call %1

    ; free shadow space
    add rsp, 16

    ; restore saved registers
    pop r11
    pop r10
%endmacro
