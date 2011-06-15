
#define XS1_SETC_COND_NONE 0x1
#define XS1_SETC_COND_FULL 0x1
#define XS1_SETC_COND_AFTER 0x9


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

    getr r5,0x1         # get a timer resource handle in r5
    setc res[r5],0x1    # set to UNCOND (COND_NONE)
    in r7,res[r5]       # get current count, does not wait in this mode
    setc res[r5],0x9    # switch to AFTER mode (COND_AFTER)

    ldc r1,0x1          # led tied to lsbit of register
    ldc r3,0x20         # how many timer counts to wait
hangout:
    out res[r11],r1     # write to gpio out
    add r7,r7,r3        # compute next timeout value
    setd res[r5],r7     # set the timeout value in timer
    in r4,res[r5]       # wait for timeout value
    add r1,r1,0x1       # compute next gpio value
    bu hangout


# change to xmos tools dir with SetEnv
# source SetEnv
# change to where this code is
# xas blink_asm_timer.s -o blink_asm_timer.o
# xcc blink_asm_timer.o blink_led.xn -o blink_asm_timer.xe -nostartfiles
# xsim --max-cycles 2000 --vcd-tracing "-o blink_asm_timer.vcd -ports -cycles -threads -timers -instructions -functions" blink_asm_timer.xe


