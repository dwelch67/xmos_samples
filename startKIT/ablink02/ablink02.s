
# This example shows how to use a timer to delay/wait a particular
# amount of time.

# Reading the manuals, we know that when in unconditional mode we can
# read the timer with an in instruction and immediately get the timer count
# but in AFTER mode the in instruction blocks until the defined timer count
# has occurred.  For this example we only need to read the timer count
# one time, and then just keep adding to that number to have the code
# execution controlled by the timer.

# define XS1_SETC_COND_NONE 0x1
# define XS1_SETC_COND_FULL 0x1
# define XS1_SETC_COND_AFTER 0x9

.globl _start
_start:

# We need to associate a clock with the I/O pin.  Looking at the
# GETR instruction, resource 0x6 is already allocated so you dont
# need to use the getr instruction.  but we do need to start it.

# Looking at the setci instruction you will see these control bits
# defined
# define XS1_SETC_INUSE_ON 0x8
# define XS1_SETC_RUN_STARTR 0xF

    ldc  r11, 0x6
    setc res[r11], 0x8
    setc res[r11], 0xf

# From xc examples we see the resource name for the port
# which gives this address
# define XS1_PORT_32A 0x200000
    ldc r11,0x2000
    shl r11,r11,8
# need to turn the port on
# define XS1_SETC_INUSE_ON 0x8
    setc res[r11],0x8  # setci
# need to connect the port to a clock for it to work
# define XS1_RES_TYPE_CLKBLK 0x6
    ldc r1,0x6
    setclk res[r11],r1

# now the port is ready to use

# This part is new for this example.  We need to allocate a timer resource
    getr r5,0x1         # get a timer resource handle in r5
# set to unconditional mode so we can read the timer count
    setc res[r5],0x1    # set to UNCOND (COND_NONE)
# read the timer count
    in r7,res[r5]       # get current count, does not wait in this mode
# we want it in after mode for the main loop
    setc res[r5],0x9    # switch to AFTER mode (COND_AFTER)

# the timer is ready to use.


# the I/O pin we are wiggling is bit 0x80000, from other examples
# for this board we know that setting the port bit turns the led
# off and clearing on.
    ldc r1,0x61F8
    shl r1,r1,4
    ldc r2,0xA1F8
    shl r2,r2,4
# how many timer ticks to wait between gpio changes
    ldc r3,0x01
    shl r3,r3,24

hangout:
    out res[r11],r1     # write to gpio out
    add r7,r7,r3        # compute next timeout value
    setd res[r5],r7     # set the timeout value
    in r4,res[r5]       # wait for timeout value
    out res[r11],r2     # write to gpio out
    add r7,r7,r3        # compute next timeout value
    setd res[r5],r7     # set the timeout value
    in r4,res[r5]       # wait for timeout value
    bu hangout

