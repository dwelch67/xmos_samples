
# This example has one thread acting as a uart transmitter, whatever
# it sees on a channel input it serially shifts out.

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
    ldc r1,0x1
    # wants to be high when idle
    out res[r11],r1


    getr r5,2           # allocate a channel end for thread 1
    setd res[r5],r5     # set the thread 1 channel end

    getr r4,0x3         # get a synchronizer

    getst r0,res[r4]    # allocate a thread
    ldap r11,thread1    # get address for the code for new thread
    init t[r0]:pc,r11   # set pc for new thread
    set t[r0]:r5,r5     # tell thread 1 what channel

    msync res[r4]       # start all allocated threads
    bu thread0          # give thread 0, the main thread, a place to go

thread0:

    ldc r10,0x88
    out res[r5],r10     # send some data to thread1
    #chkct res[r5],1     # wait for it to finish
    ldc r10,0x77
    out res[r5],r10     # send some data to thread1
    #chkct res[r5],1     # wait for it to finish
    ldc r10,0x99
    out res[r5],r10     # send some data to thread1
    #chkct res[r5],1     # wait for it to finish

t0hang:
    bu t0hang

thread1:
    # define XS1_PORT_1E 0x10600
    ldc r11,0x1060
    shl r11,r11,4

    ldc r9,0x30 # this determines baud rate, adjust for system speed

    getr r7,0x1         # get a timer resource handle in r5


t1wait:
    in r10,res[r5]      # this appears to wait for data

    shl r10,r10,2       # start bit
    # 1xxxxxxxx01
    # 1xx xxxx xx01
    ldc r0,0x401        # stop bit
    or r10,r10,r0

    ldc r2,10
    setc res[r7],0x1    # set to UNCOND (COND_NONE)
    in r3,res[r7]       # get current count, does not wait in this mode
    setc res[r7],0x9    # switch to AFTER mode (COND_AFTER)
    out res[r11],r10
utxloop:
    shr r10,r10,1
    add r3,r3,r9
    in r4,res[r7]       # delay
    out res[r11],r10
    sub r2,r2,1
    bt r2,utxloop


    #outct res[r5],1     # signal done
    bu t1wait



