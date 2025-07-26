/*
 * scheduler.c
 *
 *  Created on: Jun 29, 2014
 *      Author: Jason
 */
#include "stm32G0xx.h"
#include "scheduler.h"
volatile uint32_t elapsed_ticks = 0;

#define NUM_TASKS 2

task_type tasks[NUM_TASKS];
volatile uint8_t idle = 0;


void Dispatch_Tasks(void)
{
	uint32_t i = 0;

    __disable_irq();
    while (elapsed_ticks > 0) { // TRUE only if the ISR ran.
        for (i = 0; i < NUM_TASKS; i++) {
            if (--tasks[i].delay == 0) {
                tasks[i].delay = tasks[i].period;

                __enable_irq();
                tasks[i].task(); // Execute the task!
                __disable_irq();
            }
        }
        --elapsed_ticks;
    }
    __enable_irq();
}

void Create_Task(void (*function_pointer)(void),
                 uint32_t period,
                 uint32_t delay) {
    static uint32_t index = 0;


    tasks[index].task = function_pointer;
    tasks[index].period = period;
    // Avoid underflow in the dispatcher.
    tasks[index].delay = delay + 1;
    ++index;
}

void Idle_Mode( )
{
	idle = 1;

	while(idle);

}

