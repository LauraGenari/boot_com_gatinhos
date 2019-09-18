# boot_com_gatinhos
O tal do boot com coisa legal

Roda o código com os comandos de terminal

nasm -f bin gatinho.asm -o gatinho.bin
qemu-system-i386 -drive format=raw,file=gatinho.bin -net none
