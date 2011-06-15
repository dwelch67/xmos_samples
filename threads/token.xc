#include <platform.h>

on stdcore[0] : out  port  cled0  = XS1_PORT_1C ;
on stdcore[0] : out  port  cled1  = XS1_PORT_1D ;
on stdcore[0] : out  port  cled2  = XS1_PORT_1E ;
on stdcore[0] : out  port  cled3  = XS1_PORT_1F ;


void master_led ( chanend left , chanend right )
{
    right <: 1;
    while (1)
    {
        int token ;

        left :> token ;   /* input token from left neighbour */
        cled0 <: 1;
        cled0 <: 0;
        right <: token ; /* output token to right neighbour */
    }
}


void next_led ( chanend left , chanend right )
{
    while (1)
    {
        int token ;

        left :> token ;   /* input token from left neighbour */
        cled1 <: 1;
        cled1 <: 0;
        right <: token ; /* output token to right neighbour */
    }
}
int main ( void )
{
chan c0 , c1;
    par
    {
        on stdcore [0]:      master_led ( c0 , c1);
        on stdcore [0]:      next_led ( c1 , c0);
    }
    return 0;
}
