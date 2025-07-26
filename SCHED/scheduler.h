/*
 * scheduler.h
 *
 *  Created on: Jun 29, 2014
 *      Author: Jason
 */

#ifndef SCHEDULER_H_
#define SCHEDULER_H_


typedef struct {
    void   (*task)(void); // Pointer to the task function.
    uint32_t period;      // Period to execute with.
    uint32_t delay;       // Delay before first call.
} task_type;

void Dispatch_Tasks( void );
void Create_Task(void (*)(void), uint32_t, uint32_t) ;
void Idle_Mode( void );
#endif /* SCHEDULER_H_ */
