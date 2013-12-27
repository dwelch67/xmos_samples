
# This example demonstrates that data sent to one channel using an out
# shows up on that channel on another thread using an in.  And the in
# appears to pause waiting for new data.

_start:
    ldc r1, 10
notmain:
    sub r1,r1,1
    bt r1, notmain

    ldc  r11, 0x6
    setc res[r11], 0x8  # setci
    setc res[r11], 0xf  # setci

    # define XS1_PORT_8B 0x80100
    ldc r11,0x8010
    shl r11,r11,4
    # define XS1_SETC_INUSE_ON 0x8
    setc res[r11],0x8
    # define XS1_RES_TYPE_CLKBLK 0x6  look at GETR instruction for a list
    ldc r1,0x6
    setclk res[r11],r1


    getr r4,0x3         # get a synchronizer
    getst r0,res[r4]    # allocate a thread
    ldap r11,thread1    # get address for the code for new thread
    init t[r0]:pc,r11   # set pc for new thread

    getr r5,2           # allocate a channel end for thread 0
    getr r6,2           # allocate a channel end for thread 1
    setd res[r5],r6     # set the thread 0 channel to talk to thread 1
    setd res[r6],r5     # set the thread 1 channel to talk to thread 0
    set t[r0]:r5,r5     # fill thread 1 registers with the two channel
    set t[r0]:r6,r6     #   end handles

    msync res[r4]       # start all allocated threads
    bu thread0          # give thread 0, the main thread, a place to go

thread0:
    # burn a few instructions to let thread1 get ahead
    ldc r0,0
    ldc r1,0
    ldc r1,0
    ldc r1,0
    ldc r1,0
    ldc r1,0

    outct res[r6],1     # thread1 waiting for this
    ldc r10,0x88
    out res[r6],r10     # send some data to thread1

    ldc r10,0x30        # burn some time
t00:
    sub r10,r10,1
    bt r10,t00

    ldc r10,0x99        # send more data to thread1
    out res[r6],r10

    ldc r10,0x10        # burn some time
t01:
    sub r10,r10,1
    bt r10,t01

    ldc r10,0x77        # send third item to thread1
    out res[r6],r10

t0hang:
    bu t0hang

thread1:
    # define XS1_PORT_8B 0x80100
    ldc r11,0x8010
    shl r11,r11,4

    chkct res[r5],1     # wait for control token
t1wait:
    in r10,res[r5]      # this appears to wait for data
    out res[r11],r10    # once we get some output it on the gpio
    bu t1wait           # go back and wait for more


