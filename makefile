program.o:
	nasm -f elf32 -g -F dwarf -o hw11.o hw11.asm

program:
	ld -m elf_i386 -o hw11 hw11.o

run:
	./hw11

clean:
	rm hw11.o
	rm *~

