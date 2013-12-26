
ablink03.xe : ablink03.s
	xas ablink03.s -o ablink03.o
	xcc -target=STARTKIT ablink03.o -o ablink03.xe -nostartfiles -nostdlib

clean :
	rm -f ablink03.o
	rm -f ablink03.xe


