
blinker.xe : blinker.xc
	xcc -target=STARTKIT blinker.xc -o blinker.xe 
	xobjdump -D blinker.xe > blinker.list
	# xflash blinker.xe

clean :
	rm -f *.xe
	rm -f *.list


