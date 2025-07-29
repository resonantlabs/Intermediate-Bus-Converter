# Open Sourcing Intermediate Bus Converters for High Power Electronics

This is an Open Source Project to create a framework for seamlessly incorporating Intermediate Bus Converters (IBC) into your PCB design. 

## What are Intermediate Bus Converters (IBC)?
![Block Diagram](/assets/IBC-Overview.png)

IBCs can also be called DC/DC Transformers or sometimes Isolated/Non-Isolated Non Regulated Forward Converters. I like the name DC/DC Transformers because that's how they act. Vout  = Vin * Ratio.

### Some examples:
- 4:1 Transformer, Vin = 24V, Vout = 6V
- 10:1 Transformer, Vin = 400V, Vout = 40V
- 1:10 Transformer, Vin = 40V, Vout = 400V

Also remember that these are switching converters so Power In = Power Out. So if we were to add current to the above Scenarios ( and assume unity efficiency) 
- 4:1 Transformer, Vin = 24V/2A, Vout = 6V/8A
- 10:1 Transformer, Vin = 400V/1A, Vout = 40V/10A
- 1:10 Transformer, Vin = 40V/10A, Vout = 400V/1A

### The structure of an IBC is slightly more complex than a buck or boost converter but not much.
![Block Diagram](/assets/IBC-Structure.png)

1. 4 MOSFETs in a H-Bridge Configuration for switching the Transformer's Primary Coil. They are typically driven by a FET driver, which is not shown in this picture
2. We typically use for center tapped secondary coils for simplicity ( this has it's drawbacks)
3. SSR or Secondary Side Rectification are MOSFETs acting like diodes for rectification. They are typically driven by a FET or SSR driver
4. LC Filter. These are typically small valued whose purpose is to smooth out any switching noise.

>[!NOTE]
>See if you can identify all the components in the schematic of a 5:1 IBC. [IBC-Schematic](/PCB/IBC-Schematic.PDF)

## Why Use IBCs?
1. High Efficiency, up to 98%
2. Low EMI
3. Extremely Robust and Stable
4. Minimal Software Intervention

### 1. High Efficiency
IBC's are typically 95%-98% efficient conversion, mainly due to reduced conduction and switching losses. Why is that?

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
>As shown below the Input (Iin) and Output (Iout) current waveforms of a traditional buck converter are choppy. The IBC is nearly DC. 
>
>This means the bulk capacitor need for filter is greater reduced.

![Waveform comparison](/assets/IBC-Waveforms.png)

### 3. Extremely Robust and Stable
IBC's have are not regulated. This means there are:
- No Compensation Network
- No Stability Issues
- Extremely fast response due to high bandwidth   
- Minimal testing/simulation/rework

### 4. Minimal Software Intervention
Because you don't have to regulate or compensate an IBC, that means a simple microcontoller can easily control it. 
- Microcontroller needs to only send a PWM signal to control the H-Bridge. It must have dead time control so as the FETs don't shoot through
- Microcontroller will need to ramp up the duty at start up to mitigate inrush which can lead to over current scenarios
- Microcontroller will need to monitor for an over current and HALT pwm. This would/should only occur if a failure has happened downstream
- Microcontroller can be used for other tasks as the burden from the IBC is nearly zero.

>[!Note]
>Source Code is for an STM32G0 series and a 5:1 IBC

## A System Example

The example below is a power system that accepts 48Vin +/- 2.5V and has POL outputs of 5V@10A, 3.3V@20A. The traditional buck converter system topology is shown on the left and the IBC followed by two buck converters is on the right.

![System Comparison](/assets/IBC-System.png)

- Higher voltage buck converters ( >12V ) typically have lower efficiency due to higher switching losses
- The IBC system has less power loss
- The IBC system doesn't have a 48V-->9.8V control loop which makes development much easier
    - High power compensation can be tricky and a time sink
    - Don't have to worry about system response of di/dt events of downstream converters
- IBC systems are easier to cool as the FETs dissipate less power

## I need your help!

Most engineers who design electronics are quite comfortable using buck and boost converters for their designs. The ICs are typically easy to use and the manufactures provide lots of help to the get your project off the ground.

I would like the same to be true of IBCs, but unfortunately there is no application specific power IC to sell. So this is where open source makes sense:
- Library of free various IBC topologies which include schematics and PCB gerbers
- Library of free software code for various microcontroller
- List of suggested manufactures of transformers, FETs, gate drivers, etc.

I need people to help me out on this:
- Test this first design I have uploaded
- Incorporate this design or a modified version into your application
- Help me organize and write manageable code

![IBC PCB](/assets/IBC-PCB.png)
![IBC Schematic](/assets/IBC-SCH.png)
![IBC Prototype](/assets/IBC-Prototype.png)

>[!Note]
>Early prototype of a 5:1 with kludges. New design address the rework



