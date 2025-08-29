
%include 'efi.inc'

extern efist

bits 64
default rel

section .text

    ; OUT rax - is any key pressed or not
    global kbread
    kbread:
        ; load UEFI protocol
        mov rcx, [efist]
        mov rcx, [rcx + EFI_SYSTEM_TABLE.CONSOLE_IN_PROTOCOL]

        ; call UEFI function
        eficall [rcx + EFI_SIMPLE_TEXT_INPUT_PROTOCOL.READ_KEY_STROKE]

        ; output if key is pressed or not
        cmp rax, EFI_SUCCESS
        je .pressed
        mov rax, 0
        jmp .fpressed
        .pressed:
        mov rax, 1
        .fpressed:

        ret

    global kbwait
    kbwait:
        ; load UEFI event
        mov r10, [efist]
        mov rdx, [r10 + EFI_SYSTEM_TABLE.CONSOLE_IN_PROTOCOL]
        mov rdx, [rdx + EFI_SIMPLE_TEXT_INPUT_PROTOCOL.WAIT_FOR_KEY]

        ; event count is 1
        mov rcx, 1

        ; load ptr to EFI_EVENT
        sub rsp, 8
        mov [rsp], rdx
        mov rdx, rsp

        ; load ptr to index
        sub rsp, 8
        mov r8, rsp

        ; call UEFI function
        mov r10, [r10 + EFI_SYSTEM_TABLE.BOOT_SERVICES]
        eficall [r10 + EFI_BOOT_SERVICES.WAIT_FOR_EVENT]

        ; unload params
        add rsp, 16

        ret
