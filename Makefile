# Makefile

PART = cortex-m0
LDNAME = CONFIG/STM32G030K6T6_FLASH.ld

HARDWARE_VERSION = 1
SOFTWARE_VERSION = 1

 
#CMSIS FIles 
CFILES = stm32g0xx_it.c system_stm32g0xx.c
AFILES = startup_stm32g030xx.s tx_initialize_low_level.s

#Library Files
CFILES += stm32g0xx_hal_gpio.c 
CFILES += stm32g0xx_hal_cortex.c stm32g0xx_hal.c
CFILES += stm32g0xx_hal_rcc.c stm32g0xx_hal_rcc_ex.c
CFILES += stm32g0xx_hal_pwr.c stm32g0xx_hal_pwr_ex.c stm32g0xx_hal_rtc.c
CFILES += stm32g0xx_hal_tim.c stm32g0xx_hal_tim_ex.c
CFILES += stm32g0xx_hal_adc.c stm32g0xx_hal_adc_ex.c
CFILES += stm32g0xx_hal_dma.c



#Application Files

XFILES += main.c hw_config.c pwm.c adc.c

#Libraries
OFILES = libthreadx.a

OUTDIR = obj
OUTBASE = firmware
STM32CubeG0 = C:/Libraries/STM32CubeG0/Drivers
THREADX = C:/Libraries/threadx
VPATH = $(STM32CubeG0)/stm32g0xx_HAL_Driver/Src 
VPATH += $(THREADX)/build_m0
VPATH += APP CONFIG SCHED

BIN = $(OUTDIR)/$(OUTBASE).hex
OUT = $(OUTDIR)/$(OUTBASE).elf
OBJS =  $(AFILES:%.s=$(OUTDIR)/%.o) $(CFILES:%.c=$(OUTDIR)/%.o) $(XFILES:%.c=$(OUTDIR)/%.o)
OBJS += $(OFILES)

CC = arm-none-eabi-gcc
AS = arm-none-eabi-gcc
LD = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy
OBJSIZE = arm-none-eabi-size
DFUTOOL = DFU/hex2dfu
REMOVE = C:/MinGW/msys/1.0/bin/rm


INCLUDES =  -I. -I APP -I CONFIG -I SCHED
INCLUDES += -I $(STM32CubeG0)/CMSIS/Device/ST/stm32g0xx/Include
INCLUDES += -I $(STM32CubeG0)/CMSIS/Include
INCLUDES += -I $(STM32CubeG0)/stm32g0xx_HAL_Driver/Inc
INCLUDES += -I $(THREADX)/common/inc
INCLUDES += -I $(THREADX)/ports/cortex_m0/gnu/inc


CFLAGS=	-Og\
		-c\
		-g\
		-DHARDWARE_VERSION=$(HARDWARE_VERSION)\
		-DSOFTWARE_VERSION=$(SOFTWARE_VERSION)\
		-DSTM32G030xx\
		-DTX_INCLUDE_USER_DEFINE_FILE\
		-mthumb\
		-mcpu=$(PART)\
		-Wall\
		-Wa,-a,-ad\
		-ffunction-sections\
		-fdata-sections\
		-fmessage-length=0\
		-fno-builtin


ASFLAGS=-c\
		-g\
		-mthumb\
		-mcpu=$(PART)\
		-Wall\
		-ffunction-sections\
		-fdata-sections\
		-fmessage-length=0\
		-x assembler-with-cpp
	
		
LDFLAGS= -mthumb\
		 -mcpu=$(PART)\
		 -T $(LDNAME)\
		 -nostartfiles\
		 -Xlinker -Map=obj/firmware.map\
		 -lm\
		 -Wl,--gc-sections

DBGFLAGS = 
  
 .PHONY:	all clean cleanx    
 
all:  $(BIN)

$(BIN):$(OUT)
	$(OBJSIZE) --format=berkeley $(<)
	$(OBJCOPY) -j .isr_vector -j .text -j .data -j .rodata -O ihex $(<) $(@)


$(OUT):	$(OBJS)
	$(LD) $(LDFLAGS) -o $(@) $(filter %.o %.a, ${^})

$(OUTDIR)/%.o:	%.c
	$(CC) $(CFLAGS) $(INCLUDES) $(DBGFLAGS) -o $(@) $(<) > $(@:.o=.lst)

$(OUTDIR)/%.o:	%.s
	$(AS) $(ASFLAGS) $(INCLUDES) -o $(@) $(<)

    
clean: 
	$(REMOVE) -f $(OBJS) $(OBJS:.o=.lst) $(OUT) \
		$(OUT:.elf=.map) $(OUT:.elf=.dfu) $(OUT:.elf=.bin) $(OUT:.elf=.hex)

cleanx: 
	$(REMOVE) -f $(XFILES:%.c=$(OUTDIR)/%.o) $(XFILES:%.c=$(OUTDIR)/%.lst) $(OUT) \
		$(OUT:.elf=.map) $(OUT:.elf=.dfu) $(OUT:.elf=.bin) $(OUT:.elf=.hex)		


     