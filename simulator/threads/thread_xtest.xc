
#include <platform.h>

interface my_interface
{
    void fx(unsigned x);
};

unsigned dummy ( unsigned );

void a_port ( interface my_interface client c )
{
    unsigned t;
    unsigned z;

    while(1)
    {
        for(t=0;t<7;t++) dummy(t);
        c.fx(z);
        z+=1;
    }
}

void b_port ( interface my_interface server c, interface my_interface server d )
{
    unsigned z;
    z=0;
    while(1)
    {
        select
        {
            case c.fx(unsigned int x):
            {
                z+=x;
                break;
            }
            case d.fx(unsigned int x):
            {
                z+=x;
                break;
            }
        }
    }
}

void c_port ( interface my_interface client c )
{
    unsigned t;
    unsigned z;

    while(1)
    {
        for(t=0;t<7;t++) dummy(t);
        c.fx(z);
        z+=2;
    }
}

int main ( void )
{
    interface my_interface c;
    interface my_interface d;
    par
    {
        a_port(c);
        b_port(c,d);
        c_port(d);
    }
    return(0);
}

