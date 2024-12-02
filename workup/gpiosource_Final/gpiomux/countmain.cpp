//***************************************************************************
// * countmain.cpp - optional C++ main()for gpiocount.asm
// * John Schwartzman, Forte Systems, Inc.
// * 03/07/2021
//***************************************************************************

#include <iostream>   // for std::cout
#include <stdlib.h>   // for system()
#include <unistd.h>   // for sleep()
#include <signal.h>   // for signall() and SIGINT
#include "gpiocount.h"  // declarations for exports in gpiocount.asm

using namespace std;

//***************************************************************************
void handleSigint(int sig)
{
  cout << "countmain: received signal "
     << sig << " - setting flag for exit\n";
  setExitFlag();  // signal countUp() and countDown() to exit
}

//***************************************************************************
extern int main(int argc, char** argv)
{
  signal(SIGINT, handleSigint);

  cout << "countmain: initializing\n";
  initialize(); // get shared memory and map gpio

  cout << "countmain: starting gpiomux\n";
  system("./gpiomux &");  // start gpiomux in the background

  cout << "countmain: starting countUp(2)\n";
  countUp(2);

  cout << "countmain: countUp(2) has been interrupted - "
     << "starting countUp(8)\n";
  countUp(8);

  cout << "countmain: countUp(8) has been interrupted - "
     << "starting countUp(10)\n";
  countUp(10);

  cout << "countmain: countUp(10) has been interrupted - "
     << "starting countUp(16)\n";
  countUp(16);

  cout << "countmain: countUp(16) has been interrupted - "
     << "starting countDown(16)\n";
  countDown(16);

  cout << "countmain: countDown(16) has been interrupted - "
     << "starting countDown(10)\n";
  countDown(10);

  cout << "countmain: countDown(10) has been interrupted - "
     << "starting countDown(8)\n";
  countDown(8);

  cout << "countmain: countDown(8) has been interrupted - "
     << "starting countDown(2)\n";
  countDown(2);

  cout << "countmain: countDown(2) has been interrupted\n";

  cout << "countmain: cleaning up\n";
  cleanUp();              // restore and unmap gpio

  cout << "countmain: sending SIGHUP to gpiomux\n";
  system("killall -HUP gpiomux");   // tell gpiomux to hang up

  sleep(1);             // wait until gpiomux exits

  cout << "countmain: exiting\n";
  exit(0);
}

//***************************************************************************
