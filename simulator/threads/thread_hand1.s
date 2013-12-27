
# This example hands data back and forth.

# unlike the thread_hand0 example this simply passes data rather than
# tokens.  Like tokens a core/thread can wait for data.

# core 0 sets up thread 1 and the data channels

# core 0 sends 0x88 to core 1 and waits for data
# core 1 counts down from that value, 0x88
# core 1 sends 0x44 to core0 and waits for data
# core 0 gets 0x44 and counts down from 0x44
# then this repeats core 0 sends 0x88 and waits
# ...

# as well as the Core#_waiting signals in the vcd waveforms you can
# also look at INSTRUCTION_THREAD_ID to see which thread is
# running.


_start:
    ldc r1, 10
notmain:
    sub r1,r1,1
    bt r1, notmain

    ldc  r11, 0x6
    setc res[r11], 0x8  # setci
    setc res[r11], 0xf  # setci

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

t0loop:

    ldc r10,0x88
    out res[r6],r10     # send some data to thread1

    in r10,res[r6]      # wait for data

t0delay:
    sub r10,r10,1
    bt r10,t0delay

    bu t0loop

thread1:

t1loop:
    in r10,res[r5]      # wait for data
t1delay:
    sub r10,r10,1
    bt r10,t1delay

    ldc r10,0x44
    out res[r5],r10     # send some data to thread0
    bu t1loop

