
# This example shows how to use a timer to delay/wait a particular
# amount of time.

# This example is derived from blink_asm.s and blink_timer.xc which
# are both derived from blink_xc.xc.  So you may need to refer to those
# examples for basic information.

# Reading the manuals, we know that when in unconditional mode we can
# read the timer with an in instruction and immediately get the timer count
# but in AFTER mode the in instruction blocks until the defined timer count
# has occurred.  For this example we only need to read the timer count
# one time, and then just keep adding to that number to have the code
# execution controlled by the timer.

#define XS1_SETC_COND_NONE 0x1
#define XS1_SETC_COND_FULL 0x1
#define XS1_SETC_COND_AFTER 0x9

.globl _start
_start:

# see blink_asm.s, will need a clock

    ldc  r11, 0x6
    setc res[r11], 0x8
    setc res[r11], 0xf

# Setup the I/O port
# define XS1_PORT_1E 0x10600
    ldc r11,0x1060
    shl r11,r11,4
# define XS1_SETC_INUSE_ON 0x8
    setc res[r11],0x8
# define XS1_RES_TYPE_CLKBLK 0x6
    ldc r1,0x6
    setclk res[r11],r1

# This part is new for this example.  We need to allocate a timer resource
    getr r5,0x1         # get a timer resource handle in r5
# set to unconditional mode so we can read the timer count
    setc res[r5],0x1    # set to UNCOND (COND_NONE)
# read the timer count
    in r7,res[r5]       # get current count, does not wait in this mode
# we want it in after mode for the main loop
    setc res[r5],0x9    # switch to AFTER mode (COND_AFTER)

    ldc r1,0x1          # led tied to lsbit of register
    ldc r3,0x20         # how many timer counts to wait
hangout:
    out res[r11],r1     # write to gpio out
    add r7,r7,r3        # compute next timeout value
    setd res[r5],r7     # set the timeout value
    in r4,res[r5]       # wait for timeout value
    add r1,r1,0x1       # compute next gpio value
    bu hangout

# simulate and look for the above specified port (PORT_1E) to see timed
# state changes.  By changing r3 you can see the time between state
# changes vary accordingly.

