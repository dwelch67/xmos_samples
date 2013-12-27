
all : blink_asm.xe blink_asm_48.xe blink_xc.xe


blink_asm.xe : blink_asm.s blink_led.xn
	xas blink_asm.s -o blink_asm.o
	xcc -O2 blink_asm.o blink_led.xn -o blink_asm.xe -nostartfiles -nostdlib
	xobjdump -D blink_asm.xe > blink_asm.list

blink_asm.vcd : blink_asm.xe
	xsim --max-cycles 2000 --vcd-tracing "-o blink_asm.vcd -pads -ports -ports-detailed -cycles -cores -timers -clock-blocks -instructions -functions" blink_asm.xe


blink_asm_48.xe : blink_asm_48.s blink_led.xn
	xas blink_asm_48.s -o blink_asm_48.o
	xcc -O2 blink_asm_48.o blink_led.xn -o blink_asm_48.xe -nostartfiles -nostdlib
	xobjdump -D blink_asm_48.xe > blink_asm_48.list

blink_asm_48.vcd : blink_asm_48.xe
	xsim --max-cycles 2000 --vcd-tracing "-o blink_asm_48.vcd -pads -ports -ports-detailed -cycles -cores -timers -clock-blocks -instructions -functions" blink_asm_48.xe

blink_xc.xe : blink_xc.xc blink_led.xn
	xcc -O2 blink_xc.xc blink_led.xn -o blink_xc.xe
	xobjdump -D blink_xc.xe > blink_xc.list

blink_xc.vcd : blink_xc.xe
	xsim --max-cycles 2000 --vcd-tracing "-o blink_xc.vcd -pads -ports -ports-detailed -cycles -cores -timers -clock-blocks -instructions -functions" blink_xc.xe




clean :
	rm -f *.xe
	rm -rf *.o
	rm -f *.list
	rm -f *.vcd



