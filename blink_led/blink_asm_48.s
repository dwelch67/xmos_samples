

# This demonstrates that when narrower port (4 bit) that shares pins with
# a wider port (8 bit) and both ports are enabled the smaller port
# overrides the wider port for the shared pins.

# at the time of this writing the simulation shows the mixing of these
# output bits in the PORT_8B trace.

# see blink_asm_48.s for information about how the timer is used
# in these examples

# see blink_asm.s for general information on using the gpio lines as
# outputs.

#define XS1_PORT_8B 0x80100
#define XS1_PORT_4D 0x40300

.globl _start
_start:
    ldc r1, 100
notmain:
    sub r1,r1,1
    bt r1, notmain

    ldc  r11, 0x6
    setc res[r11], 0x8  # setci
    setc res[r11], 0xf  # setci

    ldc r8,0x4030
    shl r8,r8,4
    ldc r9,0x8010
    shl r9,r9,4

    # define XS1_SETC_INUSE_ON 0x8
    setc res[r8],0x8
    setc res[r9],0x8
    # define XS1_RES_TYPE_CLKBLK 0x6  look at GETR instruction for a list
    ldc r1,0x6
    setclk res[r8],r1
    setclk res[r9],r1

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


# change to xmos tools dir with SetEnv
# source SetEnv
# change to where this code is
# xas blink_asm_48.s -o blink_asm_48.o
# xcc blink_asm_48.o blink_led.xn -o blink_asm_48.xe -nostartfiles
# xsim --max-cycles 2000 --vcd-tracing "-o blink_asm_48.vcd -ports -cycles -threads -timers -instructions -functions" blink_asm_48.xe


