
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

    ldc  r11, 0x6       # the I/O ports need a clock
    setc res[r11], 0x8  # setci
    setc res[r11], 0xf  # setci

    clre

    getr r1,0x3         # get a synchronizer

    #-------------
    getst r0,res[r1]    # allocate a thread
    ldap r11,slave    # get address for the code for new thread
    init t[r0]:pc,r11   # set pc for new thread

    getr r2,2           # allocate a channel end for thread 0
    getr r3,2           # allocate a channel end for thread 1
    setd res[r2],r3     # point one end at the other
    setd res[r3],r2     # point one end at the other
    set t[r0]:r6,r3     # set a thread register with one end
    ldc r10,0x04
    shl r10,r10,24
    set t[r0]:r4,r10
    ldc r10,0x0080
    set t[r0]:r10,r10
    ldap r11,t0hand
    setv res[r2],r11
    mov r11,r2
    setev res[r2],r11
    eeu res[r2]         # wake up on this resources event
    #-------------


    #-------------
    getst r0,res[r1]    # allocate a thread
    ldap r11,slave    # get address for the code for new thread
    init t[r0]:pc,r11   # set pc for new thread

    getr r2,2           # allocate a channel end for thread 0
    getr r3,2           # allocate a channel end for thread 1
    setd res[r2],r3     # point one end at the other
    setd res[r3],r2     # point one end at the other
    set t[r0]:r6,r3     # set a thread register with one end
    ldc r10,0x03
    shl r10,r10,24
    set t[r0]:r4,r10
    ldc r10,0x0100
    set t[r0]:r10,r10
    ldap r11,t0hand
    setv res[r2],r11
    mov r11,r2
    setev res[r2],r11
    eeu res[r2]         # wake up on this resources event
    #-------------

#0xE1F80;


    #-------------
    getst r0,res[r1]    # allocate a thread
    ldap r11,slave    # get address for the code for new thread
    init t[r0]:pc,r11   # set pc for new thread

    getr r2,2           # allocate a channel end for thread 0
    getr r3,2           # allocate a channel end for thread 1
    setd res[r2],r3     # point one end at the other
    setd res[r3],r2     # point one end at the other
    set t[r0]:r6,r3     # set a thread register with one end
    ldc r10,0x02
    shl r10,r10,24
    set t[r0]:r4,r10
    ldc r10,0x0200
    set t[r0]:r10,r10
    ldap r11,t0hand
    setv res[r2],r11
    mov r11,r2
    setev res[r2],r11
    eeu res[r2]         # wake up on this resources event
    #-------------


    #-------------
    getst r0,res[r1]    # allocate a thread
    ldap r11,slave    # get address for the code for new thread
    init t[r0]:pc,r11   # set pc for new thread

    getr r2,2           # allocate a channel end for thread 0
    getr r3,2           # allocate a channel end for thread 1
    setd res[r2],r3     # point one end at the other
    setd res[r3],r2     # point one end at the other
    set t[r0]:r6,r3     # set a thread register with one end
    ldc r10,0x01
    shl r10,r10,24
    set t[r0]:r4,r10
    ldc r10,0x0400
    set t[r0]:r10,r10
    ldap r11,t0hand
    setv res[r2],r11
    mov r11,r2
    setev res[r2],r11
    eeu res[r2]         # wake up on this resources event
    #-------------

    msync res[r1]       # start all allocated threads

    # define XS1_PORT_32A 0x200000
    ldc r8,0x2000
    shl r8,r8,8
    setc res[r8],0x8    # turn the port on
    ldc r1,0x6          # give it a clock
    setclk res[r8],r1
    ldc r2,0
    out res[r8],r2

    waiteu              # wait for an event to happen, then go to the handler

t0hand:
    get r11,ed
    mov r5,r11
    in r10,res[r5]
    xor r2,r2,r10
    out res[r8],r2
    outct res[r5],1     # send control token
    waiteu


slave:
    getr r2,0x1         # get a timer resource handle
    setc res[r2],0x1    # set to UNCOND (COND_NONE)
    in r3,res[r2]       # get current count, does not wait in this mode
    setc res[r2],0x9    # switch to AFTER mode (COND_AFTER)
sloop:
    add r3,r3,r4        # compute next timeout value
    setd res[r2],r3     # set the timeout value
    in r7,res[r2]       # wait for timeout value
    out res[r6],r10     # send something to thread 0
    chkct res[r6],1     # wait for control token
    bu sloop


# Any instance of _DoSyscall seems to make the simulator happy when
# using waiteu.  I still dont know why waiteu matters and not kcall
# or dcall
#_DoSyscall: #.word 0x77C0A6D0
#_DoSyscall:
#    mkmsk r0,0x20
#    retsp 0
#_DoSyscall:
#    bu _DoSyscall

