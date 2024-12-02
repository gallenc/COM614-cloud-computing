//===========================================================================
// arm64_include.asm
// John Schwartzman, Forte Systems, Inc.
// 04/16/2021
// ARM64
// contains constants and macros for ARM64 assembly language
// include this file with the directive: .include "arm64_include.asm"

//===========================================================================
// Raspberry Pi GPIO Memory Map
// OFFSET from gpiobase REGISTER NAME serves gpio pins  lookup tbl fields
// 0x00         gpfsel0     00 - 09       1, 2
// 0x04         gpfsel1     10 - 19       1, 2
// 0x08         gpfsel2     20 - 29       1, 2
// 0x0C         gpfsel3     30 - 39       1, 2
// 0x10         gpfsel4     40 - 49       1, 2
// 0x14         gpfsel5     50 - 59       1, 2
// 0x1C         gpset0      all         3
// 0x28         gpclr0      all         3
// 0x34         gplev0      all         3

//============================ CONSTANT DEFINITIONS =========================
.equ  ZERO,      0
.equ  ONE,       1
.equ  TWO,       2
.equ  THREE,       3
.equ  FOUR,      4
.equ  EIGHT,       8
.equ  TEN,      10
.equ  SIXTEEN,    16
.equ  MINUS_ONE,    -1
.equ  NULL,      0
.equ  CLEAR_MASK,  0b111    // mask to clear 3 bits when used with bic
.equ  OPEN_FAILED,  -2
.equ  MAP_FAILED,   -1    // this is a void ptr to -1 (0xffffffffffffffff)
.equ  MAP_SHARED,    1
.equ  PROT_READ,     1
.equ  PROT_WRITE,    2
.equ  O_RDWR,   00000002
.equ  O_SYNC,   00010000
.equ  BLOCK_SIZE, (4*1024)
.equ  gpset0,     0x1c  // offset of gpset0 (distance from gpiobase)
.equ  gpclr0,     0x28  // offset of gpclr0 (distance from gpiobase)
.equ  gplev0,       0x34  // offset of gplev0 (distance from gpiobase)
.equ  key_digits,   5826  // identifier for shmget
.equ  IPC_CREAT,     01000
.equ  SHM_SIZE,        4  // shared memory size 4KB
.equ  SIGHUP,        1  // hangup
.equ  SIGINT,        2  // interrupt
//================================== MACROS =================================
.macro  push reg        // push a register onto the stack
    str \reg, [sp, #-16]! // stack must always be 16 byte aligned
.endm

.macro  pop reg         // pop a gegister from the stack
    ldr \reg, [sp], #16   // stack must always be 16 byte aligned
.endm

.macro  push2 reg1, reg2    // push 2 registers onto the stack
    stp \reg1, \reg2, [sp, #-16]!
.endm

.macro  pop2 reg1, reg2     // pop 2 registers from the stack
    ldp \reg1, \reg2, [sp], #16
.endm

.macro  inc reg         // increment register
    add \reg, \reg, #ONE
.endm

.macro  dec reg         // decrement register
    subs \reg, \reg, #ONE // set Z=1 if decrement yields 0
.endm

//===========================================================================
