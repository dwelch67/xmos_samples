
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


setup_resources:
    getr r3,1           # define XS1_RES_TYPE_TIMER 0x1

    ldap r11,tmr_vec
    setv res[r3],r11

    ldc r10,256
    setd res[r3],r10
    setc res[r3],0x9    # define XS1_SETC_COND_AFTER 0x9

    setc res[r3],0x2    # define XS1_SETC_IE_MODE_EVENT 0x2

    clre
    eeu res[r3]         # wake up on this resources event
    waiteu              # wait for an event to happen, then go to the handler

tmr_vec:
    ldc r10,0xABCD
    out res[r8],r10
    freer res[r3]       # free the resource that got us here (get rid if the timer, so no more timer event pending)
    clre                # no events pending
    waiteu              # no events registered so this waits forever or until the max-cycles hits on the sim

#    .align 0x40
#kep_handler:
#    clre
#    waiteu

#RamSize: .word 0x00010000
#cp: .word 0x01010101
#dp: .word 0x00000000

# Any instance of _DoSyscall seems to make the simulator happy when
# using waiteu.  I still dont know why waiteu matters and not kcall
# or dcall
#_DoSyscall: #.word 0x77C0A6D0
#_DoSyscall:
#    mkmsk r0,0x20
#    retsp 0
_DoSyscall:
    bu _DoSyscall
