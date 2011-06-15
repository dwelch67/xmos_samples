

.globl _start
_start:
    ldc r1, 100
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

    ldc r1,0x1          # led tied to lsbit of register
hangout:
    out res[r11],r1     # write to gpio out

    ldc r0,0xF
hangin:
    sub r0,r0,1
    bt r0,hangin

    add r1, r1, 1

    bu hangout


# change to xmos tools dir with SetEnv
# source SetEnv
# change to where this code is
# xas blink_asm.s -o blink_asm.o
# xcc blink_asm.o blink_led.xn -o blink_asm.xe -nostartfiles
# xsim --max-cycles 2000 --vcd-tracing "-o blink_asm.vcd -ports -cycles -threads -timers -instructions -functions" blink_asm.xe


