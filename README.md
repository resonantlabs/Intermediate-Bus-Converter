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
4. LC Filter. These are typically small valued who purpose is to smooth out any switching noise

[!NOTE]
See if you can identify all the components in the schematic of a 5:1 IBC. [IBC-Schematic](/PCB/IBC-Schematic.PDF)

## Why Use IBCs
1. High Efficiency, up to 98%
2. Low EMI
3. Extermely Robust and Stable
4. Minimal Software Intervention

Let's talk about each bullet
### High Efficiency


<!-- Most engineers who design electronics are quite comfortable using buck and boost converters for their designs. The ICs are typically easy to use and the manufactures provide lots of help to the get your project off the ground. 

An example is a device that accepts 48Vin +/- 2.5V and has output rails of 12V/5A, 5V/5A, 3.3V/10A -->

