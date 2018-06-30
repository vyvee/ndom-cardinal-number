CC=gcc
CFLAGS=-Wall -W -pedantic -O3

all: ndom

# Scanner and Parser

scanner.c scanner.h: scanner.l
	flex scanner.l

parser.c parser.h: parser.y
	bison parser.y

# Object files

ndom.o: ndom.c scanner.h parser.h

scanner.o: scanner.c parser.h

parser.o: parser.c

.c.o:
	$(CC) -c $(CFLAGS) $< -o $@

# Link executable

ndom: ndom.o scanner.o parser.o
	gcc -o $@ $?

clean:
	-rm -f *~ scanner.h scanner.c parser.h parser.c *.o ndom
