all: hello3

hello3: hello.o
	gcc -Wall -std=c99 -o hello3 hello.o

hello.o: hello.c
	gcc -Wall -std=c99 -c hello.c

.PHONY: clean

clean:
	rm -f hello3 hello.o
