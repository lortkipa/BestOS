
%include 'firmware/efi.inc'

extern efist

bits 64
default rel

section .text

    ; IN rax - reset types
    global reset
    reset:
        ; put reset types in register
        mov rcx, rax

        ; default params
        mov rdx, EFI_SUCCESS
        mov r8, 0
        mov r9, 0

        ; call UEFI function
        mov rax, [efist]
        mov rax, [rax + EFI_SYSTEM_TABLE.RUNTIME_SERVICES]
        eficall [rax + EFI_RUNTIME_SERVICES.RESET_SYSTEM]

        ret
