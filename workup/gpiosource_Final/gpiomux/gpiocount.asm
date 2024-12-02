//===========================================================================
// gpiocount.asm - Count up or down in different number systems
// John Schwartzman, Forte Systems, Inc.
// 03/11/2021
// ARM64
//===========================================================================
.include "arm64_include.asm"    // contains constants & macros

//============================== CODE SECTION ===============================
.section .text

.ifdef OPT  //================ use main from this file ======================

.global main

//===========================================================================
main:
  push2 x29, x30        // push fp & lr

  mov   w0, #SIGINT       // prepare handleSigint - sig number
  adr   x1, handleSigint    //            - function adr
  bl    signal          // invoke glibc signal() function

  bl    initialize        // get gpio and shared memory

  adr   x0, startmux      // start gpiomux
  bl    system          // invoke glibc system function

  mov   w0, #TWO        // countUp(2)
  bl    countUp

  mov   w0, #EIGHT        // countUp(8)
  bl    countUp

  mov   w0, #TEN        // countUp(10)
  bl    countUp

  mov   w0, #SIXTEEN      // countUp(16)
  bl    countUp

  mov   w0, #SIXTEEN      // countDown(16)
  bl    countDown

  mov   w0, #TEN        // countDown(10)
  bl    countDown

  mov   w0, #EIGHT        // countDown(8)
  bl    countDown

  mov   w0, #TWO        //  countDown(2)
  bl    countDown

  bl    cleanUp         // restore and unmap gpio

  adr   x0, hangupmux     // tell gpiomux to exit
  bl    system

  mov   w0, wzr         // w0 = EXIT_SUCCESS
  bl    exit          // invoke glibc exit() function

  pop2  x29, x30        // pop fp & lr
  ret

//===========================================================================

.else // OPT != __MAIN__ //====== use main from countmain.cpp =============

.global initialize, cleanUp, setExitFlag
.global countUp, countDown

.endif  //===================================================================

//===========================================================================
setExitFlag:            // tell readWrite to exit
  adr   x0, exitFlag      // write ONE to memory location exitFlag
  mov   w1, #ONE
  strb  w1, [x0]
  ret

//===========================================================================
handleSigint:             // handle Ctrl-C signal
  push2 x29, x30          // push fp & lr
  bl    setExitFlag
  pop2  x29, x30
  ret

//===========================================================================
// Map virtual memory to /dev/gpiomem
initialize:   // returns 0 = success, -1 = could not create shared memory

  push2 x29, x30        // push fp & lr

  adr   x0, digits        // create shared memory
  bl    createSharedMemory
  cmp   x0, #MINUS_ONE      // successful?
  beq   fin           //    branch if no

  adr   x0, memdev        // get gpiobase
  adr   x1, gpiobase
  bl    mapOpen         // map the memory
  cmp   x0, xzr         // success?
  bmi   fin           //    branch if no

  adr   x29, gpiobase     // save gpiobase
  str   x0, [x29]

  mov   w0, wzr         // w0 = EXIT_SUCCESS

fin:
  pop2  x29, x30        // pop fp & lr
  ret

///===========================================================================
// Set all GPIO pins to input and unmap the virtual memory.
cleanUp:              // returns 0 = success, -1 = failure
  push2 x29, x30        // push fp & lr

  adr   x29, gpiobase     // x29 => gpiobase
  ldr   x29, [x29]

  mov   x0, x29
  bl    mapClose        // unmap the memory

  pop2  x29, x30        // pop fp & lr
  ret

//===========================================================================
// Count up from 0 through nBase - 1 over and over until interrupted.
countUp:              // void countUp(base);
  push2 x29, x30        // push fp & lr
  push  x22

  adr   x29, gpiobase
  ldr   x29, [x29]        // x29 => gpiobase

  adr   x22, digits       // x22 => digits
  ldr   x22, [x22]

  mov   w11, w0         // w11 is the number system base
                  // e.g., 2, 8, 10, 16
  adr   x0, pin_22        // make pin_22 go high - cancel interrupt
  mov   x1, #ONE
  bl    gpioSetState

countUpTop:
  strb  wzr, [x22, #ZERO]   // zero digits
  strb  wzr, [x22, #ONE]
  strb  wzr, [x22, #TWO]
  strb  wzr, [x22, #THREE]

countUpContinue:
  adr   x0, exitFlag      // read the exit flag byte
  ldrb  w0, [x0]
  cmp   w0, #ONE        // do we need to exit?
  beq   endCountUp        //    branch if yes

  adr   x0, pin_22        // is the LKM signaling me to exit?
  bl    gpioReadPin       // check for kernel interrupt (Z == 1)
  beq   endCountUp        // branch if finished

  bl    sleep         // wait 1 second

  ldrb  w0, [x22, #ZERO]    // get digit-0 (LSB)
  inc   w0            // inc digit-0
  cmp   w0, w11         // max for digit0?
  beq   countUpContinue1    //    branch if yes
  strb  w0, [x22, #ZERO]
  b     countUpContinue

countUpContinue1:
  strb  wzr, [x22, #ZERO]   // zero digit0
  ldrb  w0, [x22, #ONE]     // get digit1
  inc   w0            // inc digit1
  cmp   w0, w11         // max for digit1?
  beq   countUpContinue2    //    branch if yes
  strb  w0, [x22, #ONE]     // write digit1
  b     countUpContinue

countUpContinue2:
  strb  wzr, [x22, #ONE]    // zero digit1
  ldrb  w0, [x22, #TWO]     // get digit2
  inc   w0            // inc digit2
  cmp   w0, w11         // max for digit2?
  beq   countUpContinue3    //    branch if yes
  strb  w0, [x22, #TWO]     // write digit2
  b     countUpContinue

countUpContinue3:
  strb  wzr, [x22, #TWO]    // zero digit2
  ldrb  w0, [x22, #THREE]   // get digit3
  inc   w0            // inc digit3
  cmp   w0, w11         // max for digit3?
  beq   countUpTop        //    reset everything if yes
  strb  w0, [x22, #THREE]   // write digit3
  b     countUpContinue

endCountUp:
  pop   x22
  pop2  x29, x30        // pop fp & lr
  ret

//===========================================================================
// Count down from nBase - 1 through 0 over and over until interrupted.
countDown:              // void countDown(base);
  push2 x29, x30        // push fp & lr
  push  x22

  adr   x29, gpiobase
  ldr   x29, [x29]        // x29 = gpiobase

  mov   w11, w0         // w11 is the number system base
                  // e.g., 2, 8, 10, 16
  adr   x0, pin_22        // make pin_22 go high - cancel interrupt
  mov   x1, #ONE
  bl    gpioSetState

countDownTop:
  adr   x22, digits       // set all digits to base - 1
  ldr   x22, [x22]
  sub   w10, w11, #ONE      // x10 = base - 1
  strb  w10, [x22, #ZERO]
  strb  w10, [x22, #ONE]
  strb  w10, [x22, #TWO]
  strb  w10, [x22, #THREE]

countDownContinue:
  adr   x0, exitFlag      // read the exit flag byte
  ldrb  w0, [x0]
  cmp   w0, #ONE        // do we need to exit?
  beq   endCountUp        //    branch if yes

  adr   x0, pin_22        // is the LKM signaling me to exit
  bl    gpioReadPin       // check kernel interrupt notification (Z == 1)
  beq   endCountDown      // branch if finished

  bl    sleep         // wait 1 second

  ldrb  w0, [x22, #ZERO]    // get digit0
  dec   w0            // dec digit0
  bmi   countDownContinue1
  strb  w0, [x22, #ZERO]
  b     countDownContinue

countDownContinue1:
  strb  w10, [x22, #ZERO]   // digit0 = base - 1
  ldrb  w0, [x22, #ONE]     // dec digit1
  dec   w0
  bmi   countDownContinue2
  strb  w0, [x22, #ONE]
  b     countDownContinue

countDownContinue2:
  strb  w10, [x22, #ONE]    // digit1 = base - 1
  ldrb  w0, [x22, #TWO]
  dec   w0
  bmi   countDownContinue3
  strb  w0, [x22, #TWO]     // write digit2
  b     countDownContinue

countDownContinue3:
  strb  w10, [x22, #TWO]    // digit2 = base - 1
  ldrb  w0, [x22, #THREE]   // get digit3
  dec   w0            // dec digit3
  bmi   countDownTop      // reset everything; digit3 was 0
  strb  w0, [x22, #THREE]   // write digit3
  b     countDownContinue

endCountDown:
  pop   x22
  pop2  x29, x30        // pop fp & lr
  ret

//===========================================================================
sleep:
  push2 x29, x30        // push fp & lr
  ldr   x0, =timespecsec    // sleep for one second
  ldr   x1, =timespecsec
  bl    nanosleep
  pop2  x29, x30        // pop fp & lr
  ret

//============================= DATA SECTION ================================
.section  .data

exitFlag: .byte 0       // this will be 1 when we should exit
gpiobase: .dword  0
digits:   .dword  0       // 4-digit multiplexed display

//====================== READ-ONLY DATA SECTION =============================
.section  .rodata

timespecsec:  .dword  1     // 1 second
timespecnano: .dword  0     // 0 nanoseconds

memdev:     .asciz  "/dev/gpiomem"
startmux:   .asciz  "./gpiomux &"       // start in backgroung
hangupmux:    .asciz  "killall -HUP gpiomux"    // hangup message

// GPIO pin look up table
pin_22:   .word  8        // pin22 - LKM will notify us of
      .word  6        //       interrupts by bringing
      .word 22        //       this pin low

//============================================================================
