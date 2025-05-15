program.o:
	nasm -f elf32 -g -F dwarf -o translate2ascii.o translate2ascii.asm

extracredit.o:
	nasm -f elf32 -g -F dwarf -o translate2ascii_ExtraCredit.o translate2ascii_ExtraCredit.asm

program:
	ld -m elf_i386 -o translate2ascii translate2ascii.o

extracredit:
	ld -m elf_i386 -o translate2ascii_ExtraCredit translate2ascii_ExtraCredit.o

run:
	./translate2ascii

run2:
	./translate2ascii_ExtraCredit

clean:
	rm ~.o
	rm *~

