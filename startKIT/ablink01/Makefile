
ablink01.xe : ablink01.s
	xas ablink01.s -o ablink01.o
	xcc -target=STARTKIT ablink01.o -o ablink01.xe -nostartfiles -nostdlib

clean :
	rm -f ablink01.o
	rm -f ablink01.xe


