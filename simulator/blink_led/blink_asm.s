

# This is an example that is similar to the blink_xc program in
# assembly language

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

# See the blink_xc example about the resource address for a port.
# define XS1_PORT_1E 0x10600
    ldc r11,0x1060
    shl r11,r11,4
# need to turn the port on
# define XS1_SETC_INUSE_ON 0x8
    setc res[r11],0x8
# need to connect the port to a clock for it to work
# define XS1_RES_TYPE_CLKBLK 0x6
    ldc r1,0x6
    setclk res[r11],r1
# the I/O pin we are wiggling is tied to the lsbit of the port
    ldc r1,0x1
hangout:
# write to the port, this causes the I/O port output to change
    out res[r11],r1
# delay for a bit so we can better see the I/O change
    ldc r0,0xF
hangin:
    sub r0,r0,1
    bt r0,hangin
# change the lsbit
    add r1, r1, 1
# repeat
    bu hangout
