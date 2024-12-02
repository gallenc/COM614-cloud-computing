//===========================================================================
// gpiomux.asm - Read and write 4-digit common-anode 7-segment displays
// John Schwartzman, Forte Systems, Inc.
// 04/06/2021
// ARM64
//===========================================================================
.include "arm64_include.asm"    // contains constants & macros

//============================== CODE SECTION ===============================
.section .text

.ifdef OPT  //=================== use main from this file ===================

.global main

//===========================================================================
main:
  push2 x29, x30        // push fp & lr

  mov   w0, #SIGHUP       // prepare handleHangup - sig number
  adr   x1, handleHangup    //                      - function adr
  bl    signal          // invoke glibc signal() function

  bl    initialize        // set up gpio and shared memory
  bl    readWrite       // continuously display shared memory
  bl    cleanUp         // restore and unmap gpio

  mov   w0, wzr         // w0 = EXIT_SUCCESS
  bl    exit          // invoke glibc exit() function

  pop2  x29, x30        // pop fp & lr
  ret

//===========================================================================

.else // OPT != __MAIN__  //========= use main from muxmain.cpp ===========

.global initialize, cleanUp, readWrite, setExitFlag

.endif  //===================================================================

//===========================================================================
// Handle the SIGHUP signal: call cleanUp
handleHangup:
  push2 x29, x30        // push fp & lr
  bl    setExitFlag       // tell readWrite to exit
  pop2  x29, x30        // pop fp & lr
  ret

//===========================================================================
setExitFlag:            // tell readWrite to exit
  adr   x0, exitFlag      // write ONE to memory location exitFlag
  mov   w1, #ONE
  strb  w1, [x0]
  ret

//===========================================================================
// Map virtual memory to /dev/gpiomem and set GPIO pins for input or output.
initialize:
  push2 x29, x30        // push fp & lr

  adr   x0, digits
  bl    readSharedMemory
  cmp   x0, #MINUS_ONE      // success?
  beq   fin           //    branch if no

  adr   x0, memdev
  adr   x1, gpiobase
  bl    mapOpen         // map the memory
  cmp   x0, xzr         // success?
  bmi   fin           //    branch if no

  adr   x29, gpiobase     // save gpiobase
  str   x0, [x29]

  adr   x29, gpiobase     // This step is necessary for all GPIO
  ldr   x29, [x29]        // activity. x29 => gpiobase

  adr   x0, switch_0      // GPIO pin 17 used for switch
  bl    gpioDirectionIn

  adr   x0, seg_a       // GPIO pin 20
  bl    gpioDirectionOut

  adr   x0, seg_b       // GPIO pin 21
  bl    gpioDirectionOut

  adr   x0, seg_c       // GPIO pin 19
  bl    gpioDirectionOut

  adr   x0, seg_d       // GPIO pin 13
  bl    gpioDirectionOut

  adr   x0, seg_e       // GPIO pin 06
  bl    gpioDirectionOut

  adr   x0, seg_f       // GPIO pin 16
  bl    gpioDirectionOut

  adr   x0, seg_g       // GPIO pin 12
  bl    gpioDirectionOut

  adr   x0, seg_dp        // GPIO pin 26
  bl    gpioDirectionOut

  adr   x0, digit_0       // GPIO pin 18
  bl    gpioDirectionOut

  adr   x0, digit_1       // GPIO pin 23
  bl    gpioDirectionOut

  adr   x0, digit_2       // GPIO pin 24
  bl    gpioDirectionOut

  adr   x0, digit_3       // GPIO pin 25
  bl    gpioDirectionOut

  adr   x0, pin_22        // GPIO pin 22
  bl    gpioDirectionOut

  mov   x0, xzr         // clear error flag

fin:
  pop2  x29, x30        // pop fp & lr
  ret

//===========================================================================
cleanUp:              // cleanup has no parameters
  push2 x29, x30        // push fp & lr

  adr   x29, gpiobase     // x29 => gpiobase
  ldr   x29, [x29]

  adr   x0, seg_a       // GPIO pin 20
  bl    gpioDirectionIn

  adr   x0, seg_b       // GPIO pin 21
  bl    gpioDirectionIn

  adr   x0, seg_c       // GPIO pin 19
  bl    gpioDirectionIn

  adr   x0, seg_d       // GPIO pin 13
  bl    gpioDirectionIn

  adr   x0, seg_e       // GPIO pin 06
  bl    gpioDirectionIn

  adr   x0, seg_f       // GPIO pin 16
  bl    gpioDirectionIn

  adr   x0, seg_g       // GPIO pin 12
  bl    gpioDirectionIn

  adr   x0, seg_dp        // GPIO pin 26
  bl    gpioDirectionIn

  adr   x0, digit_0       // GPIO pin 18
  bl    gpioDirectionIn

  adr   x0, digit_1       // GPIO pin 23
  bl    gpioDirectionIn

  adr   x0, digit_2       // GPIO pin 24
  bl    gpioDirectionIn

  adr   x0, digit_3       // GPIO pin 25
  bl    gpioDirectionIn

  adr   x0, pin_22        // GPIO pin 22
  bl    gpioDirectionIn

  mov   x0, x29
  bl    mapClose        // unmap gpio

  pop2  x29, x30        // pop fp & lr
  ret

//===========================================================================
readWrite:              // readWrite has no parameters
  push2 x29, x30        // push fp & lr
  push  x22

  adr   x29, gpiobase
  ldr   x29, [x29]        // x29 = gpiobase

    adr   x22, digits       // get this from shared memory
  ldr   x22, [x22]

continue:
    ldrb    w0, [x22, #THREE]   // get lsd -- digit_0
  adr   x1, hex_numbers     // get lookup table hex_numbers patterns
  ldr   w1, [x1, x0, lsl #2]    // point to correct num & get pins to clr

  adr   x0, digit_0       // write digit_0
    bl      writeDigit

    ldrb    w0, [x22, #TWO]         // get digit_1
  adr   x1, hex_numbers     // get lookup table hex_numbers patterns
  ldr   w1, [x1, x0, lsl #2]  // point to correct num & get pins to clr

  adr   x0, digit_1       // write digit_1
    bl      writeDigit

    ldrb    w0, [x22, #ONE]     // get digit_2
  adr   x1, hex_numbers     // get lookup table hex_numbers patterns
  ldr   w1, [x1, x0, lsl #2]  // point to correct num & get pins to clr

  adr   x0, digit_2       // write digit_2
    bl      writeDigit

    ldrb    w0, [x22, #ZERO]    // get digit_3
  adr   x1, hex_numbers     // get lookup table hex_numbers patterns
  ldr   w1, [x1, x0, lsl #2]  // point to correct num & get pins to clr

    adr   x0, digit_3       // write digit_3
    bl      writeDigit


  adr   x0, exitFlag      // read the exit flag byte
  ldrb  w0, [x0]
  cmp   w0, #ONE        // do we need to exit?
  bne   continue        //    branch if no

  pop   x22
  pop2  x29, x30        // pop fp & lr
  ret

//===========================================================================
writeDigit:   // x29 => gpiobase, w0 => active digit, x1 = print pattern
  push2 x29, x30        // push fp & lr
  push  x22

  mov   x22, x0         // x0 => active digit to write

  adr   x8, clrAllSeg
  ldr   w8, [x8]        // w8 = bits we care about
  str   w8, [x29, #gpset0]    // write 1st pattern to gpset0
  str   w1, [x29, #gpclr0]    // write 2nd pattern to gpclr0

  mov   x0, x22         // turn on digit
  mov   x1, #ONE        // one pulse to base of npn transistor
  bl    gpioSetState

    bl      sleep         // display digit for 2.5ms

  mov   x0, x22         // turn off digit
  mov   x1, xzr         // zero pulse to base of npn transistor
  bl    gpioSetState

  pop   x22
  pop2  x29, x30        // pop fp & lr
  ret

//===========================================================================
sleep:
  push2 x29, x30
  ldr   x0, =timespecsec    // sleep for 2.5ms
  ldr   x1, =timespecsec
  bl    nanosleep
  pop2  x29, x30        // pop fp & lr
  ret

//============================= DATA SECTION ================================
.section  .data

exitFlag: .byte 0       // this will be 1 when we should exit
gpiobase: .dword  0       // memory mapped gpio address space
digits:   .dword  0       // 4 digits memory

//====================== READ-ONLY DATA SECTION =============================
.section  .rodata

timespecsec:  .dword  0       // 0
timespecnano: .dword  2500000   // 2.5ms

memdev:     .asciz  "/dev/gpiomem"

// GPIO pin look up table
seg_a:    .word  8    // pin20 - offset to select register
      .word    0    //     - bit offset in select reg
      .word 20    //     - bit offset in set & clr reg
seg_b:    .word    8    // pin21
      .word  3
      .word 21
seg_c:    .word  4    // pin19
      .word 27
      .word 19
seg_d:    .word  4    // pin13
      .word  9
      .word 13
seg_e:    .word  0    // pin06
      .word 18
      .word  6
seg_f:    .word  4    // pin16
      .word 18
      .word 16
seg_g:    .word  4    // pin12
      .word  6
      .word 12
seg_dp:   .word  8    // pin26
      .word   18
      .word 26
switch_0: .word  4    // pin17
      .word   21
      .word 17
digit_0:  .word  4    // pin18 - shared memory
      .word   24
      .word 18
digit_1:  .word    8    // pin23
      .word  9
      .word 23
digit_2:  .word  8    // pin24
      .word 12
      .word 24
digit_3:  .word  8    // pin25
      .word 15
      .word 25
pin_22:   .word  8    // pin22
      .word  6
      .word 22

hex_numbers:
    .word 0x00392040  // 0 - write this to gpclr0 to display 0
    .word   0x00280000  // 1 - write this to gpclr0 to display 1
    .word 0x00303040  // 2 - write this to gpclr0 to display 2
    .word 0x00383000  // 3 - write this to gpclr0 to display 3
    .word 0x00291000  // 4 - write this to gpclr0 to display 4
    .word 0x00193000  // 5 - write this to gpclr0 to display 5
    .word 0x00193949  // 6 - write this to gpclr0 to display 6
    .word 0x00380000  // 7 - write this to gpclr0 to display 7
    .word 0x00393040  // 8 - write this to gpclr0 to display 8
    .word 0x00391000  // 9 - write this to gpclr0 to display 9
    .word 0x00391040  // A - write this to gpclr0 to display A
    .word 0x00093040  // b - write this to gpclr0 to display b
    .word 0x00112040  // C - write this to gpclr0 to display C
    .word 0x00283040  // d - write this to gpclr0 to display d
    .word 0x00113040  // E - write this to gpclr0 to display E
    .word 0x00111040  // F - write this to gpclr0 to display F

clrAllSeg:
    .word 0x04393040  // write this to gpset0 to make leds dark

//============================================================================

