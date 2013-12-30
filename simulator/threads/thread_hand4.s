
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

    #ldc r0,1

    clre
    eeu res[r3]
    waiteu

tmr_vec:
    ldc r10,0xABCD
    out res[r8],r10
    freer res[r3]
    ldc r0,0
    clre
    waiteu
