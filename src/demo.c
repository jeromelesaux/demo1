/* 
 * first demo source
 * open screen, put in memory 
 * switch banks to flip 4 images
 */

#include "FILE.C"
#include "PRINT.C"
//#include "MEMORY.C"

#define HYPTO1NAME "HYPTO1.SCR"
#define HYPTO2NAME "HYPTO2.SCR"
#define HYPTO3NAME "HYPTO3.SCR"
#define HYPTO4NAME "HYPTO4.SCR"

static char readBuffer [ 2048 ];
static char screenBuffer [ 16384 ];
main() {
	initamsdos();
	openfile(HYPTO1NAME);
        //printstrln("file loaded.");
        while (1) {}
}

openfile(filename) 
	char *filename;
{
        int screen;
        screen = 0xc000;
	if ( openread( filename, readBuffer ) == 0 ) {
		return;
	}
        getchar( screenBuffer );
        closeread();
        memcpy( screenBuffer , 0xc000 , 0x4000 );
}


