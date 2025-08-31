
%include 'io/console.inc'

extern efist

bits 64
default rel

section .text

    ; IN rax - mode number
    global consetm
    consetm:
        ; load UEFI protocol
        mov rcx, [efist]
        mov rcx, [rcx + EFI_SYSTEM_TABLE.CONSOLE_OUT_PROTOCOL]

        ; put mode number into correct register
        mov rdx, rax

        ; call UEFI function
        eficall [rcx + EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.SET_MODE]

        ret

    ; IN rax - foreground color
    ; IN rcx - background color
    global consetc
    consetc:
        ; calculate final color and put it in correct register
        mov rdx, rcx
        shl rdx, 4
        xor rdx, rax

        ; load UEFI protocol
        mov rcx, [efist]
        mov rcx, [rcx + EFI_SYSTEM_TABLE.CONSOLE_OUT_PROTOCOL]

        ; call UEFI function
        eficall [rcx + EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.SET_ATTRIBUTE]

        ret

    ; IN eax - x pos
    ; IN ecx - y pos
    global consetp
    consetp:
        ; put position into right registers
        mov edx, eax
        mov r8d, ecx

        ; load UEFI protocol
        mov rcx, [efist]
        mov rcx, [rcx + EFI_SYSTEM_TABLE.CONSOLE_OUT_PROTOCOL]
    
        ; call UEFI function
        eficall [rcx + EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.SET_CURSOR_POSITION]

        ret

    ; OUT eax - x pos
    ; OUT ecx - y pos
    global congetp
    congetp:
        ; get EFI_SIMPLE_TEXT_OUTPUT_MODE structure
        mov rdx, [efist]
        mov rdx, [rdx + EFI_SYSTEM_TABLE.CONSOLE_OUT_PROTOCOL]
        mov rdx, [rdx + EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.MODE]

        ; output position
        mov eax, [rdx + EFI_SIMPLE_TEXT_OUTPUT_MODE.CURSOR_COLUMN]
        mov ecx, [rdx + EFI_SIMPLE_TEXT_OUTPUT_MODE.CURSOR_ROW]

        ret

    global conclear
    conclear:
        ; load UEFI protocol
        mov rcx, [efist]
        mov rcx, [rcx + EFI_SYSTEM_TABLE.CONSOLE_OUT_PROTOCOL]
    
        ; call UEFI function
        eficall [rcx + EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.CLEAR_SCREEN]

        ret

    ; IN rax - string
    global conout
    conout:
        ; load UEFI protocol
        mov rcx, [efist]
        mov rcx, [rcx + EFI_SYSTEM_TABLE.CONSOLE_OUT_PROTOCOL]

        ; put text into correct register
        mov rdx, rax

        ; call UEFI function
        eficall [rcx + EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.OUTPUT_STRING]

        ret
