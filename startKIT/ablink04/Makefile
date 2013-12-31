
ablink04.xe : ablink04.s
	xas ablink04.s -o ablink04.o
	xcc -target=STARTKIT ablink04.o -o ablink04.xe -nostartfiles -nostdlib

clean :
	rm -f ablink04.o
	rm -f ablink04.xe


