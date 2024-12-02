# Makefile for lkm_gpio

obj-m+=lkm_gpio.o

all:
  make -C /lib/modules/$(shell uname -r)/build/ M=$(PWD) modules
  sudo ./lkm_auto.sh    # set lkm_gpio.ko to run automatically
clean:
  make -C /lib/modules/$(shell uname -r)/build/ M=$(PWD) clean

