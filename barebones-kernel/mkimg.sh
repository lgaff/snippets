gcc -o kernel.o kernel.c -nostdlibs -nostartfiles -nodefaultlibs 
ld -T linker.ld -o kernel.bin loader.o kernel.o
cat stage1 stage2 pad kernel.bin > floppy.img
