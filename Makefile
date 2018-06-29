CC=gcc
CFLAGS=-Wall -W -pedantic -O3

all: ndom

# Scanner and Parser

scanner.c: scanner.l
	flex -o $@ $<

parser.c parser.h: parser.y
	bison -o parser.c -d parser.y

# Object files

scanner.o: scanner.c parser.h

parser.o: parser.c

.c.o:
	$(CC) -c $(CFLAGS) $< -o $@

# Link executable

ndom: scanner.o parser.o parser.h
	gcc -o $@ $?

clean:
	-rm -f *~ parser.c parser.h scanner.c *.o ndom
