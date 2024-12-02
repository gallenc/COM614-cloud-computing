/*
 * pwm_led.c
 * Description: Pulse width modulated output driving an LED.
 * Author:		MM
 * Date:		04/03/2015
 */

#include <stdio.h>
#include "gb_common.h"

int main(int argc, char **argv)
{
	// set up hardware connections (prompt user)
	printf("Connect GP25 to B6 in OUTPUT configuration.\n");
	printf("Connect jumper for 3.3V.\n");
	
	// hardware set-up routines
	setup_io();
	INP_GPIO(25); OUT_GPIO(25);
	GPIO_CLR0 = 1<<25;
	
	// run a while loop with two sub-loops (on-time and off-time)
	while(1)
	{
		// set output line high
		GPIO_SET0 = 1<<25;
		
		// set output line low
		GPIO_CLR0 = 1<<25;
	}
	
	return 0;
}












