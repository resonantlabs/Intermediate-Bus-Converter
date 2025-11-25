set(source_list ${source_list}
${PROJ_PATH}/CONFIG/startup_stm32g030xx.s
# ${PROJ_PATH}/CONFIG/tx_initialize_low_level.s
${PROJ_PATH}/CONFIG/hw_config.c
${PROJ_PATH}/CONFIG/system_stm32g0xx.c
${PROJ_PATH}/CONFIG/stm32g0xx_it.c
${PROJ_PATH}/CONFIG/hw_config.c
${STM32_LIBRARY_PATH}/stm32g0xx_HAL_Driver/Src/stm32g0xx_hal_gpio.c 
${STM32_LIBRARY_PATH}/stm32g0xx_HAL_Driver/Src/stm32g0xx_hal_cortex.c 
${STM32_LIBRARY_PATH}/stm32g0xx_HAL_Driver/Src/stm32g0xx_hal.c 
${STM32_LIBRARY_PATH}/stm32g0xx_HAL_Driver/Src/stm32g0xx_hal_rcc.c 
${STM32_LIBRARY_PATH}/stm32g0xx_HAL_Driver/Src/stm32g0xx_hal_rcc_ex.c 
${STM32_LIBRARY_PATH}/stm32g0xx_HAL_Driver/Src/stm32g0xx_hal_pwr.c 
${STM32_LIBRARY_PATH}/stm32g0xx_HAL_Driver/Src/stm32g0xx_hal_pwr_ex.c
${STM32_LIBRARY_PATH}/stm32g0xx_HAL_Driver/Src/stm32g0xx_hal_rtc.c
${STM32_LIBRARY_PATH}/stm32g0xx_HAL_Driver/Src/stm32g0xx_hal_tim.c
${STM32_LIBRARY_PATH}/stm32g0xx_HAL_Driver/Src/stm32g0xx_hal_tim_ex.c
${STM32_LIBRARY_PATH}/stm32g0xx_HAL_Driver/Src/stm32g0xx_hal_adc.c
${STM32_LIBRARY_PATH}/stm32g0xx_HAL_Driver/Src/stm32g0xx_hal_adc_ex.c
${STM32_LIBRARY_PATH}/stm32g0xx_HAL_Driver/Src/stm32g0xx_hal_dma.c
${PROJ_PATH}/main.c
${PROJ_PATH}/APP/pwm.c
)
