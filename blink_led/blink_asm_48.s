

# This demonstrates that when narrower port (4 bit) that shares pins with
# a wider port (8 bit) and both ports are enabled the smaller port
# overrides the wider port for the shared pins.  This is described in
# the documentation.  You do not need to enable or mess with the larger
# ports at all if what you want is within a smaller sized port.  This
# just shows what happens *if* you choose to have overlapping ports
# enabled and in use.

# This example is derived from blink_asm_timer.s which is derived from
# other blink led examples, refer to those examples for more information
# about using a timer and general use of the I/O ports.


# define XS1_PORT_8B 0x80100
# define XS1_PORT_4D 0x40300
# define XS1_SETC_INUSE_ON 0x8
# define XS1_RES_TYPE_CLKBLK 0x6
# define XS1_SETC_COND_NONE 0x1
# define XS1_SETC_COND_AFTER 0x9


.globl _start
_start:

    ldc  r11, 0x6
    setc res[r11], 0x8  # setci
    setc res[r11], 0xf  # setci

# setup both I/O ports as normal.
    ldc r8,0x4030
    shl r8,r8,4
    ldc r9,0x8010
    shl r9,r9,4

    setc res[r8],0x8
    setc res[r9],0x8
    ldc r1,0x6
    setclk res[r8],r1
    setclk res[r9],r1

# setup the timer
    getr r5,0x1
    setc res[r5],0x1
    in r7,res[r5]
    setc res[r5],0x9

    ldc r1,0x0
    ldc r2,0x0
    ldc r6,0xF
    ldc r3,0x10
hangout:
    out res[r8],r2
    out res[r9],r1
    add r7,r7,r3
    setd res[r5],r7
    in r4,res[r5]
    add r1,r1,0x1
    xor r2,r2,r6
    bu hangout

# at the time of this writing the simulation shows the mixing of these
# output bits in the PORT_8B trace.
