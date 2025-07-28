# Open Sourcing Intermediate Bus Converters for High Power Electronics

This is an Open Source Project to create a framework for seemlessly incorporating Intermediate Bus Converters (IBC) into your PCB design. 

## What are Intermediate Bus Converters (IBC)?
![Block Diagram](/assets/IBC-Overview.png)

IBCs can also be called DC/DC Transformers or sometimes Isolated/Non-Isolated Non Regulated Forward Converters. I really like the name DC/DC Transformers because that's how they act. Vout  = Vin * Ratio.

### Some examples:
- 4:1 Transformer, Vin = 24V, Vout = 6V
- 10:1 Transformer, Vin = 400V, Vout = 40V
- 1:10 Transformer, Vin = 40V, Vout = 400V

Also remember that these are switching converters so Power In = Power Out. So if we were to add current to the above Scenarios ( and assume unity efficiency) 
- 4:1 Transformer, Vin = 24V/2A, Vout = 6V/8A
- 10:1 Transformer, Vin = 400V/1A, Vout = 40V/10A
- 1:10 Transformer, Vin = 40V/10A, Vout = 400V/1A

### The structure of a IBC is slightly more complex than a buck or boost converter but not much.
![Block Diagram](/assets/IBC-Structure.png)

1. 4 MOSFETs in a H-Bridge Configuration for switching the Transformer's Primary Coil. They are typically drive by a FET driver which is not shown in this picture
2. We typcially use for center tapped secondary coils for simplicity ( this has it's draw backs )
3. SSR or Secondary Side Rectification are MOSFETs acting like diodes for rectification. They are typically driver by a FET or SSR driver
4. LC Filter. These are typically small valued who purpose is to smooth out any switching noise.

>[!NOTE]
>See if you can identify all the components in the schematic of a 5:1 IBC. [IBC-Schematic](/PCB/IBC-Schematic.PDF)

## Why Use IBCs
1. High Efficiency, up to 98%
2. Low EMI
3. Extermely Robust and Stable
4. Minimal Software Intervention

### 1. High Efficiency
IBC's are typically 95%-98% efficent conversion, mainly due to reduced conduction and switching losses. Why is that?

If you remember from above the example of a 4:1 IBC Converter --> Vin = 24V/2A, Vout = 6V/8A. 
- Typically higher voltage fets have higher RDS (on resistance) which means the higher RDS the more conduction loss. This is good news as our IBC ( as with all IBCs ) has lower current at the higher voltage. 
>[!Note]
>This is not true for traditional buck and boost converters.
- Switching Loss is function of switching current and voltage. This is again good news for the same reason as above.

### 2. Low EMI
Radiated and Conducted Noise is generally reduced with an IBC as compared to a traditional buck or boost converter.

- EMI is a function of Switching Loss (See Above)
- Input Current and Output Current are almost DC with an IBC this is not true with a traditional buck or boost converter

>[!Note]
>As shown below the Input (Iin) and Output (Iout) current waveforms of a traditonal buck converter are choppy. The IBC is nearly DC. 
>
>This means the bulk capacitor need for filter is greater reduced.

![Block Diagram](/assets/IBC-Waveforms.png)

### 3. Extermely Robust and Stable
IBC's have are not regulated. This means there are:
- No Compensation Network
- No Stability Issues
- Extermelly fast response due to high bandwidth   
- Minimal testing/simulation/rework

### 4. Minimal Software Intervention
Because you don't have to regulate or compensate an IBC, that means a simple microcontoller can easily control it. 
- Microcontroller needs to only send a PWM signal to control the H-Bridge. It must have dead time control so as the FETs don't shoot through
- Microcontroller will need to ramp up the duty at start up to mitigate inrush which can lead to over current scenarios
- Microcontroller will need to monitor for an over current and HALT pwm. This would/should only occur if a failure has happended downstream

>[!Note]
>Source Code is for an STM32G0 series and a 5:1 IBC

<!-- Most engineers who design electronics are quite comfortable using buck and boost converters for their designs. The ICs are typically easy to use and the manufactures provide lots of help to the get your project off the ground. 



An example is a device that accepts 48Vin +/- 2.5V and has output rails of 12V/5A, 5V/5A, 3.3V/10A -->

