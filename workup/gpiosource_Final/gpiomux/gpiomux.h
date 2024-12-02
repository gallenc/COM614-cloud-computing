//***************************************************************************
// gpiomux.h - Display count up and down on a 7-segment common anode display
// John Schwartzman, Forte Systems, Inc.
// 03/04/2021
// ARM64 - Declarations for exported functions in gpiomux.asm
//***************************************************************************
#ifndef _gpiomux_h_
#define _gpiomux_h_

#ifdef __cplusplus  // C++ declarations
    extern"C"
    {
        long initialize();
        int  cleanUp();
        void readWrite();
        void setExitFlag();
    }
#else               // C declarations
    long initialize();
    int  cleanUp()
    void readWrite();
    void setExitFlag();
#endif

#endif  //*******************************************************************
