
ablink02.xe : ablink02.s
	xas ablink02.s -o ablink02.o
	xcc -target=STARTKIT ablink02.o -o ablink02.xe -nostartfiles -nostdlib

clean :
	rm -f ablink02.o
	rm -f ablink02.xe


