
# project settings
name := BestLoader
entry := efimain
firmware := UEFI # UEFI/BIOS

# directories
srcdir := src
bindir := bin
odir := $(bindir)/o

# files
asfiles := $(shell find $(srcdir) -name '*.asm')
ofiles := $(patsubst $(srcdir)/%.asm, $(odir)/%.o, $(asfiles))

# assembly
as := nasm
asflags := -f win64 -I$(srcdir) -D$(firmware)

# linker
ld := lld-link
ldflags := /subsystem:efi_application /entry:$(entry) /out:$(bindir)/$(name).efi $(ofiles)

# virtual machine
vm := qemu-system-x86_64
vmflags := -bios $(bindir)/OVMF.fd -drive format=raw,file=$(bindir)/$(name).img

# run OS using virtual machine
.PHONY: run
run: img ovmf
	@echo '   ==> Running $(vm): $(bindir)/$(name).img'
	@$(vm) $(vmflags)

# get UEFI (OVMF) binaries for emulation
.PHONY: ovmf
ovmf:
	@cp /usr/share/ovmf/x64/OVMF.4m.fd $(bindir)/OVMF.fd
	@echo '   ==> File Created: $(bindir)/OVMF.fd'

# create bootable disk image
.PHONY: img
img: link
	@dd if=/dev/zero of=$(bindir)/$(name).img bs=512 count=93750
	@parted $(bindir)/$(name).img -s -a minimal mklabel gpt
	@parted $(bindir)/$(name).img -s -a minimal mkpart EFI FAT16 2048s 93716s
	@parted $(bindir)/$(name).img -s -a minimal toggle 1 boot
	@dd if=/dev/zero of=$(bindir)/tmp.img bs=512 count=91669
	@mformat -i $(bindir)/tmp.img -h 32 -t 32 -n 64 -c 1
	@mmd -i $(bindir)/tmp.img ::/EFI
	@mmd -i $(bindir)/tmp.img ::/EFI/BOOT
	@mcopy -i $(bindir)/tmp.img $(bindir)/$(name).efi ::/EFI/BOOT/BOOTx64.EFI
	@dd if=$(bindir)/tmp.img of=$(bindir)/$(name).img bs=512 count=91669 seek=2048 conv=notrunc
	@echo '   ==> File Created: $(bindir)/tmp.img'
	@echo '   ==> File Created: $(bindir)/$(name).img'

# link all .o files into single .efi
.PHONY: link
link: $(ofiles)
	@$(ld) $(ldflags)
	@echo '   ==> File Created: $(bindir)/$(name).efi'

# produce .o file for each .asm
$(odir)/%.o: $(srcdir)/%.asm | bin
	@mkdir -p $(dir $@)
	@$(as) $(asflags) $< -o $@
	@echo '   ==> File Created: $@'

# create binaries directory
.PHONY: bin
bin:
	@mkdir -p $(bindir)
	@echo '   ==> Folder Created: $(bindir)'

# destroy binaries directory
.PHONY: clean
clean:
	@rm -rf $(bindir)
	@echo '   ==> Folder Destroyed: $(bindir)'
