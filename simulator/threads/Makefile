
all : thread_xc.xe thread_asm.xe  thread_hand0.xe thread_hand1.xe thread_hand2.xe

thread_xc.xe : thread_xc.xc threads.xn
	xcc -O2 thread_xc.xc threads.xn -o thread_xc.xe
	xobjdump -D thread_xc.xe > thread_xc.list

thread_xc.vcd : thread_xc.xe
	xsim --max-cycles 4000 --vcd-tracing "-o thread_xc.vcd -pads -ports -ports-detailed -cycles -cores -timers -clock-blocks -instructions -functions" thread_xc.xe


thread_hand0.xe : thread_hand0.s threads.xn
	xas thread_hand0.s -o thread_hand0.o
	xcc -O2 thread_hand0.o threads.xn -o thread_hand0.xe -nostartfiles -nostdlib
	xobjdump -D thread_hand0.xe > thread_hand0.list

thread_hand0.vcd : thread_hand0.xe
	xsim --max-cycles 4000 --vcd-tracing "-o thread_hand0.vcd -cycles -cores -timers -clock-blocks -instructions -functions" thread_hand0.xe

thread_hand1.xe : thread_hand1.s threads.xn
	xas thread_hand1.s -o thread_hand1.o
	xcc -O2 thread_hand1.o threads.xn -o thread_hand1.xe -nostartfiles -nostdlib
	xobjdump -D thread_hand1.xe > thread_hand1.list

thread_hand1.vcd : thread_hand1.xe
	xsim --max-cycles 4000 --vcd-tracing "-o thread_hand1.vcd -cycles -cores -timers -clock-blocks -instructions -functions" thread_hand1.xe

thread_hand2.xe : thread_hand2.s threads.xn
	xas thread_hand2.s -o thread_hand2.o
	xcc -O2 thread_hand2.o threads.xn -o thread_hand2.xe -nostartfiles -nostdlib
	xobjdump -D thread_hand2.xe > thread_hand2.list

thread_hand2.vcd : thread_hand2.xe
	xsim --max-cycles 4000 --vcd-tracing "-o thread_hand2.vcd -pads -ports -ports-detailed -cycles -cores -timers -clock-blocks -instructions -functions" thread_hand2.xe


thread_asm.xe : thread_asm.s threads.xn
	xas thread_asm.s -o thread_asm.o
	xcc -O2 thread_asm.o threads.xn -o thread_asm.xe -nostartfiles -nostdlib
	xobjdump -D thread_asm.xe > thread_asm.list

thread_asm.vcd : thread_asm.xe
	xsim --max-cycles 4000 --vcd-tracing "-o thread_asm.vcd -pads -ports -ports-detailed -cycles -cores -timers -clock-blocks -instructions -functions" thread_asm.xe


clean :
	rm -f *.xe
	rm -rf *.o
	rm -f *.list
	rm -f *.vcd



