%ifndef SYSTEM_RESET_INC
%define SYSTEM_RESET_INC

%include 'firmware/efi.inc'

; reset types
%define RESET_SHUTDOWN EFI_RESET_SHUTDOWN
%define RESET_REBOOT   EFI_RESET_COLD

%endif
