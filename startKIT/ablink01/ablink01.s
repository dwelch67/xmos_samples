

# This is an assembly language example of how to blink the startKIT
# led(s)

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
    setc res[r11], 0x8  # setci
    setc res[r11], 0xf  # setci

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

# the I/O pin we are wiggling is bit 0x80000, from other examples
# for this board we know that setting the port bit turns the led
# off and clearing on.
    ldc r1,0x61F8
    shl r1,r1,4
    ldc r2,0xA1F8
    shl r2,r2,4

hangout:
# write to the port, this causes the I/O port output to change
    out res[r11],r1
# delay for a bit so we can better see the I/O change
    ldc r0,0x0001
    shl r0,r0,24
hangin0:
    sub r0,r0,1
    bt r0,hangin0
# write to the port again
    out res[r11],r2
# delay for a bit
    ldc r0,0x0001
    shl r0,r0,24
hangin1:
    sub r0,r0,1
    bt r0,hangin1
# repeat
    bu hangout
