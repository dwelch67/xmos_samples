
#include <platform.h>
#define FLASH_PERIOD 20
out port bled = XS1_PORT_1E ;
int main ( void ) {
   timer tmr ;
   unsigned isOn = 1;
   unsigned t ;
   tmr :> t ;
   while (1) {
     bled <: isOn ;
     t += FLASH_PERIOD ;
     tmr when timerafter ( t ) :> void ;
     isOn = ! isOn ;
   }
   return 0;
}

//change dir to base of xmos toolchain dir
//source SetEnv
//xcc blink_timer.xc blink_led.xn -o blink_timer.xe
//xsim --max-cycles 2000 --vcd-tracing "-o blink_timer.vcd -ports -cycles -threads -timers -instructions -functions" blink_timer.xe
