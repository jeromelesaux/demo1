/* 
 * first demo source
 * open screen, put in memory 
 * switch banks to flip 4 images
 */

#include "FILE.C"

#define HYPTO1NAME "HYPTO1.BIN"
#define HYPTO2NAME "HYPTO2.BIN"
#define HYPTO3NAME "HYPTO3.BIN"
#define HYPTO4NAME "HYPTO4.BIN"

static char readBuffer [ 16336 ];

main() {
	initamsdos();
	openfile(HYPTO1NAME);
	while(1) {}

}

openfile(filename) 
	char *filename;
{
	char *screenPtr;
	screenPtr = 0xC000;
	if ( openread( filename, readBuffer ) == 0 ) {
		return;
	}
	while ( iseof() == 0 ) {
		screenPtr = getbinary();
		screenPtr++;
	}
	closeread();
}


