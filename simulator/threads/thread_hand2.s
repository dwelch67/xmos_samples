
# this example actually doesnt handshake it demonstrates that the
# Cores can/do run independently.  Thread/Core0 creates the other 7
# threads and starts them.  Each one separately attaches to its own
# output port of the xcore (that doesnt mean that for this sim each
# of the xcores output ports are tied to a pin in this package, using
# the simulation we can see the xcore ports.  Each thread has a
# different count down before it changes the state of its output port.

# the cores are not in the true sense of the word parallel, by looking
# at the INSTRUCTION_THREAD_ID signal in the vcd waveforms and the
# CYCLES signal, you can see that each thread gets one clock cycle
# and it goes round robin Core0, Core1, Core2 ... Core 7, Core 0...
# at least here it is I dont know if that is always true.

_start:
    ldc r1, 10
notmain:                # what was this loop for?
    sub r1,r1,1
    bt r1, notmain

    ldc  r11, 0x6       # the I/O ports need a clock
    setc res[r11], 0x8  # setci
    setc res[r11], 0xf  # setci

    getr r4,0x3         # get a synchronizer
    getst r0,res[r4]    # allocate a thread
    ldap r11,thread1    # get address for the code for new thread
    init t[r0]:pc,r11   # set pc for new thread
    getst r0,res[r4]    # allocate a thread
    ldap r11,thread2    # get address for the code for new thread
    init t[r0]:pc,r11   # set pc for new thread
    getst r0,res[r4]    # allocate a thread
    ldap r11,thread3    # get address for the code for new thread
    init t[r0]:pc,r11   # set pc for new thread
    getst r0,res[r4]    # allocate a thread
    ldap r11,thread4    # get address for the code for new thread
    init t[r0]:pc,r11   # set pc for new thread
    getst r0,res[r4]    # allocate a thread
    ldap r11,thread5    # get address for the code for new thread
    init t[r0]:pc,r11   # set pc for new thread
    getst r0,res[r4]    # allocate a thread
    ldap r11,thread6    # get address for the code for new thread
    init t[r0]:pc,r11   # set pc for new thread
    getst r0,res[r4]    # allocate a thread
    ldap r11,thread7    # get address for the code for new thread
    init t[r0]:pc,r11   # set pc for new thread

    msync res[r4]       # start all allocated threads
    bu thread0          # give thread 0, the main thread, a place to go

common_main:
    shl r11,r11,4
    setc res[r11],0x8   # turn port on
    ldc r1,0x6
    setclk res[r11],r1  #connect port to a clock
    ldc r0,0x0
    ldc r1,0x1
outer:
    out res[r11],r0

    mov r2,r3
inner:
    sub r2,r2,1
    bt r2,inner

    xor r0,r0,r1
    bu outer

thread0:
    # define XS1_PORT_1A 0x10200
    ldc r11,0x1020
    ldc r3,0x11
    bu common_main

thread1:
    # define XS1_PORT_1B 0x10000
    ldc r11,0x1000
    ldc r3,0x22
    bu common_main

thread2:
    # define XS1_PORT_1C 0x10100
    ldc r11,0x1010
    ldc r3,0x33
    bu common_main

thread3:
    # define XS1_PORT_1D 0x10300
    ldc r11,0x1030
    ldc r3,0x44
    bu common_main

thread4:
    # define XS1_PORT_1E 0x10600
    ldc r11,0x1060
    ldc r3,0x55
    bu common_main

thread5:
    # define XS1_PORT_1F 0x10400
    ldc r11,0x1040
    ldc r3,0x66
    bu common_main

thread6:
    # define XS1_PORT_1G 0x10500
    ldc r11,0x1050
    ldc r3,0x77
    bu common_main

thread7:
    # define XS1_PORT_1H 0x10700
    ldc r11,0x1070
    ldc r3,0x88
    bu common_main

