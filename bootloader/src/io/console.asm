
%include 'efi.inc'

extern efist

bits 64
default rel

section .text

    ; IN rax - mode number
    global consetm
    consetm:
        efistartf

        ; load UEFI protocol
        mov rcx, [efist]
        mov rcx, [rcx + EFI_SYSTEM_TABLE.CONSOLE_OUT_PROTOCOL]

        ; put mode number into correct register
        mov rdx, rax

        ; call UEFI function
        eficall [rcx + EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.SET_MODE]

        efiendf
        ret

    ; IN rax - foreground color
    ; IN rcx - background color
    global consetc
    consetc:
        efistartf

        ; calculate final color and put it in correct register
        mov rdx, rcx
        shl rdx, 4
        xor rdx, rax

        ; load UEFI protocol
        mov rcx, [efist]
        mov rcx, [rcx + EFI_SYSTEM_TABLE.CONSOLE_OUT_PROTOCOL]

        ; call UEFI function
        eficall [rcx + EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.SET_ATTRIBUTE]

        efiendf
        ret

    global conclear
    conclear:
        efistartf

        ; load UEFI protocol
        mov rcx, [efist]
        mov rcx, [rcx + EFI_SYSTEM_TABLE.CONSOLE_OUT_PROTOCOL]
    
        ; call UEFI function
        eficall [rcx + EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.CLEAR_SCREEN]

        efiendf
        ret

    ; IN rax - string
    global conout
    conout:
        efistartf

        ; load UEFI protocol
        mov rcx, [efist]
        mov rcx, [rcx + EFI_SYSTEM_TABLE.CONSOLE_OUT_PROTOCOL]

        ; put text into correct register
        mov rdx, rax

        ; call UEFI function
        eficall [rcx + EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.OUTPUT_STRING]

        efiendf
        ret
