
%include 'firmware/efi.inc'

extern main
extern consetm

bits 64
default rel

section .bss
    
    global efist
    efist: resq 1

section .text

    ; IN rcx - image handle
    ; IN rdx - ptr to EFI_SYSTEM_TABLE
    global efimain
    efimain:
        ; align stack to 16-byte
        sub rsp, 8

        ; store UEFI data
        mov [efist], rdx

        ; setup 80x25 text mode as default
        ; mov rax, EFI_80X25
        ; eficall consetm

        ; call bootloader main function
        eficall main

        ; infinite loop
        jmp $
    
        ret
