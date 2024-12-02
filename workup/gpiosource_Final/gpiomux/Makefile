#############################################################################
# Makefile for gpiomux
#   John Schwartzman, Forte Systems, Inc.
#   03/17/2021
# ARM64
# Commands:  make release, make debug, make clean
#        make = make release
#   Requires:  ../maketest.sh
#############################################################################
LIB   := libgpio
PROG1 := gpiocount
PROG2 := gpiomux
PROG3 := countmain.cpp
PROG4 := muxmain.cpp
INC   := arm64_include.asm
LDIR  := ~/Development/lib
SHELL := /bin/bash
# OPT := __MAIN__ # uncomment this line to build without main() functions
          # or type make OPT-__MAIN__

ifeq ($(OPT), __MAIN__) ############# build without C++ main functions#########

release: $(PROG1).asm $(PROG1).h $(PROG2).asm $(LIB).asm $(INC) Makefile
  @source ../maketest.sh && test release debug
  as -o $(LIB).obj $(LIB).asm
  as -defsym OPT=__MAIN__ -o $(PROG1).obj $(PROG1).asm
  as -defsym OPT=__MAIN__ -o $(PROG2).obj $(PROG2).asm
  g++ -shared $(LIB).obj -o libgpio.so
  mv $(LIB).so $(LDIR)
  g++ -L $(LDIR) $(PROG1).obj -o $(PROG1) -lgpio
  g++ -L $(LDIR) $(PROG2).obj -o $(PROG2) -lgpio

debug: $(PROG1).asm $(PROG1).h $(PROG2).asm $(LIB).asm $(INC) Makefile
  as -g -o $(LIB).obj $(LIB).asm
  as -g -defsym OPT=__MAIN__ -o $(PROG1).obj $(PROG1).asm
  as -g -defsym OPT=__MAIN__ -o $(PROG2).obj $(PROG2).asm
  g++ -g -shared $(LIB).obj -o $(LIB).so
  mv $(LIB).so $(LDIR)
  g++ -L $(LDIR) -g $(PROG1).obj -o $(PROG1) -lgpio
  g++ -L $(LDIR) -g $(PROG2).obj -o $(PROG2) -lgpio

else  ################### build with C++ main functions ###################

release: $(PROG1).asm $(PROG1).h $(PROG2).asm $(PROG3) $(PROG4) $(LIB).asm $(INC) Makefile
  @source ../maketest.sh && test release debug
  as -o $(LIB).obj $(LIB).asm
  as -o $(PROG1).obj $(PROG1).asm
  as -o $(PROG2).obj $(PROG2).asm
  g++ -shared $(LIB).obj -o $(LIB).so
  mv $(LIB).so $(LDIR)
  g++ -L $(LDIR) $(PROG3) $(PROG1).obj -o $(PROG1) -lgpio
  g++ -L $(LDIR) $(PROG4) $(PROG2).obj -o $(PROG2) -lgpio

debug: $(PROG1).asm $(PROG1).h $(PROG2).asm $(PROG3) $(PROG4) $(LIB).asm $(INC) Makefile
  @source ../maketest.sh && test debug release
  as -g -o $(LIB).obj $(LIB).asm
  as -g -o $(PROG1).obj $(PROG1).asm
  as -g -o $(PROG2).obj $(PROG2).asm
  g++ -g -shared $(LIB).obj -o $(LIB).so
  mv $(LIB).so $(LDIR)
  g++ -L $(LDIR) -g $(PROG3) $(PROG1).obj -o $(PROG1) -lgpio
  g++ -L $(LDIR) -g $(PROG4) $(PROG2).obj -o $(PROG2) -lgpio

endif #####################################################################

clean:
  @rm -f $(PROG1) $(PROG2) $(LDIR)/$(LIB).so *.obj debug release
#############################################################################
