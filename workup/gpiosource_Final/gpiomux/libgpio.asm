//===========================================================================
// libgpio.asm
// 04/16/2021
// John Schwartzman, Forte Systems, Inc.
// ARM64
//
// mapOpen maps gpio into the user program's memory space.
// Pointers to the devices are stored in global variables.
// The user program can use those pointers to access the device registers
//
// mapClose unmaps GPIO.
//===========================================================================
.include "arm64_include.asm"  // contains constants & macros

//============================== CODE SECTION ===============================
.section  .text
.global mapOpen, mapClose
.global gpioReadPin, gpioDirectionIn, gpioDirectionOut, gpioSetState
.global createSharedMemory, readSharedMemory

//===========================================================================
// mapOpen() maps GPIO device into memory space and
// stores addresses in gloval variables.
// long mapOpen(char* memdev);
// returns 0 = success, -1 = could not map memory, -2 = could not open file
mapOpen:            // x0 => /dev/gpiomem,  x1 => gpiobase
  push2 x29, x30            // push FP & LR
  mov   x29, x1

  mov   w1, #(O_RDWR + O_SYNC)
  bl    open              // try to open /dev/gpiomem
  cmp   w0, wzr             // check fd
  mov   x5, #OPEN_FAILED        // just in case
  ble   init_exit           // branch if less than or equal 0

  mov   x6, x0              // save fd - 5th arg to mmap

  mov   x0, xzr             // 1st arg to mmap - NO_PREF = 0
  mov   x1, #BLOCK_SIZE         // 2nd arg to mmap - 4KB
  mov   x2, #(PROT_READ | PROT_WRITE) // 3rd arg to mmap
  mov   x3, #MAP_SHARED         // 4th arg to mmap
  mov   x4, x6              // 5th arg to mmap - fd
  mov   x5, xzr             // 6th arg to mmap - offset = 0

  bl    mmap
  mov   x5, #MAP_FAILED         // just in case
  cmp   x0, x5
  beq   closeFile
  mov   x5, x0
  str   x0, [x29]           // save value returned by mmap

closeFile:
  mov   x0, x6              // get fd and close it
  bl    close             // no longer need /gev/gpiomem open
                      // ignore close error - it's not likely
init_exit:
  mov   x0, x5              // get return code (note: it's a long.)
  pop2  x29, x30            // pop fb & lr
  ret

//===========================================================================
// IO_close unmaps gpio       // x29 => gpiobase
// int mapClose(void);  returns 0 for success, -1 for failure
mapClose:
  push2 x29, x30        // push fp & lr

  cmp   xzr, x29        // was it ever mapped?
  beq   closed          //   branch if no

  mov   x0, x29
  mov   x1, #BLOCK_SIZE
  bl    munmap          // unmap it

closed:
  pop2  x29, x30        // pop fp & lr
  ret

//===========================================================================
createSharedMemory:             // x0 = address of memory var
  push2 x29, x30

  mov   x29, x0

  mov   x0, #key_digits         // identifier
  mov   x1, #SHM_SIZE
  mov   x2, #IPC_CREAT | 0666
  bl    shmget              // invoke glibc shmget()
  cmp   w0, wzr             // x0 = shmid
  bmi   csr_end

  mov   x1, xzr
  mov   x2, xzr
  bl    shmat             // invoke glibc shmat()
  cmp   x0, MINUS_ONE         // x0 => shared memory
  beq   csr_end

  str   x0, [x29]           // save shared memory

csr_end:
  pop2  x29, x30            // pop fb & lr
  ret

//===========================================================================
readSharedMemory:             // x0 = address of memory var
  push2 x29, x30            // push FP & LR

  mov   x29, x0

  mov   x0, #key_digits         // identifier
  mov   x1, #SHM_SIZE
  mov   x2, #0666           // octal value
  bl    shmget              // invoke glibc shmget()
  cmp   w0, wzr             // x0 == shmid?
  bmi   rsm_end             //    branch if no

  mov   x1, xzr
  mov   x2, xzr
  bl    shmat             // invoke glibc shmat()
  cmp   x0, MINUS_ONE         // x0 => shared memory
  beq   rsm_end

  str   x0, [x29]           // save shared memory

rsm_end:
  pop2  x29, x30            // pop fb & lr
  ret

///============================================================================
// Returns level of GPIO Pin (0 or 1) in w0
// ALso sets Z = 1 if level is low
// This is a convenience for the user of gpioReadPin.
gpioReadPin:
  ldr   w2, [x29, #gplev0]    // w2 = [gplev0], x0 => seg lookup tbl
  mov   x3, x0          // base of pin info table
  ldr   w3, [x0, #EIGHT]    // load pin number from pin info table
  mov   w0, #ONE        // 1 bit to shift into position
  lsl   w0, w0, w3        // do the shift
  ands  w0, w2, w0        // w0 returns 0 or 1, Z flag set if w0 == 0
  ret

//===========================================================================
// Set pin to input
gpioDirectionIn:          // x29 => gpiobase, x0 => seg lookup tbl
  ldr   w2, [x0]        // w2 = offset to gpfseln - 1st val in tbl
  ldr   w1, [x29, x2]     // w1 = contents of gpfseln
  ldr   w3, [x0, #FOUR]     // w3 = offect in gpfseln - 2nd val in tbl
  mov   w0, #CLEAR_MASK     // w0 = mask to clear 3 bits (111)
  lsl   w0, w0, w3        // shift CLEAR_MASK into position
  bic   w1, w1, w0        // clr the 3 bits of gpfseln - 000 = input
  str   w1, [x29, x2]     // write it to gpfseln
  ret

//===========================================================================
// Set pin to output
gpioDirectionOut:         // x29 => gpiobase, x0 => seg lookup tbl
  ldr   w2, [x0]        // w2 = offset to gpfseln - 1st val in tbl
  ldr   w1, [x29, x2]     // w1 = contents of gpfseln
  ldr   w3, [x0, #FOUR]     // w3 = offset in gpfseln - 2nd val in tbl
  mov   w0, #CLEAR_MASK     // mask to clear 3 bits (111)
  lsl   w0, w0, w3        // shift CLEAR_MASK into position
  bic   w1, w1, w0        // clear the 3 bits of gpfseln
  mov   w0, #ONE        // 1 bit to shift into position
  lsl   w0, w0, w3        // shift by amount from table (0, 3, 6, ...)
  orr   w1, w1, w0        // set the bit - 001 = output
  str   w1, [x29, x2]     // write it to gpfseln
  ret

//===========================================================================
// set a single pin to 0 or 1
gpioSetState:         // x29 => gpiobase, x0 => seg tbl, x1 = 0 or 1
  mov   x6, #gpclr0
  mov   x7, #gpset0
  cmp   x1, xzr         // x1 == 0?
  csel  x6, x6, x7, eq      // x6 = (x1 == 0?) : #clr ? #set
  ldr   w3, [x0, #EIGHT]    // get shift amount (3rd entry in seg tbl)
  mov   x0, #ONE
  lsl   w0, w0, w3        // shift the 1 into position
  str   w0, [x29, x6]     // write to clrregoffset or setregoffset
  ret

//===========================================================================
