
%include 'io/keyboard.inc'

extern efist

bits 64
default rel

section .bss

    ; temp UEFI buffers
    efik: resb EFI_INPUT_KEY.SIZEB

section .text

    ; OUT eax - is any key pressed or not
    ; OUT ecx - unprintable special scancode
    ; OUT edx - printable character
    global kbread
    kbread:
        ; load UEFI protocol
        mov rcx, [efist]
        mov rcx, [rcx + EFI_SYSTEM_TABLE.CONSOLE_IN_PROTOCOL]

        ; load ptr to UEFI_KEY
        mov rdx, efik

        ; call UEFI function
        eficall [rcx + EFI_SIMPLE_TEXT_INPUT_PROTOCOL.READ_KEY_STROKE]

        ; output if key is pressed or not
        cmp rax, EFI_SUCCESS
        je .pressed
        mov eax, 0
        jmp .fpressed
        .pressed:
        mov eax, 1
        .fpressed:

        ; output scan code
        movzx ecx, word [efik + EFI_INPUT_KEY.SCAN_CODE]

        ; output printable character
        movzx edx, word [efik + EFI_INPUT_KEY.UNICODE_CHAR]

        ret

    global kbwait
    kbwait:
        ; load UEFI event
        mov r10, [efist]
        mov rdx, [r10 + EFI_SYSTEM_TABLE.CONSOLE_IN_PROTOCOL]
        mov rdx, [rdx + EFI_SIMPLE_TEXT_INPUT_PROTOCOL.WAIT_FOR_KEY]

        ; set number of events
        mov rcx, 1

        ; load UEFI event
        sub rsp, 8
        mov [rsp], rdx
        mov rdx, rsp

        ; load ptr to intiger
        sub rsp, 8
        mov r8, rsp

        ; call UEFI function
        mov r10, [r10 + EFI_SYSTEM_TABLE.BOOT_SERVICES]
        eficall [r10 + EFI_BOOT_SERVICES.WAIT_FOR_EVENT]

        ; unload stack
        add rsp, 16

        ret
