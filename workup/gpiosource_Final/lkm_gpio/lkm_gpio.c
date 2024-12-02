//***************************************************************************
// @file  lkm_gpio.c
// @author  John Schwartzman
// @date  04/11/2021
// @version 1.0
// @brief   A loadable kernel module (LKM) that handles interrupts
//      from user space.
//***************************************************************************

#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/interrupt.h>
#include <linux/gpio.h>

// #define __HW__DEBOUNCE__ // uncomment this line for __HW__DEBOUNCE__

static unsigned int irq_number;
static unsigned int gpio_button = 17;   // switch connects to Pin 17
static unsigned int pin_to_control = 22;  // Pin 22 - tell user about int.

//***************************************************************************
// irq handler - fired on interrupt
static irqreturn_t irq_handler(int irq, void* dev_id, struct pt_regs* regs)
{
  unsigned long flags;

  // disable this hardware interrupt
  local_irq_save(flags);

  // Turn on GPIO pin 22).
  // That's how the user space program determines that it has been
  // interrupted.
  // It reads pin 22 and if it gets a 0 then it knows it should finish.
  gpio_set_value(pin_to_control, 0);

  // restore this hardware interrupt
  local_irq_restore(flags);
  return IRQ_HANDLED;
}

//***************************************************************************
// configure interrupts
static void irq_config(void)
{
#ifndef __HW__DEBOUNCE__
  int retval;
#endif

  gpio_request(gpio_button, "gpio_button");
  gpio_direction_input(gpio_button);
  gpio_direction_output(pin_to_control, 1);

  // If you don't debounce the switch with hardware, uncomment
  // gpio_set_debounce(), and the kernel module will do it for
  // you in software.
  irq_number = gpio_to_irq(gpio_button);
  printk(KERN_INFO "lkm_gpio: gpio_button is currently %d\n",
       gpio_get_value(gpio_button));
  printk(KERN_INFO "lkm_gpio: Mapped irq number to %d\n", irq_number);

  #ifndef __HW__DEBOUNCE__
    // Use IRQF_TRIGGER_FALLING if the switch is
    // connected directly to gpio_button.
    // If the switch is debounced using an Schmitt trigger inverter chip
    // then use IRQF_TRIGGER_RISING.
    retval = gpio_set_debounce(gpio_button, 600); // recheck after 600µs
    if (retval != 0)
    {
      printk(KERN_WARNING "lkm_gpio: gpio_set_debounce() returned %d\n",
           retval);
    }
    if (request_irq(irq_number,
            (irq_handler_t)irq_handler,
            IRQF_TRIGGER_FALLING, // falling if software debouncing
            "RPI_gpio_handler",   // identify owner in /proc/interrupts
            NULL))
    {
      printk(KERN_INFO "lkm_gpio: Irq request failure");
    }
  #else // we're doing our debouncing in hardware
    // Use IRQF_TRIGGER_FALLING if the switch is
    // connected directly to gpio_button.
    // If the switch is debounced using an Schmitt trigger inverter chip
    // then use IRQF_TRIGGER_RISING.
    if (request_irq(irq_number,
            (irq_handler_t)irq_handler,
            IRQF_TRIGGER_RISING,  // rising if debounced switch
            "RPI_gpio_handler",   // identify owner in /proc/interrupts
            NULL))
    {
      printk(KERN_INFO "lkm_gpio: Irq request failure");
    }
  #endif
}

//***************************************************************************
// release interrupts
static void irq_release(void)
{
  free_irq(irq_number, NULL);
  gpio_free(irq_number);
}

//***************************************************************************
static int init(void)
{
  printk(KERN_INFO "lkm_gpio: Hello from the RPi GPIO LKM!\n");
  irq_config();
  return 0;
}

//***************************************************************************
static void cleanup(void)
{
  printk(KERN_INFO "lkm_gpio: Goodbye from the RPi GPIO LKM!\n");
  irq_release();
}

module_init(init);
module_exit(cleanup);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("John Schwartzman");
MODULE_DESCRIPTION("An interruptible LKM for RPi GPIO.");
MODULE_VERSION("1.0");
