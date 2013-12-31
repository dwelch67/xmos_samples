
_start:

    ldc r0,0
    ldc r1,0
    ldc r2,0
    ldc r3,0
    ldc r4,0
    ldc r5,0
    ldc r6,0
    ldc r7,0
    ldc r8,0
    ldc r9,0
    ldc r10,0
    ldc r11,0

    ldc r11,0x00B
    get r10,ps[r11]     # get ram base
    ldc r11,0x10B
    set ps[r11],r10     # set vector base (to match ram base)

    #ldc r11,0xb
    #get r10,ps[r11]
    #ldap r11,RamSize
    #ldw r11,r11[0x0]
    #add r0,r10,r11

    #set sp,r0
    #extsp 0x21
    #ldap r11,cp
    #set cp,r11
    #ldap r11,dp
    #set dp,r11

    ldc  r11, 0x6       # the I/O ports need a clock
    setc res[r11], 0x8  # setci
    setc res[r11], 0xf  # setci

    #ldap r11,kep_handler
    #set kep,r11

    # define XS1_PORT_32A 0x200000
    ldc r8,0x2000
    shl r8,r8,8
    setc res[r8],0x8    # turn the port on
    ldc r1,0x6          # give it a clock
    setclk res[r8],r1

    clre

    getr r4,0x3         # get a synchronizer

    getst r0,res[r4]    # allocate a thread
    ldap r11,thread1    # get address for the code for new thread
    init t[r0]:pc,r11   # set pc for new thread

    getr r5,2           # allocate a channel end for thread 0
    getr r6,2           # allocate a channel end for thread 1
    setd res[r5],r6     # point one end at the other
    setd res[r6],r5     # point one end at the other
    set t[r0]:r6,r6     # set a thread register with one end
    ldc r10,0x40
    set t[r0]:r4,r10
    ldc r10,0x1234
    set t[r0]:r10,r10

    ldap r11,t0t1hand
    setv res[r5],r11
    eeu res[r5]         # wake up on this resources event


    getst r0,res[r4]    # allocate a thread
    ldap r11,thread1    # get address for the code for new thread
    init t[r0]:pc,r11   # set pc for new thread

    getr r6,2           # allocate a channel end
    getr r7,2           # allocate a channel end
    setd res[r6],r7     # point one end at the other
    setd res[r7],r6     # point one end at the other
    set t[r0]:r6,r7     # set a thread register with one end
    ldc r10,0x50
    set t[r0]:r4,r10
    ldc r10,0xABCD
    set t[r0]:r10,r10

    ldap r11,t0t2hand
    setv res[r6],r11
    eeu res[r6]         # wake up on this resources event

    msync res[r4]       # start all allocated threads

    waiteu              # wait for an event to happen, then go to the handler

wait_for_event:
    clre                # no events pending

    ldap r11,t0t1hand
    setv res[r5],r11
    eeu res[r5]         # wake up on this resources event

    ldap r11,t0t2hand
    setv res[r6],r11
    eeu res[r6]         # wake up on this resources event

    waiteu              # wait for an event to happen, then go to the handler

t0t1hand:
    in r10,res[r5]
    out res[r8],r10
    outct res[r5],1     # send control token
    bu wait_for_event

t0t2hand:
    in r10,res[r6]
    out res[r8],r10
    outct res[r6],1     # send control token
    bu wait_for_event


thread1:
    getr r2,0x1         # get a timer resource handle
    setc res[r2],0x1    # set to UNCOND (COND_NONE)
    in r3,res[r2]       # get current count, does not wait in this mode
    setc res[r2],0x9    # switch to AFTER mode (COND_AFTER)
t1loop:
    add r3,r3,r4        # compute next timeout value
    setd res[r2],r3     # set the timeout value
    in r7,res[r2]       # wait for timeout value

    out res[r6],r10     # send something to thread 0
    chkct res[r6],1     # wait for control token
    bu t1loop





# Any instance of _DoSyscall seems to make the simulator happy when
# using waiteu.  I still dont know why waiteu matters and not kcall
# or dcall
#_DoSyscall: #.word 0x77C0A6D0
#_DoSyscall:
#    mkmsk r0,0x20
#    retsp 0
_DoSyscall:
    bu _DoSyscall
