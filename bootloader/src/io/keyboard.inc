%ifndef IO_KEYBOARD_INC
%define IO_KEYBOARD_INC

%include 'efi.inc'

; special keys
%define KB_KEY_UARROW EFI_UPARROW
%define KB_KEY_DARROW EFI_DOWNARROW
%define KB_KEY_RARROW EFI_RIGHTARROW
%define KB_KEY_LARROW EFI_LEFTARROW
%define KB_KEY_DELETE EFI_DELETE
%define KB_KEY_PAGEU  EFI_PAGEUP
%define KB_KEY_PAGED  EFI_PAGEDOWN
%define KB_KEY_F1     EFI_F1
%define KB_KEY_F2     EFI_F2
%define KB_KEY_F3     EFI_F3
%define KB_KEY_F4     EFI_F4
%define KB_KEY_F5     EFI_F5
%define KB_KEY_F6     EFI_F6
%define KB_KEY_F7     EFI_F7
%define KB_KEY_F8     EFI_F8
%define KB_KEY_F9     EFI_F9
%define KB_KEY_F10    EFI_F10
%define KB_KEY_ESC    EFI_ESC

; special chars
%define KB_CHAR_ENTER EFI_CR

%endif
