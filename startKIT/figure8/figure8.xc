#include <xs1.h>
#include <timer.h>

// the patterns for each bit are:
//
//   0x80000 0x40000 0x20000
//   0x01000 0x00800 0x00400
//   0x00200 0x00100 0x00080
//
// As the leds go to 3V3, 0x00000 drives all 9 leds on, and 0xE1F80 drives
// all nine leds off.

unsigned int pattern[12]=
{
    0x61F80,
    0xA1F80,
    0xC1F80,

    0xE1B80,
    0xE1780,
    0xE0F80,

    0xE1D80,
    0xE1E80,
    0xE1F00,

    0xE1B80,
    0xE1780,
    0xE0F80,
};

port p32 = XS1_PORT_32A;
int main(void)
{
    int delay = 50;
    int ra = 0;
    while(1)
    {
        delay_milliseconds(delay);
        delay += 1;
        p32 <: pattern[ra];
        if (++ra == 12) ra = 0;
    }
    return 0;
}
