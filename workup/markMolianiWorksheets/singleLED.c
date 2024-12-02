/*
 * Description: Program to light up a single LED.
 * Author:		M.Molinari
 * Date:		03/12/2014
 *
 * Remember:
 *  Compile: 	gcc -c singleLED.c
 *  Link:		gcc -o myApp singleLED.o gb_common.o
 *  Execute:	sudo ./myApp 
 */

#include <stdio.h>
#include "gb_common.h"

int main(int argc, char **argv)
{
	// write out instructions
	printf("These are the connections for the LEDs test:\n");
	printf("\n");
	printf("Connect a wire from GP25 in J2 -to- B1 in J3\n");
	printf("\n");
	printf("Connect a jumper on B1-out. \n");
	printf("\n");
	printf("When ready hit enter.\n");
	(void) getchar();

	// setup I/O lines
	// 1. mapping IO on hardware
	setup_io();
	
	// 2. set line 25 as output line
	INP_GPIO(25);  
	OUT_GPIO(25);
	  
	// light up LED 
	
	// first turn off output line 25 - GPIO_CLR0 selects which output pins
	// will be set up 0
	GPIO_CLR0 = (1<<25);
	printf("The LED should be off. Press enter to switch it on.\n");
	getchar();
	
	// now send a high output on line 25 - GPIO_SET0 selects which 
	// output pins will be set up 1
	GPIO_SET0 = (1<<25);
	printf("The LED should be on. Press enter to finish the program.\n");
	
	// wait...
	getchar();
		
	// reset I/O lines
	// 1. switch off LED
	GPIO_CLR0 = (1<<25);
	
	// 2. restore I/O hardware line configuration
	restore_io();
	
	return 0;
}
