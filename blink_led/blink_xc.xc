

//Normally you would start with the schematic and you might find
//for example that the LED you want to blink is tied to say X0D12.
//You then need the datasheet for the particular xmos processor variant
//in this example lets assume the XS1-L1A-LQ64, in the datasheet for
//that part we see that X0D12 is tied to PORT P1E.

//In an include file in the xmos toolchain dir target/include/ we see that
//#define XS1_PORT_1E 0x10600, in theory we can use the include file by
//name and not necessarily by address.

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

//change dir to base of xmos toolchain dir
//source SetEnv
//xcc blink_xc.xc blink_led.xn -o blink_xc.xe
//xsim --max-cycles 2000 --vcd-tracing "-o blink_xc.vcd -ports -cycles -threads -timers -instructions -functions" blink_xc.xe

//gtkwave blink_xc.vcd
//wont get too much into how to use gtkwave, but using the mouse and
//ctrl-a select all the signals in the lower left window then click
//append.  Various different ways to zoom out until it fits, on the
//version I have up Time->Zoom->Full.
//mark all the stdcore[0] Functions Thread and the INSTRUCTION_MNEMONIC
//right click on the selected and change data format to ascii.
//slide down to XS_PORT_IE and you should see it toggling high and low.

