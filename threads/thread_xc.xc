
#include <platform.h>

on stdcore[0] : out port led0 = XS1_PORT_1E ;
on stdcore[0] : out port led1 = XS1_PORT_1F ;

void a_port ( void )
{
    timer tmr;
    unsigned isOn = 1;
    unsigned t;

    tmr :> t;
    while(1)
    {
        led0 <: isOn;
        t += 20;
        tmr when timerafter(t) :> void;
        isOn = !isOn;
    }
}

void b_port ( void )
{
    timer tmr;
    unsigned isOn = 1;
    unsigned t;

    tmr :> t;
    while(1)
    {
        led1 <: isOn;
        t += 18;
        tmr when timerafter(t) :> void;
        isOn = !isOn;
    }
}

int main ( void )
{
    par
    {
        on stdcore [0] : a_port();
        on stdcore [0] : b_port();
    }
}

//change dir to base of xmos toolchain dir
//source SetEnv
//xcc thread_xc.xc blink_led.xn -o thread_xc.xe
//2000 cycles wont get it, need more to see the threads start
//xsim --max-cycles 4000 --vcd-tracing "-o thread_xc.vcd -ports -cycles -threads -timers -instructions -functions" thread_xc.xe
