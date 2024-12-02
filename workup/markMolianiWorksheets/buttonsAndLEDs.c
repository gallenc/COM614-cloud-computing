// Author:
// Date: 
// Description: C code application to specification given for task 14
//  The program will read button input 1,2, and 3 from the Gertboard 
//  and change the LED display accordingly (left, exit, right).
//
//  Button 1: Left
//  Button 2: Not connected yet
//  Button 3: Shift LEDs right
//  LEDs 9-12: As display output
//
// + modify code
// + compile and link code:
//     gcc -c buttonsAndLeds.c
//     gcc -o myApp buttonsAndLeds.o gb_common.o
// + execute code :
//     sudo ./myApp

#include <stdio.h>
// Include Gertboard functions header file
#include "gb_common.h"

// Set up the GPIO ports as needed
void setup_gpio()
{
  // By default, the input lines are low. 
  // However, a button press is detected as a LOW signal.
  // This means the RPi needs to pull up the input lines by default
  // to HIGH (to detect a button press as LOW).

  // For this test we are using 25, 24 and 23 as button input lines
  INP_GPIO(25);
  INP_GPIO(24);
  INP_GPIO(23);

  // enable pull-up on GPIO 25,24,23: set pull to 2 (code for pull high)
  GPIO_PULL = 2;
  short_wait();
  // setting bits 25,24,23 below means that the GPIO_PULL is applied
  // to GPIO 25,24,23
  GPIO_PULLCLK0 =  0x3800000;   // 0011 1000 0000 0000 0000 0000 0000
  short_wait();
  GPIO_PULL = 0;
  GPIO_PULLCLK0 = 0;
} // setup_gpio


void main( void )
{
	//display hello message
	printf( "Hello World!\n\n" );

	//a) inform the user how to wire up the gertboard ports

	printf ("\n")
	printf ("These are the connections for the LEDs test:\n");
	printf ("First, we connect GPIO ports to Buffered I/O ports.\n");
	printf ("\n");

    // buttons on B1, B2, B3
    printf ("GP25 in J2 --- B1 in J3\n");
  	printf ("GP24 in J2 --- B2 in J3\n");
  	printf ("GP23 in J2 --- B3 in J3\n");
	printf ("\n");

	//output LEDS on B9-B12
	printf ("GP22 in J2 --- B9 in J3\n");
	printf ("GP21 in J2 --- B10 in J3\n");
	printf ("GP18 in J2 --- B11 in J3\n");
	printf ("GP17 in J2 --- B12 in J3\n");
	printf ("\n");

	//Jumpers to install:
	printf ("Jumpers in location B9-OUT, B10-OUT, B11-OUT, B12-OUT .\n");
	printf ("Optional to indicate button press with LEDs: \n");
	printf ("Jumpers in location B1-OUT, B2-OUT, B3-OUT. \n\n");

	printf ("When ready hit enter.\n");
	(void) getchar();

	//b) Setup/initialise RPi and Gertboard ports for I/O

	// Map the I/O sections
	setup_io();		// pre-defined in gb_common
	setup_gpio();	// as defined above

	//c) Light up second LED ( = LED 10)

	//d) Use infinite do-while loop

		//read button states for B1, B2, B3

		//If B1 is on, shift LED display to the left

		//If B2 is on, shift LED display to the right

	//tidy up IO ports


}



