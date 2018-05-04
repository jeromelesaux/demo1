/* 
 * first demo source
 * open screen, put in memory 
 * switch banks to flip 4 images
 */

#include "FILE.C"

#define PLANETE1NAME "PLAN1.BIN"
#define PLANETE2NAME "PLAN2.BIN"
#define PLANETE3NAME "PLAN3.BIN"
#define PLANETE4NAME "PLAN4.BIN"

static char readBuffer [ 16336 ];

main() {
	initamsdos();
	openfile(PLANETE1NAME);
}

openfile(filename) 
	char *filename;
{
	char *screenPtr;
	screenPtr = 0xC000;
	if ( openread( PLANETE1NAME, readBuffer ) == 0 ) {
		return;
	}
	while ( iseof() == 0 ) {
		screenPtr = getbinary();
		screenPtr++;
	}
	closeread();
}


