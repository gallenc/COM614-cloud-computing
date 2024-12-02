//***************************************************************************
// gpiocount.h - Count up and down in various number systems
// John Schwartzman, Forte Systems, Inc.
// 03/07/2021
// ARM64 - Declarations for exported functions in gpiocount.asm
//***************************************************************************
#ifndef _gpiocount_h_
#define _gpiocount_h_

#define __MAP_FAILED__    -1  // initialize return value
#define __OPEN_FAILED__   -2  // initialize return value

#ifdef __cplusplus  // C++ declarations
    extern"C"
    {
        long initialize();
        void countUp(long nBase = 16);      // nBase = 2, 8, 10, 16
        void countDown(long nBase = 16);  // nBase = 2, 8, 10, 16
        int  cleanUp();
        void setExitFlag();
    }
#else               // C declarations
    long initialize();
    void countUp(long nBase); // nBase = 2, 8, 10, 16
    void countDown(long nBase); // nBase = 2, 8, 10, 16
    int  cleanUp();
    void setExitFlag();
#endif


#endif  //*******************************************************************
