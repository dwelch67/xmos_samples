
figure8.xe : figure8.xc
	xcc -target=STARTKIT figure8.xc -o figure8.xe 
	xobjdump -D figure8.xe > figure8.list
	# xflash figure8.xe

clean :
	rm -f *.xe
	rm -f *.list


