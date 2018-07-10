CC=gcc
CFLAGS=-Wall -W -pedantic -O3

all: main

debug: parser.png parser.output

# Scanner and Parser

scanner.c scanner.h: scanner.l
	flex scanner.l

parser.c parser.h parser.output parser.dot: parser.y
	bison --graph --report=all parser.y

parser.png: parser.dot
	dot -Tpng parser.dot > parser.png

# Object files

ndom.o: ndom.c ndom.h

scanner.o: scanner.c parser.h

parser.o: parser.c scanner.h ndom.h

main.o: main.c ndom.h

.c.o:
	$(CC) -c $(CFLAGS) $< -o $@

# Link executable

main: main.o ndom.o scanner.o parser.o
	gcc -o $@ $?

clean:
	-rm -f *~ scanner.h scanner.c parser.h parser.c parser.dot parser.png parser.output *.o main
