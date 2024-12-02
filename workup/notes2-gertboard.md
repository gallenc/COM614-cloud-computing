# raspberry pi 


## WiringPi

[WiringPi](https://github.com/WiringPi/WiringPi) is a library which can easily control the output pins of a Raspberry PI GPIO. 

To install wiring pi, you need do download the latest 32 bit package from the github [WiringPi releases](https://github.com/WiringPi/WiringPi/releases) site and install it on your local pi.

You can download the package into your Pi using `wget` which is a command line based browser.

```
wget https://github.com/WiringPi/WiringPi/releases/download/3.10/wiringpi_3.10_armhf.deb
sudo apt-get install ./wiringpi_3.10_armhf.deb 

```
WiringPi provides a command `gpio` which can control the pins from the command line.

```
gpio -h       # provides a simple list of commands
man gpio      # provides a full set of instructions
gpio readall  # lists the state of all of the pins
```
## setting up the GertBoard

to read inputs 

```
gpio -g mode 25 in
gpio -g mode 25 up
```

## pin out details pi

GPIO - General Purpose Input/Output, aka "BCM" or "Broadcom".

https://pinout.xyz/ gpio pin layouts pi

BCM / Broadacom == GPIO pins are the pins on hte broadcom device

Wiring pi - attempt to standardise wiring - WiringPi uses its own pin numbering scheme, this page illustrates how WiringPi numbers your GPIO pins


## pi assembler gpio

see also rp3 bare metal interrupt example https://gist.github.com/petemoore/4a17f701d2ad57025a1f6ab90a66ce33  This is an example to demonstrate how to have a timer execute in EL1 on a raspberry pi 3 in bare metal assembly.

```
# ------------------------------------------------------------------------------
# See "BCM2837 ARM Peripherals" datasheet pages 90-104:
#   https://cs140e.sergio.bz/docs/BCM2837-ARM-Peripherals.pdf
# ------------------------------------------------------------------------------
.set GPFSEL1,        0x0004                       // GPIO Function Select 1
.set GPPUD,          0x0094                       // GPIO Pin Pull-up/down Enable
.set GPPUDCLK0,      0x0098                       // GPIO Pin Pull-up/down Enable Clock 0


...
  adrp    x4, 0x3f200000                          // x4 = GPIO base = 0x3f200000 (rpi3)
  ldr     w2, [x4, GPFSEL1]                       // w2 = [GPFSEL1]
  and     w2, w2, #0xfffc0fff                     // Unset bits 12, 13, 14 (FSEL14 => GPIO Pin 14 is an input).
                                                  // Unset bits 15, 16, 17 (FSEL15 => GPIO Pin 15 is an input).
  orr     w2, w2, #0x00002000                     // Set bit 13 (FSEL14 => GPIO Pin 14 takes alternative function 5).
  orr     w2, w2, #0x00010000                     // Set bit 16 (FSEL15 => GPIO Pin 15 takes alternative function 5).
  str     w2, [x4, GPFSEL1]                       //   [GPFSEL1] = updated value => Enable UART 1.
  str     wzr, [x4, GPPUD]                        //   [GPPUD] = 0x00000000 => GPIO Pull up/down = OFF
  mov     x5, #0x96                               // Wait 150 instruction cycles (as stipulated by datasheet).
1:
  subs    x5, x5, #0x1                            // x0 -= 1
  b.ne    1b                                      // Repeat until x0 == 0.

```
Note 

Labels "xb" and "xf", where "x" is a number are a smart extension to the GNU assembly. It branches to the first found label "x" searching "forward" for "f" or "backward" for "b".

That means that in your first listing using "1b" as a target will search for "1" BEFORE the instruction that uses it. In the second listing "2f" will search for "2" AFTER the instruction that uses it, the "2b" at the end of this listing will then branch to the same "2", because it is BEFORE the instruction.

There may be multiple labels with numbers in your code.

See here - https://sourceware.org/binutils/docs-2.24/as/Symbol-Names.html#Symbol-Names - chapter "Local labels".


see youtube Raspberry Pi 3 - GPIO with ARM assembly 
https://www.youtube.com/watch?v=k_40voY5WgE

https://github.com/elisa2995/RaspberryGPIO_LAB  Computer Architectures - Politecnico di Torino


https://forums.raspberrypi.com/viewtopic.php?t=67457  Getting interrupts from GPIO (in assembler)

```
    ldr     r1, =GPIO_base
    ldr     r0, [r1, #GPIO_GPFSEL3]
    bic     r0, #0x7<<0     // CLEAR bits 0000.0111 << (n * 3)  set GPIO30 and 31 as INPUT
    bic     r0, #0x7<<3
    str     r0, [r1, #GPIO_GPFSEL3]

    mov   r0, #0b10
    str     r0, [r1, #GPIO_GPPUD]               // enable PULL_UP resistors...
    mov   r0, #150
    bl      delay
```
