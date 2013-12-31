
# DONT DO THIS, THIS IS A NO-NO SHOULD HAVE SEPARATE CHANNELS FOR EACH PAIR OF THREADS.


_start:
    ldc r1, 10
notmain:                # what was this loop for?
    sub r1,r1,1
    bt r1, notmain

    ldc  r11, 0x6       # the I/O ports need a clock
    setc res[r11], 0x8  # setci
    setc res[r11], 0xf  # setci

    # define XS1_PORT_32A 0x200000
    ldc r8,0x2000
    shl r8,r8,8
    setc res[r8],0x8    # turn the port on
    ldc r1,0x6          # give it a clock
    setclk res[r8],r1

    getr r5,2           # allocate a channel end for thread 0
    setd res[r5],r5

    getr r4,0x3         # get a synchronizer

    getst r0,res[r4]    # allocate a thread
    ldap r11,thread1    # get address for the code for new thread
    init t[r0]:pc,r11   # set pc for new thread
    set t[r0]:r5,r5     # fill thread with thread0 channel

    getst r0,res[r4]    # allocate a thread
    ldap r11,thread2    # get address for the code for new thread
    init t[r0]:pc,r11   # set pc for new thread
    set t[r0]:r5,r5     # fill thread with thread0 channel

    getst r0,res[r4]    # allocate a thread
    ldap r11,thread3    # get address for the code for new thread
    init t[r0]:pc,r11   # set pc for new thread
    set t[r0]:r5,r5     # fill thread with thread0 channel

    msync res[r4]       # start all allocated threads
    bu thread0          # give thread 0, the main thread, a place to go

common_main:

outer:
    mov r2,r3
inner:
    sub r2,r2,1
    bt r2,inner
    out res[r5],r7      # send some data to thread0
    bu outer


thread0:
    ldc r0,0x0
t0loop:
    out res[r8],r0
    in r10,res[r5]      # wait for data
    xor r0,r0,r10
    bu t0loop

thread1:
    ldc r7,0x0010
    ldc r3,31
    bu common_main

thread2:
    ldc r7,0x0100
    ldc r3,32
    bu common_main

thread3:
    ldc r7,0x1000
    ldc r3,33
    bu common_main

