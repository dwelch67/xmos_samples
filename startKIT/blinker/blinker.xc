
#include <platform.h>

interface myint
{
    void fx(unsigned x);
};

port leds = XS1_PORT_32A;

void thread0
(
    interface myint server i1,
    interface myint server i2,
    interface myint server i3,
    interface myint server i4,
    interface myint server i5,
    interface myint server i6
)
{
    unsigned led_state;
    led_state = 0xE1F80;
    leds <: led_state;
    while(1)
    {
        select
        {
            case i1.fx(unsigned int x):
            {
                led_state^=x;
                leds <: led_state;
                break;
            }
            case i2.fx(unsigned int x):
            {
                led_state^=x;
                leds <: led_state;
                break;
            }
            case i3.fx(unsigned int x):
            {
                led_state^=x;
                leds <: led_state;
                break;
            }
            case i4.fx(unsigned int x):
            {
                led_state^=x;
                leds <: led_state;
                break;
            }
            case i5.fx(unsigned int x):
            {
                led_state^=x;
                leds <: led_state;
                break;
            }
            case i6.fx(unsigned int x):
            {
                led_state^=x;
                leds <: led_state;
                break;
            }
        }
    }
}
void thread1 ( interface myint client mint )
{
    timer tmr;
    unsigned t;

    tmr :> t;
    while(1)
    {
        t += 0x01000000;
        tmr when timerafter(t) :> void;
        mint.fx(0x80000);
    }
}
void thread2 ( interface myint client mint )
{
    timer tmr;
    unsigned t;

    tmr :> t;
    while(1)
    {
        t += 0x01010000;
        tmr when timerafter(t) :> void;
        mint.fx(0x40000);
    }
}
void thread3 ( interface myint client mint )
{
    timer tmr;
    unsigned t;

    tmr :> t;
    while(1)
    {
        t += 0x01020000;
        tmr when timerafter(t) :> void;
        mint.fx(0x20000);
    }
}
void thread4 ( interface myint client mint )
{
    timer tmr;
    unsigned t;

    tmr :> t;
    while(1)
    {
        t += 0x01030000;
        tmr when timerafter(t) :> void;
        mint.fx(0x01000);
    }
}
void thread5 ( interface myint client mint )
{
    timer tmr;
    unsigned t;

    tmr :> t;
    while(1)
    {
        t += 0x01040000;
        tmr when timerafter(t) :> void;
        mint.fx(0x00800);
    }
}
void thread6 ( interface myint client mint )
{
    timer tmr;
    unsigned t;

    tmr :> t;
    while(1)
    {
        t += 0x01050000;
        tmr when timerafter(t) :> void;
        mint.fx(0x00400);
    }
}


int main ( void )
{
    interface myint i1;
    interface myint i2;
    interface myint i3;
    interface myint i4;
    interface myint i5;
    interface myint i6;
    par
    {
        thread0(i1,i2,i3,i4,i5,i6);
        thread1(i1);
        thread2(i2);
        thread3(i3);
        thread4(i4);
        thread5(i5);
        thread6(i6);
    }
    return(0);
}
