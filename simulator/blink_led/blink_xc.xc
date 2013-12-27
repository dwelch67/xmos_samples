
//Normally you would start with the schematic and you might find
//for example that the LED you want to blink is tied to say X0D12.
//You then need the datasheet for the particular xmos processor variant
//in this example lets assume the XS1-L1A-LQ64, in the datasheet for
//that part we see that X0D12 is tied to PORT P1E.

//In an include file in the xmos toolchain dir target/include/ we see
//#define XS1_PORT_1E 0x10600.
//The .xn configuration file allows you to basically rename the port
// number to some other name, maybe MY_RED_LED.  This example shows that
// we dont have to do that, you can basically use this code with any
//.xn config file and it will still wiggle the same I/O port.

//Because this example is going to be viewed in the simulator output
//and not actually drive an led on a board, we want to blink quite
//fast so that we dont have to run a really long simulation.  So this
//simple example changes the I/O output state every time through the
//loop.

#include <platform.h>

out port bled = XS1_PORT_1E ;
unsigned bit_state;
int main ()
{
    bit_state = 0b1;
    while (1)
    {
        bled <: bit_state;
        bit_state^=0b1;
    }
    return 0;
}

//If you dump traces when you simulate you can see the I/O port
//res[rx(0x10600] changing state with an out instruction or
//if you look at the .vcd file you will see it changing high
//and low like a square wave.
