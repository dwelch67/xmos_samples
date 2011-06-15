

_start:
    ldc r1, 100
notmain:
    sub r1,r1,1
    bt r1, notmain

    ldc  r11, 0x6
    setc res[r11], 0x8  # setci
    setc res[r11], 0xf  # setci

    getr r4,0x3         # get a synchronizer
    getst r0,res[r4]    # allocate a thread
    ldap r11,btest      # get address for the code for new thread
    init t[r0]:pc,r11   # set pc for new thread
    msync res[r4]       # start all allocated threads
    bu atest            # give thread 0, the main thread, a place to go

atest:
    ldc r1,0x20
aaaa:
    sub r1,r1,0x1
    bt r1,aaaa
    bu atest

btest:
    ldc r1,0x10
bbbb:
    sub r1,r1,0x1
    bt r1,bbbb
    bu btest

