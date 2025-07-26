/**
  ******************************************************************************
  * @file  main.c
  * @author  
  * @version
  * @date     
  * @brief
  * @partnumber 
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2013</center></h2>
  *
  *
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "stm32G0xx.h"
#include "stm32G0xx_hal.h"
#include "hw_config.h"
#include "scheduler.h"
#include "pwm.h"
#include "adc.h"



/* Calibration variables ---------------------------------------------------------*/
/* System variables ------------- ---------------------------------------------*/
__VOLTAGE vdda, v5v;



/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
void TSK_500ms(void);
void TSK_10ms(void);


/* Private functions ---------------------------------------------------------*/
int main(void)
{
  HAL_Init();
  SystemClock_Config();
  MX_TIM1_Init();
  MX_ADC1_Init();

  Create_Task(TSK_10ms, 1, 0);
  Create_Task(TSK_500ms, 500, 10);

  HAL_Delay(100);
  PWM_Start();
  
  vdda = (uint16_t)(((uint32_t)(3u * 256u) * (uint32_t)(*VREFCAL))/ aADCxConvertedData[CH_VREF]);


  while(1)
  {
    Idle_Mode();
    Dispatch_Tasks();
  }

}

void TSK_10ms()
{ 
  v5v = vdda * aADCxConvertedData[CH_5V]/ 4096u;
  
  

}

void TSK_500ms()
{



}


