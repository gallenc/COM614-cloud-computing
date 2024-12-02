# Random notes

# General

Dr quantum visits flatland

https://www.youtube.com/watch?v=lXtyxRd1glM  Two Ronnies - Phantom Raspberry Blower - TERROR STRIKES as raspberries fly 

log2ram https://pimylifeup.com/raspberry-pi-log2ram/


submission 10th JAN AE1

### binary hex subnets
cisco binary game 
https://learningnetwork.cisco.com/s/binary-game
https://learningcontent.cisco.com/games/binary/index.html

hex game https://studio.code.org/projects/applab/q5Mw0Zhs58a_Chr-zn75thpwnjMTw6n2hh_2aN1hwSE  Enter the hexadecimal value in the green box. If you see a hexadecimal number on the right, click the bits to make the binary number match.

ip subnet calculator
https://www.calculator.net/ip-subnet-calculator.html?cclass=any&csubnet=30&cip=192.168.1.1&ctype=ipv4&x=Calculate

### github wikis markdown

github docs - https://docs.github.com/en/communities/documenting-your-project-with-wikis/about-wikis

github markdown cheatsheet https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet
Every repository on GitHub comes equipped with a section for hosting documentation, called a wiki. You can use your repository's wiki to share long-form content about your project, such as how to use it, how you designed it, or its core principles. A README file quickly tells what your project can do, while you can use a wiki to provide additional documentation. For more information, see "About READMEs."

### versioning forked project
https://stackoverflow.com/questions/10415550/what-version-label-to-use-for-a-forked-maven-project

# logic gates and 2s complement

2s compliment https://www.cs.cornell.edu/~tomf/notes/cps104/twoscomp.html   Thomas Finley, April 2000  explanation of 2s compliment

nuts and bolts - small logic gates the bulding blocks of digital circuits part 1  https://www.nutsvolts.com/magazine/article/small-logic-gates-spawn-big-dreams-part-1
nuts and bolts - small logic gates the bulding blocks of digital circuits part 2  https://www.nutsvolts.com/magazine/article/small-logic-gates-spawn-big-dreams-part-2


### Logic simulators
https://www.reddit.com/r/computerscience/comments/uhappo/best_logic_gate_simulation_digital_logic_circuit/

https://github.com/hneemann/Digital   Digital is an easy-to-use digital logic designer and circuit simulator designed for educational purposes. in java 

logigator https://logigator.com/en/community/project/8a738598-3e90-4be8-bd02-50e892f4c488  16-Bit General Purpose CPU.A somewhat better documentation can be found here: https://docs.google.com/spreadsheets/d/1MG44B5RzTul4EMDJowlx4hgNE3XYFRoyR7EFi6A0o3M/edit?usp=sharing

https://logigator.com/
https://www.youtube.com/watch?v=tX7HT_0MZRo  Logigator tutorial - The Editor 

tried logism - didnt work 
https://github.com/logisim-evolution/logisim-evolution

http://www.cburch.com/logisim/docs/2.6.0/en/guide/prop/shortcome.html

https://electronics.stackexchange.com/questions/648983/jk-flip-flop-in-logisim 
Logisim does not model gate delays. Logisim is not appropriate for this kind of simulation which requires gate delays to provide the expected results. For some circuits you may get what you expected, out of luck, due to the order the software evaluate the logic level changes.

demo jk flipflop https://www.falstad.com/circuit/e-jkff.html
4 bit counter https://www.falstad.com/circuit/e-counter.html 

binary full adder https://www.falstad.com/circuit/e-fulladd.html

[Basic AND OR XOR and NOT gates simulation](https://simulator.io/board/jBA0DN5HQz/3)

[Full Adder](https://simulator.io/board/CZ0EsxYPgm/1)

[Half Adder](https://simulator.io/board/A0MeGe4pvm/1)


[4 bit counter using half adders](https://simulator.io/board/JIxRlrtGhm/1)

[4 bit register](https://simulator.io/board/ueB4QsoQGV/1)

[simple 4 bit cpu](https://simulator.io/board/AWZpw7Fy3I/2)

### Program in cpu

|Address      | Value (binary) | Value (hex)  | op code    | description |
|:------------|:-------------- |:------------ |:-----------|:------------|
|0000 (0x00)  | 0010           | 0x02         | MOV 0x01   | loads 1 to A |
|0001 (0x01)  | 0001           | 0x01         |            | operand (value of MOV) |
|0010 (0x02)  | 0011           | 0x03         | SWP        | swaps register A and B |
|0011 (0x03)  | 0100           | 0x04         | ADD        | adds B to A, saves in A|
|0100 (0x04)  | 0001           | 0x01         | OUT        | writes A to display |
|0101 (0x05)  | 1010           | 0x0A         | JMP 0x03   | jumps to address 0x03 0011|
|0110 (0x06)  | 0011           | 0x03         |            | operand (value of JMP) |
|0011 (0x07)  | 0000           | 0x00         |            | No Operation |

https://datasheets.chipdb.org/Intel/MCS-4/4004_schematic.pdf

history https://www.intel.com/content/www/us/en/history/museum-story-of-intel-4004.html

### Logigator

To help you understand how simple logic gates are put together to make complex machines

https://logigator.com/

[Logigator tutorial - The Editor ](https://www.youtube.com/watch?v=tX7HT_0MZRo) 

Look at the following examples

[Logigator Examples](https://logigator.com/en/examples)

Look at the following very complex example of a CPU (Note this is not complete but it does illustrate how a CPU is put together)

[logigator 16-Bit General Purpose CPU](https://logigator.com/en/community/project/8a738598-3e90-4be8-bd02-50e892f4c488)

[somewhat better documentation can be found here:](https://docs.google.com/spreadsheets/d/1MG44B5RzTul4EMDJowlx4hgNE3XYFRoyR7EFi6A0o3M/edit?usp=sharing)

# GPU vs Von Neumann

description of RISC VS CISC 
https://cs.stanford.edu/people/eroberts/courses/soco/projects/risc/risccisc/

vonnumann architecture
https://en.m.wikipedia.org/wiki/Von_Neumann_architecture
 CPU VS GPU
https://developer.nvidia.com/gpugems/gpugems/part-vi-beyond-triangles/chapter-37-toolkit-computation-gpus#:~:text=The main distinction is that,updating memory as it goes.
The main distinction is that the GPU is not a serial processor, but a stream processor. A serial processor, also known as a von Neumann architecture (von Neumann 1945), executes instructions sequentially, updating memory as it

GPU architecture 
https://www.cherryservers.com/blog/everything-you-need-to-know-about-gpu-architecture            GPU Architecture Explained: Everything You Need to Know and How It Has Evolved by Mantas Levinas March 23rd, 2021

https://www.cherryservers.com/blog/gpu-vs-cpu-what-are-the-key-differences        GPU vs CPU Performance Comparison: What are the Key Differences  
 
# ARM assembler and C CPUlator

VERY GOOD https://www.youtube.com/watch?v=N_GleyvoS3I
CPUlator%20Tutorial

Arm Emulator https://cpulator.01xz.net/?sys=arm-de1soc
CPUlator includes a web interface to the GNU assembler (gas) running on the server. 

https://github.com/ascholerChemeketa/armTutorial  ARM Tutorial

ARM Assembly language processing http://www.mwftr.com/416F22/416F22_Chapter2_POST.pdf

https://github.com/priyyanshi/Grapher-VGA-Graphing-Calculator-

https://developer.arm.com/documentation/dui0802/b/A32-and-T32-Instructions/MOV-and-MVN

Really good https://computerscience.chemeketa.edu/armTutorial/index.html   This reader introduces the basics of ARM v7 assembly. The primary goal is to help students who already know how to program in a high level language learn about the form their programs take after compiling - the kinds of instructions a computer really processes information. These materials provide examples of basic ARM instructions, assembly programming constructs, and how high level languages constructs are represented in assembly.

This is the source code for an interactive ARM v7 assembly tutorial. A live version of the tutorial can be found here: http://computerscience.chemeketa.edu/armTutorial/index.html

The goal of the tutorial is to understand assembly well enough to understand how high level code and data are implemented and develop familiarity with working with assembly and with binary representations of data.

cpulator - really good example for vga display code
https://github.com/Tapendra-195/Armv7/tree/main
https://www.youtube.com/watch?v=hHSdjHJekuk%20%20%20VGA%20in%20Arm%20Assembly%20|%20cpulator

https://github.com/nicholas3d2/ARM-tower-defense%20%20ARM-tower-defense

https://www-ug.eecg.utoronto.ca/desl/nios_devices_SoC/ARM/dev_7segs.html  7 segment display

lots of examples https://www-ug.eecg.utoronto.ca/desl/nios_devices_SoC/ARM/  -differnt io


https://schweigi.github.io/assembler-simulator/ simple 8 bit assembler simulator

### jtag urart

https://stackoverflow.com/questions/62073642/how-can-i-get-an-input-from-a-user-with-using-cpulator-in-arm-assembly-language

Well, you're on the right track. The pushbuttons of CPUlator correspond to the bits in the word in memory at the fixed address of 0xFF200050. So the following will read the word into the r0 register:
```
ldr r0, =0xFF200050  //Load the address into a register
ldr r0, [r0] //Load the contents of that address
//Now let's do something with that number...
```

If you check, for example, pushbuttons 0 and 2, that'll give you 5 in r0. Will that do?

The memory address that the button state can be read from is helpfully written in the panel header of CPUlator on the right. The switches panel corresponds to the word at 0xFF200040. I'm not sure what's at 0xFF200100. On a physical device, pushbuttons and switches are probably distinct, but in the CPUlator, I can't see any difference. Use the input source that you like better.

There's also a keyboard panel in the devices, but the processing of that would be more involved.

reading keyboard buffer - not so useful
https://stackoverflow.com/questions/5322340/c-read-directly-from-the-keyboard-buffer

https://nmu.edu/Webb/ArchivedHTML/MathComputerScience/c_programming/c_016.htm  C KEYBOARD INPUTThere is a function in C which allows the programmer to accept input from a keyboard. The following program illustrates the use of this function, 

https://stackoverflow.com/questions/58245724/how-to-print-text-in-cpulator-armv7-de1-soc-jtag-uart
```
.global _start
_start:
        ldr r0,=0xff201000
        mov r1, #'0'
        str r1, [r0]
        b .
```

http://www-ug.eecg.toronto.edu/msl/nios_devices/dev_jtaguart.html  really good discussion toronto
The Data Register is used for both sending and receiving data — the type of instruction executed (stw or ldw) determines whether you send or receive. Every time you read from this register an 8-bit data byte is ejected from the receive FIFO, and every time you write to it you insert a byte to the send FIFO. Note that reading the data register word will obtain the "Number of Bytes available" in bits [31:16], data valid [15], and will also read the data in bits [7:0] and eject another byte (if any) from the queue. The "Number of Bytes available" returns the utilization of the queue before the current read operation.

https://tomverbeure.github.io/2021/05/08/Write-Your-Own-C-and-Python-Clients-for-Intel-JTAG-UART-with-libjtag_atlantic.html  Write Your Own C and Python Clients for the Intel JTAG UART

## this works writing to jtag uart and reading from uart
https://bohr.wlu.ca/cp216/labs/lab08InputOutput.php?d=2024-03-30T23:59:00Z#Topics  Assembly I/OOn a 'real' DE1-SoC computer, we can connect to external devices such as keyboards and monitors, and communicate with this devices through its JTAG (named after the Joint Test Action Group which codified it) UART (Universal Asynchronous Receiver/Transmitter). The simulator cannot communicate with actual external devices or files, but it can simulate writing to and reading from a UART in its JTAG UART box. The box gives the base address of the UART at 0xff201000, and we use this address to communicate with the simulated UART. 
code https://bohr.wlu.ca/cp216/labs/08_io/write_demo.s

SEE ALSO READ DEMO

NOTE - RALLLY GOOD TUTORIALS https://bohr.wlu.ca/cp216/labs/

READ FRO CPULATOR UART  -- this does not work !!!
https://www.studocu.com/en-ca/messages/question/7863926/write-in-armv7-for-cpulator-given-a-text-string-in-uart-print-it-out-such-that-all-lower-case

# Raspberry PI

https://kevinboone.me/pi-asm-toc.html  ARM assembly-language programming for the Raspberry Pi

## general
which version of pi

```
hostnamectl
 Static hostname: raspberrypi01
       Icon name: computer
      Machine ID: e863c6b54d2744a2a9c19751f6f1ac8d
         Boot ID: 06fa2affc15947f4aa4c96584b861c7b
Operating System: Raspbian GNU/Linux 12 (bookworm)
          Kernel: Linux 6.6.31+rpt-rpi-v7
    Architecture: arm

```

## remote access

doesn't work https://timesofindia.indiatimes.com/gadgets-news/how-to-use-your-android-phone-as-a-webcam-on-windows-11/articleshow/108155734.cms

### really good raspberry pi connect – screen sharing
https://forums.raspberrypi.com/viewtopic.php?t=359880  Raspberry Pi OSCan't get wayland running on Pi3B+
To summarise, you can get it working by adding `wayland=on` to the end of the `/boot/firmware/cmdline.txt` file
This works to enable Wayland on my Raspberry Pi 2 :^)

https://connect.raspberrypi.com/devices  raspberry pi connect
https://www.raspberrypi.com/documentation/services/connect.html
https://www.raspberrypi.com/news/raspberry-pi-connect-remote-shell-access-and-support-for-older-devices/

### eduroam pi
solent https://students.solent.ac.uk/studying/wireless-networks
https://www.southampton.ac.uk/isolutions/students/connecting-to-eduroam.page
eduroam assistant tool https://cat.eduroam.org/
eduroam-linux-SUS.py 

https://www.electronicshub.org/setup-wifi-raspberry-pi-2-using-usb-dongle/

### vnc with tight vnc on pi

https://forums.raspberrypi.com/viewtopic.php?t=176408
So I did an update today on my Pi 3 running Raspbian. 
Now when I try to connect to it using VNC from my PC, the VNC viewer goes "No matching security types". 
That's with RealVNC. I get the same error when running vncviewer in Solaris 10. 
If I try TightVNC on the PC, I get "No security types supported". 
Oddly enough, the VNC Viewer app for Android works fine

From there I opened the VNC server window. From there I went to the Options menu, 
set Authentication to "VNC password" and Encryption to "Prefer off". I then clicked OK and that was that. I can now log into the Pi using RealVNC and TightVNC from my PC's again.

•   https://monster6502.com/
•   https://www.cl.cam.ac.uk/projects/raspberrypi/tutorials/
•   https://www.macs.hw.ac.uk/~hwloidl/Courses/F28HS/slides_RPi_arch.pdf

## assembler on PI

### Robert G. Plantz
https://bob.cs.sonoma.edu/IntroCompOrg-RPi/sec-gpio-mem.html  Introduction to Computer Organization: ARM Assembly Language Using the Raspberry Pi Robert G. Plantz (really good)

ARM code in github https://github.com/rgplantz/itco_ARM/tree/main

Thank you, Jobutex, for the kind words about my book. It's being used in the classroom for the first time this semester at Sonoma State University and Santa Rosa Jr. College. I'm sure there will be changes as I receive feedback from the students. :-) And I would very much like to hear comments from any readers, especially errors or suggested improvements. I maintain a log of changes under the "Errata" tab on my main web page.

Note that the last chapter is an assembly language introduction to programming the GPIO. The intent of my explanation is to help the reader to understand how to read the Broadcom datasheet, and the reasons for using /dev/mem and the mmap function. I think this chapter would be useful even for those who will be programming the GPIO in higher level languages.

Enjoy, Bob Plantz https://bob.cs.sonoma.edu/index.html  Robert G. Plantz

https://bob.cs.sonoma.edu/IntroCompOrg-RPi/sec-gdb1.html  2.11 Examining Memory With a Debugger

https://en.wikipedia.org/wiki/Mmap  In computing, mmap(2) is a POSIX-compliant Unix system call that maps files or devices into memory


https://kevinboone.me/pi-asm-00_introduction.html  ARM assembly-language programming for the Raspberry Pi


https://hackaday.io/project/186626-let-us-assemble-some-arm-together/details  ARM and pi

### GPIO programming raspberry pi

https://forums.raspberrypi.com/viewtopic.php?t=117790&sid=b22e4e41b8bed2d5706c784cdafb18d9  Using GPIO from Command Line (Shell)Mon Aug 10, 2015 12:53 pmHi,Thus far I have discovered 3 ways to access GPIO pins on Pi,a. Using the Python lib RPi.GPIOb. Using the C lib WiringPic. Using the command line

https://elinux.org/RPi_GPIO_Code_Samples  RPi GPIO Code Samples  REALLY GOOD

http://webiopi.trouch.com/   The Raspberry Pi Internet of Things Toolkit - Now in two flavorsCayenne - The Spicy one 
WEB API FOR PI


https://www.cl.cam.ac.uk/projects/raspberrypi/tutorials/os/ok01.html Department of Computer Science and Technology
The OK01 lesson contains an explanation about how to get started and teaches how to enable the 'OK' or 'ACT' LED on the Raspberry Pi board near the RCA and USB ports. This light was originally labelled OK but has been renamed to ACT on the revision 2 Raspberry Pi boards. 


https://www.cl.cam.ac.uk/projects/raspberrypi/tutorials/os/ok01.html  simple c on pi
write to led pi 2 (may not work later pi)
OK01 lesson contains an explanation about how to get started and teaches how to enable the 'OK' or 'ACT' LED on the Raspberry Pi board near the RCA and USB ports. This light was originally labelled OK but has been renamed to ACT on the revision 2 Raspberry Pi boards


pi GPIO from arm assembly 
https://www.linux-magazine.com/Issues/2021/247/ARM64-Assembly-and-GPIO  Access Raspberry Pi GPIO with ARM64 assembly  

Code for this article: ftp://ftp.linux-magazine.com/pub/listings/linux-magazine.com/247/
https://www.cl.cam.ac.uk/projects/raspberrypi/tutorials/os/ok02.html  turn on off repeatedly


example to write to gpio in C using latest wiring pi

to install wiring pi

see wiring pi releases https://github.com/WiringPi/WiringPi/releases

download  wiringpi_3.10_armhf.deb 

sudo apt-get install ./wiringpi_3.10_armhf.deb 

try 
gpio -h   for basic commands
man gpio  for more detailed manual

gpio readall to see inputs

```
gpio readall
 +-----+-----+---------+------+---+---Pi 2---+---+------+---------+-----+-----+
 | BCM | wPi |   Name  | Mode | V | Physical | V | Mode | Name    | wPi | BCM |
 +-----+-----+---------+------+---+----++----+---+------+---------+-----+-----+
 |     |     |    3.3v |      |   |  1 || 2  |   |      | 5v      |     |     |
 |   2 |   8 |   SDA.1 |   IN | 1 |  3 || 4  |   |      | 5v      |     |     |
 |   3 |   9 |   SCL.1 |   IN | 1 |  5 || 6  |   |      | 0v      |     |     |
 |   4 |   7 | GPIO. 7 |   IN | 1 |  7 || 8  | 1 | ALT0 | TxD     | 15  | 14  |
 |     |     |      0v |      |   |  9 || 10 | 1 | ALT0 | RxD     | 16  | 15  |
 |  17 |   0 | GPIO. 0 |   IN | 0 | 11 || 12 | 0 | IN   | GPIO. 1 | 1   | 18  |
 |  27 |   2 | GPIO. 2 |   IN | 0 | 13 || 14 |   |      | 0v      |     |     |
 |  22 |   3 | GPIO. 3 |   IN | 0 | 15 || 16 | 0 | IN   | GPIO. 4 | 4   | 23  |
 |     |     |    3.3v |      |   | 17 || 18 | 0 | IN   | GPIO. 5 | 5   | 24  |
 |  10 |  12 |    MOSI |   IN | 0 | 19 || 20 |   |      | 0v      |     |     |
 |   9 |  13 |    MISO |   IN | 0 | 21 || 22 | 0 | IN   | GPIO. 6 | 6   | 25  |
 |  11 |  14 |    SCLK |   IN | 0 | 23 || 24 | 1 | IN   | CE0     | 10  | 8   |
 |     |     |      0v |      |   | 25 || 26 | 1 | IN   | CE1     | 11  | 7   |
 |   0 |  30 |   SDA.0 |   IN | 1 | 27 || 28 | 1 | IN   | SCL.0   | 31  | 1   |
 |   5 |  21 | GPIO.21 |   IN | 1 | 29 || 30 |   |      | 0v      |     |     |
 |   6 |  22 | GPIO.22 |   IN | 1 | 31 || 32 | 0 | IN   | GPIO.26 | 26  | 12  |
 |  13 |  23 | GPIO.23 |   IN | 0 | 33 || 34 |   |      | 0v      |     |     |
 |  19 |  24 | GPIO.24 |   IN | 0 | 35 || 36 | 0 | IN   | GPIO.27 | 27  | 16  |
 |  26 |  25 | GPIO.25 |   IN | 0 | 37 || 38 | 0 | IN   | GPIO.28 | 28  | 20  |
 |     |     |      0v |      |   | 39 || 40 | 0 | IN   | GPIO.29 | 29  | 21  |
 +-----+-----+---------+------+---+----++----+---+------+---------+-----+-----+
 | BCM | wPi |   Name  | Mode | V | Physical | V | Mode | Name    | wPi | BCM |
 +-----+-----+---------+------+---+---Pi 2---+---+------+---------+-----+-----+

```

to write to outputs try toggling 

gpio toggle 25



then try this example to access the gpio
https://learn.sparkfun.com/tutorials/raspberry-gpio/c-wiringpi-example







built in led pi 3 and 4
https://raspberrypi.stackexchange.com/questions/103794/is-there-any-built-in-led-connected-with-gpio-pin
In the terminal:
sudo echo 1 > sudo /sys/class/leds/led0/brightness
This turns the green led on.
sudo echo 0 > sudo /sys/class/leds/led0/brightness
To turn off the activity indicator override: (put it back how it was)
echo mmc0 >/sys/class/leds/led0/trigger



not sure if correct with pi 3b
https://raspberry-valley.azurewebsites.net/Raspberry-Pi-LEDs/            Raspberry Pi LEDs The Raspberry Pi comes with several status leds on the board. This article is a reference of basic status led values. You will most probably check the blinking (or non-blinking) leds on your board, if something goes wrong


https://raspberry-valley.azurewebsites.net raspbetty valley  lots of useful stuff here

useful  pi 3b LEDs  (see also Cambridge  material)
https://raspberrypi.stackexchange.com/questions/70013/raspberry-pi-3-model-b-system-leds

### Working examples on class pi

#### cli gpio tool

https://embeddedcomputing.com/technology/processing/interface-io/quick-start-raspberry-pi-gpio-terminal-interface

raspi-gpio help

pinctrl help

# gertboard software

https://github.com/ChrisCummins/gertboard_sw
same as in class notes
git clone git@github.com:ChrisCummins/gertboard_sw.git

various examples


# controlling leds


https://www.jeffgeerling.com/blogs/jeff-geerling/controlling-pwr-act-leds-raspberry-pi   Controlling PWR and ACT LEDs on the Raspberry Pi

```
echo heartbeat | sudo tee /sys/class/leds/ACT/trigger
```

The values written to those paths control how the LEDs are triggered, as follows:
```
    gpio - controlled through GPIO (off by default)
    heartbeat - heartbeat-like pulse
    timer - pulse every second
    input - under-voltage detection
    mmc0 - memory I/O
    cpu0 - CPU activity
```

LEDs 

```
sudo sh -c 'echo input > /sys/class/leds/ACT/trigger'
sudo sh -c 'echo input > /sys/class/leds/PWR/trigger'
sudo sh -c 'echo 1 > /sys/class/leds/ACT/brightness'
sudo sh -c 'echo 1 > /sys/class/leds/PWR/brightness'

Reverting to none and 0 turns them off, as expected. Progress.

sudo sh -c 'echo none > /sys/class/leds/ACT/trigger'
sudo sh -c 'echo none > /sys/class/leds/PWR/trigger'
sudo sh -c 'echo 0 > /sys/class/leds/ACT/brightness'
sudo sh -c 'echo 0 > /sys/class/leds/PWR/brightness'


```


## C on pi

https://smist08.wordpress.com/2017/12/23/c-programming-on-the-raspberry-pi/           Stephen Smith's Blog Musings on Machine Learning… C Programming on the Raspberry Pi 3 Votes Introduction  really good pi program using c and assembler

http://www.macs.hw.ac.uk/~hwloidl/Courses/F28HS/Essentials_C_v1.pdf   WELCOMETO LEARN TOCODE WITH C  on raspberry pi

https://personal.utdallas.edu/~pervin/RPiA/RPiA.pdf   RASPBERRY PI ASSEMBLER

https://www.cl.cam.ac.uk/projects/raspberrypi/tutorials/rpii/cintro.html   C.1 Introductions to C ProgrammingThis is a short and quick introduction to programming in C. This section is aimed at anybody who is interested new to programming and may wish to exploring the libRPii source files. The examples and exercise are designed to provide enough references and experience such that even complete beginners can still make the most out of the exploring libRPii tools. All of the source code examples (with prefix ExS.) can be found in the libRPii example source packages. See section GS.2 about how to get these resources. 

## python on pi 
https://www.halvorsen.blog/documents/programming/python/resources/Raspberry%20Pi%20and%20Python.pdf

## GPU programing pi

GPU CPU cuda memories
https://www.tutorialspoint.com/cuda/cuda_memories.htm              Apart from the device DRAM, CUDA supports several additional types of memory that can be used to increase the CGMA ratio for a kernel  

https://github.com/BenKluwe/QPULib            A language and compiler for the Raspberry Pi GPU

how to use the frame buffer  pi
https://forums.raspberrypi.com/viewtopic.php?t=155825&sid=14899912b12e5468995e28321626fdd1 note mailbox GPU

really interesting GPU ON PI 2014 https://petewarden.com/2014/08/07/how-to-optimize-raspberry-pi-code-using-its-gpu/

updated library from This project, V3dLib, makes programming for the GPU more accessible. It builds upon a previous project, QPULib, and adds support for the Pi 4, which has a different GPU model

 https://github.com/wimrijnders/V3DLib/tree/main         V3DLib Version 0.7.15 V3DLib is a C++ library for creating programs to run on the VideoCore GPU's of all versions of the Raspberry Pi. Prior to the Pi 4, this meant compiling for just the VideoCore IV GPU. The Pi 4, however, has a VideoCore VI GPU which, although related, is significantly different. V3DLib compiles and assembles for both versions of the VideoCore GPU



## PI on DOCKER QEMU

https://github.com/ascholerChemeketa/armTutorial?tab=readme-ov-file

https://forums.raspberrypi.com/viewtopic.php?t=359999  Official Docker images of Raspberry Pi OS?

https://github.com/dtcooper/raspberrypi-os-docker/tree/main  Raspberry Pi OS Docker Base Images 
https://hub.docker.com/r/balenalib/raspberry-pi  This image is part of the balena.io base image series for IoT devices.
https://github.com/balena-io-library

https://github.com/mrhavens/pidoc
An autoconfiguring stack to build simple, scalable, and fully binary ARM compatible Raspberry Pi clusters on Intel or AMD architecture.
https://gcore.com/learning/raspberry-pi-cluster-emulation-with-docker-compose/  Raspberry Pi Cluster Emulation With Docker Compose
https://itnext.io/raspberry-pi-cluster-emulation-with-docker-compose-2d5583cd645

balina based images qemu https://github.com/search?q=repo%3Abalena-io-library%2Fbase-images%20qemu&type=code


# Misc
google docs to markdown tool  https://boost-tool.com/en/tools/md_table  Table to Markdown 


### windows gcc on eclipse
https://www3.ntu.edu.sg/home/ehchua/programming/howto/eclipsecpp_howto.html    How to Install Eclipse C/C++ Development Tool (CDT) 8.1.2 for Eclipse 4.2.2 (Juno)

(https://medium.com/@rcoe67/tips-for-seamlessly-using-cygwin-and-wsl-in-windows-10-9ed1a72ace6c  Tips for seamlessly using Cygwin and WSL in Windows 10)


https://www3.ntu.edu.sg/home/ehchua/programming/howto/Cygwin_HowTo.html#mingw   How to install MinGW-w64 GCC Compiler

https://www.mingw-w64.org/  Mingw-w64 is an advancement of the original mingw.org project, created to support the GCC compiler on Windows systems. It has forked it in 2007 in order to provide support for 64 bits and new APIs. It has since then gained widespread use and distribution.

You can install MinGW-w64 via MSYS2 (https://www.msys2.org/), which provides up-to-date native builds of GCC, Mingw-s64 and other helpful C++ tool and libraries..

I installed in C:\devel\msys64

after installation install gcc
pacman -S mingw-w64-ucrt-x86_64-gcc

https://www.devdungeon.com/content/how-setup-gcc-msys2-eclipse-windows-c-development
but you want to at a minimum make sure your PATH variable includes the directories with make and g++.

change path in 'Advanced System Settings'
C:\devel\msys64\mingw64\bin
C:\devel\msys64\usr\bin



