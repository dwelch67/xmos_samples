
# This example hands tokens back and forth.

# Thread 0 sets up the threads and channels for communications.

# The main application thread0 passes the token to thread 1,
# thread 1 then wakes up and counts down from 0x44,
# thread 1 then passes the token back
# thread 0 wakes up and counts down from 0x88
# then it repeats

# In the waveforms we can see Core0 and Core1 waiting, since
# thread/core1 counts half as long as core0 the core0 wait
# is half as long as the core1 wait time.

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

    outct res[r6],1     # send control token
    chkct res[r6],1     # wait for control token

    ldc r10,0x88
t0delay:
    sub r10,r10,1
    bt r10,t0delay

    bu t0loop

thread1:

t1loop:
    chkct res[r5],1     # wait for control token
    ldc r10,0x44
t1delay:
    sub r10,r10,1
    bt r10,t1delay
    outct res[r5],1     # send control token
    bu t1loop

