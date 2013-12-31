
all : thread_xc.xe thread_asm.xe  thread_hand0.xe thread_hand1.xe thread_hand2.xe thread_hand5.xe

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



thread_hand3.xe : thread_hand3.s threads.xn
	xas thread_hand3.s -o thread_hand3.o
	xcc -O2 thread_hand3.o threads.xn -o thread_hand3.xe -nostartfiles -nostdlib
	xobjdump -D thread_hand3.xe > thread_hand3.list

thread_hand3.vcd : thread_hand3.xe
	xsim --max-cycles 4000 --vcd-tracing "-o thread_hand3.vcd -ports -ports-detailed -cycles -cores -timers -clock-blocks -instructions -functions" thread_hand3.xe



thread_hand4.xe : thread_hand4.s threads.xn
	xas thread_hand4.s -o thread_hand4.o
	#xcc -O2 thread_hand4.o -target=STARTKIT -o thread_hand4.xe -nostartfiles -nostdlib -nodefaultlibs 
	#xcc -O2 thread_hand4.o XS1-U16A-128-FB217-C10.xn -o thread_hand4.xe -nostartfiles -nostdlib -nodefaultlibs 
	xcc -O2 thread_hand4.o hello.xn -o thread_hand4.xe -nostartfiles -nostdlib -nodefaultlibs 
	#xmap -targetfile=hello.xn --defsymbol _default_clkblk=0x6 -march=xs1b -o thread_hand4.xe --first thread_hand4.o 
	xobjdump -D thread_hand4.xe > thread_hand4.list

thread_hand4.vcd : thread_hand4.xe
	xsim --max-cycles 4000 --vcd-tracing "-o thread_hand4.vcd -ports -ports-detailed -cycles -cores -timers -clock-blocks -instructions -functions" thread_hand4.xe




thread_hand5.xe : thread_hand5.s threads.xn
	xas thread_hand5.s -o thread_hand5.o
	#xcc -O2 thread_hand5.o -target=STARTKIT -o thread_hand5.xe -nostartfiles -nostdlib -nodefaultlibs 
	#xcc -O2 thread_hand5.o XS1-U16A-128-FB217-C10.xn -o thread_hand5.xe -nostartfiles -nostdlib -nodefaultlibs 
	xcc -O2 thread_hand5.o hello.xn -o thread_hand5.xe -nostartfiles -nostdlib -nodefaultlibs 
	#xmap -targetfile=hello.xn --defsymbol _default_clkblk=0x6 -march=xs1b -o thread_hand5.xe --first thread_hand5.o 
	xobjdump -D thread_hand5.xe > thread_hand5.list

thread_hand5.vcd : thread_hand5.xe
	xsim --max-cycles 4000 --vcd-tracing "-o thread_hand5.vcd -ports -ports-detailed -cycles -cores -timers -clock-blocks -instructions -functions" thread_hand5.xe




thread_hand6.xe : thread_hand6.s threads.xn
	xas thread_hand6.s -o thread_hand6.o
	#xcc -O2 thread_hand6.o -target=STARTKIT -o thread_hand6.xe -nostartfiles -nostdlib -nodefaultlibs 
	#xcc -O2 thread_hand6.o XS1-U16A-128-FB217-C10.xn -o thread_hand6.xe -nostartfiles -nostdlib -nodefaultlibs 
	xcc -O2 thread_hand6.o hello.xn -o thread_hand6.xe -nostartfiles -nostdlib -nodefaultlibs 
	#xmap -targetfile=hello.xn --defsymbol _default_clkblk=0x6 -march=xs1b -o thread_hand6.xe --first thread_hand6.o 
	xobjdump -D thread_hand6.xe > thread_hand6.list

thread_hand6.vcd : thread_hand6.xe
	xsim --max-cycles 4000 --vcd-tracing "-o thread_hand6.vcd -ports -ports-detailed -cycles -cores -timers -clock-blocks -instructions -functions" thread_hand6.xe



thread_xtest.xe : thread_xtest.xc dummy.xc threads.xn hello.xn
	xcc -O2 thread_xtest.xc dummy.xc hello.xn -o thread_xtest.xe
	xobjdump -D thread_xtest.xe > thread_xtest.list

thread_xtest.vcd : thread_xtest.xe
	xsim --max-cycles 4000 --vcd-tracing "-o thread_xtest.vcd -ports -ports-detailed -cycles -cores -timers -clock-blocks -instructions -functions" thread_xtest.xe



thread_asm.xe : thread_asm.s threads.xn
	xas thread_asm.s -o thread_asm.o
	xcc -O2 thread_asm.o threads.xn -o thread_asm.xe -nostartfiles -nostdlib -nodefaultlibs 
	xobjdump -D thread_asm.xe > thread_asm.list

thread_asm.vcd : thread_asm.xe
	xsim --max-cycles 4000 --vcd-tracing "-o thread_asm.vcd -pads -ports -ports-detailed -cycles -cores -timers -clock-blocks -instructions -functions" thread_asm.xe


clean :
	rm -f *.xe
	rm -rf *.o
	rm -f *.list
	rm -f *.vcd



