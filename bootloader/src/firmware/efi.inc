%ifndef EFI_INC
%define EFI_INC

; %1 - function to call
%macro eficall 1
    ; save non-volatile registers that Microsoft ABI does't
    push r10
    push r11

    ; allocate for shadow space
    sub rsp, 16

    call %1

    ; free shadow space
    add rsp, 16

    ; restore saved registers
    pop r11
    pop r10
%endmacro

; error codes
%define EFI_SUCCESS 0

; console colors
%define EFI_BLACK        0x00
%define EFI_BLUE         0x01
%define EFI_GREEN        0x02
%define EFI_CYAN         0x03
%define EFI_RED          0x04
%define EFI_MAGENTA      0x05
%define EFI_BROWN        0x06
%define EFI_LIGHTGRAY    0x07
%define EFI_DARKGRAY     0x08
%define EFI_LIGHTBLUE    0x09
%define EFI_LIGHTGREEN   0x0A
%define EFI_LIGHTCYAN    0x0B
%define EFI_LIGHTRED     0x0C
%define EFI_LIGHTMAGENTA 0x0D
%define EFI_YELLOW       0x0E
%define EFI_WHITE        0x0F

; console special characters
%define EFI_BS 0x0008
%define EFI_LF 0x000A
%define EFI_CR 0x000D

; special key scancodes
%define EFI_UPARROW    0x01
%define EFI_DOWNARROW  0x02
%define EFI_RIGHTARROW 0x03
%define EFI_LEFTARROW  0x04
%define EFI_DELETE     0x08
%define EFI_PAGEUP     0x09
%define EFI_PAGEDOWN   0x0A
%define EFI_F1         0x0B
%define EFI_F2         0x0C
%define EFI_F3         0x0D
%define EFI_F4         0x0E
%define EFI_F5         0x0F
%define EFI_F6         0x10
%define EFI_F7         0x11
%define EFI_F8         0x12
%define EFI_F9         0x13
%define EFI_F10        0x14
%define EFI_ESC        0x17

; reset types
%define EFI_RESET_COLD              0
%define EFI_RESET_WARM              1
%define EFI_RESET_SHUTDOWN          2
%define EFI_RESET_PLATFORM_SPECIFIC 3

struc EFI_GUID
    .DATA1: resd 1
    .DATA2: resw 1
    .DATA3: resw 1
    .DATA4: resb 8
    .SIZEB:
endstruc

struc EFI_TABLE_HEADER
    .SIGNATURE:  resq 1
    .REVISION:   resd 1
    .TABLE_SIZE: resd 1
    .CRC32:      resd 1
    .RESERVED:   resd 1
    .SIZEB:
endstruc

struc EFI_SYSTEM_TABLE
    .TABLE_HEADER:         resb EFI_TABLE_HEADER.SIZEB
    .FIRMWARE_VENDOR:      resq 1
    .FIRMWARE_REVISION:    resd 1
                           resd 1
    .CONSOLE_IN_HANDLE:    resq 1
    .CONSOLE_IN_PROTOCOL:  resq 1
    .CONSOLE_OUT_HANDLE:   resq 1
    .CONSOLE_OUT_PROTOCOL: resq 1
    .CONSOLE_ERR_HANDLE:   resq 1
    .CONSOLE_ERR_PROTOCOL: resq 1
    .RUNTIME_SERVICES:     resq 1
    .BOOT_SERVICES:        resq 1
    .CONFIG_TABLE_COUNT:   resq 1
    .CONFIG_TABLES:        resq 1
    .SIZEB:
endstruc

struc EFI_BOOT_SERVICES
    .TABLE_HEADER:                           resb EFI_TABLE_HEADER.SIZEB
    .RAISE_TPL:                              resq 1
    .RESTORE_TPL:                            resq 1
    .ALLOCATE_PAGES:                         resq 1
    .FREE_PAGES:                             resq 1
    .GET_MEMORY_MAP:                         resq 1
    .ALLOCATE_POOL:                          resq 1
    .FREE_POOL:                              resq 1
    .CREATE_EVENT:                           resq 1
    .SET_TIMER:                              resq 1
    .WAIT_FOR_EVENT:                         resq 1
    .SIGNAL_EVENT:                           resq 1
    .CLOSE_EVENT:                            resq 1
    .CHECK_EVENT:                            resq 1
    .INSTALL_PROTOCOL_INTERFACE:             resq 1
    .REINSTALL_PROTOCOL_INTERFACE:           resq 1
    .UNINSTALL_PROTOCOL_INTERFACE:           resq 1
    .HANDLE_PROTOCOL:                        resq 1
    .RESERVED:                               resq 1
    .REGISTER_PROTOCOL_NOTIFY:               resq 1
    .LOCATE_HANDLE:                          resq 1
    .LOCATE_DEVICE_PATH:                     resq 1
    .INSTALL_CONFIGURATION_TABLE:            resq 1
    .LOAD_IMAGE:                             resq 1
    .START_IMAGE:                            resq 1
    .EXIT_IMAGE:                             resq 1
    .UNLOAD_IMAGE:                           resq 1
    .EXIT_BOOT_SERVICES:                     resq 1
    .GET_NEXT_MONOTONIC_COUNT:               resq 1
    .STALL:                                  resq 1
    .SET_WATCHDOG_TIMER:                     resq 1
    .CONNECT_CONTROLLER:                     resq 1
    .DISCONNECT_CONTROLLER:                  resq 1
    .OPEN_PROTOCOL:                          resq 1
    .CLOSE_PROTOCOL:                         resq 1
    .OPEN_PROTOCOL_INFORMATION:              resq 1
    .PROTOCOLS_PER_HANDLE:                   resq 1
    .LOCATE_HANDLE_BUFFER:                   resq 1
    .LOCATE_PROTOCOL:                        resq 1
    .INSTALL_MULTIPLE_PROTOCOL_INTERFACES:   resq 1
    .UNINSTALL_MULTIPLE_PROTOCOL_INTERFACES: resq 1
    .CALCULATE_CRC32:                        resq 1
    .COPY_MEM:                               resq 1
    .SET_MEM:                                resq 1
    .CREATE_EVENT_EX:                        resq 1
    .SIZEB:
endstruc

struc EFI_RUNTIME_SERVICES
    .TABLE_HEADER:                  resb EFI_TABLE_HEADER.SIZEB
    .GET_TIME:                      resq 1
    .SET_TIME:                      resq 1
    .GET_WAKEUP_TIME:               resq 1
    .SET_WAKEUP_TIME:               resq 1
    .SET_VIRTUAL_ADDRESS_MAP:       resq 1
    .CONVERT_POINTER:               resq 1
    .GET_VARIABLE:                  resq 1
    .GET_NEXT_VARIABLE_NAME:        resq 1
    .SET_VARIAVLE:                  resq 1
    .GET_NEXT_HIGH_MONOTONIC_COUNT: resq 1
    .RESET_SYSTEM:                  resq 1
    .UPDATE_CAPSULE:                resq 1
    .QUERY_VARIABLE_INFO:           resq 1
    .SIZEB:
endstruc

struc EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL
    .RESET:                resq 1
    .OUTPUT_STRING:        resq 1
    .TEST_STIRNG:          resq 1
    .QUERY_MODE:           resq 1
    .SET_MODE:             resq 1
    .SET_ATTRIBUTE:        resq 1
    .CLEAR_SCREEN:         resq 1
    .SET_CURSOR_POSITION:  resq 1
    .ENABLE_CURSOR:        resq 1
    .MODE:                 resq 1
    .SIZEB:
endstruc

struc EFI_SIMPLE_TEXT_OUTPUT_MODE
    .MAX_MODE:      resd 1
    .MODE:          resd 1
    .ATTRIBUTE:     resd 1
    .CURSOR_COLUMN: resd 1
    .CURSOR_ROW:    resd 1
    .SIZEB:
endstruc

struc EFI_SIMPLE_TEXT_INPUT_PROTOCOL
    .RESET:           resq 1
    .READ_KEY_STROKE: resq 1
    .WAIT_FOR_KEY:    resq 1
    .SIZEB:
endstruc

struc EFI_INPUT_KEY
    .SCAN_CODE    resw 1
    .UNICODE_CHAR resw 1
    .SIZEB:
endstruc

%endif
