

_start:
    ldc r1, 10
notmain:
    sub r1,r1,1
    bt r1, notmain

    ldc  r11, 0x6
    setc res[r11], 0x8  # setci
    setc res[r11], 0xf  # setci

    # define XS1_PORT_1E 0x10600
    ldc r11,0x1060
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

    # define XS1_PORT_1E 0x10600
    ldc r11,0x1060
    shl r11,r11,4
    ldc r10,1           # thread 0 turns on the gpio

    outct res[r6],1

t0loop:
    chkct res[r5],1
    out res[r11],r10
    ldc r9,0x20
t0wait:
    sub r9,r9,1
    bt r9,t0wait
    outct res[r5],1
    bu t0loop

thread1:
    # define XS1_PORT_1E 0x10600
    ldc r11,0x1060
    shl r11,r11,4
    ldc r10,0           # thread 1 turns off the gpio

t1loop:
    chkct res[r6],1
    out res[r11],r10
    ldc r9,0x20
t1wait:
    sub r9,r9,1
    bt r9,t1wait
    outct res[r6],1
    bu t1loop
