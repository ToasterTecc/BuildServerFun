all: hello2

hello2: hello.o
	gcc -Wall -std=c99 -o hello2 hello.o

hello.o: hello.c
	gcc -Wall -std=c99 -c hello.c

.PHONY: clean

clean:
	rm -f hello2 hello.o
