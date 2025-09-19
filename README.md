## About the project
BestOS is fast, free and open-source operating system for x86_64 architecture.  
It is written in assembly programing language for various reasons, but mainly for it's fast build time and possible runtime performance.  

## Documentation
### Calling conventions
* 16 byte stack aligment.  
* First 10 intiger/pointer argument and return value registers: RAX, RCX, RDX, RBX, RSI, RDI, R8, R9, R10, R11.  
* volatile registers: RAX, RCX, RDX, RBX, RSI, RDI, R8, R9, R10, R11.  
* nonvolatile registers: RSP, RBP, R12, R13, R14, R15.  

### Bootloader
Both UEFI and legacy (BIOS) boot options are supported.  
Configuration file can be used to control:  
* GUI.  
Show loader menu (default): `GUI : true`  
Load first module without showing loader menu: `GUI : false`  
* Modules in loader menu.  
Load kernel example: `BestOS > /Boot/BestOS.efi`
* Comments.  
Single line comment: `# Hello World!`  
