//***************************************************************************
// muxmain.cpp - optional C++ main() for gpiomux.asm
// John Schwartzman, Forte Systems, Inc.
// 03/07/2021
// ARM64
//***************************************************************************

#include <iostream>   // for std::cout
#include <stdlib.h>   // for EXIT_SUCCESS
#include <signal.h>   // for signal()
#include "gpiomux.h"  // declarations for exports in gpiomux.asm

using namespace std;

//***************************************************************************
void handleHangup(int sig)
{
  cout << "muxmain: received signal "
     << sig << " - setting flag for exit\n";
  setExitFlag();  // signal readWrite() to exit
}

//***************************************************************************
extern int main(int argc, char** argv)
{
  // associate SIGHUP signal with handleHangup function
  signal(SIGHUP, handleHangup);

  cout << "muxmain: initializing\n";
  initialize(); // set up gpio and shared memory

  cout << "muxmain: running\n";
    readWrite();  // read each digit and write to appropriate 7-segment

  cout << "muxmain: cleaning up\n";
  cleanUp();    // restore gpio to default state and unmap gpio

  cout << "muxmain: exiting\n";
  exit(EXIT_SUCCESS);
}

//***************************************************************************
