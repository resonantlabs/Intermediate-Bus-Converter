# Open Sourcing Intermediate Bus Converters for High Power Electronics

This is an Open Source Project to create a framework for seemlessly incorporating Intermediate Bus Converters (IBC) into your PCB design. 

## What are Intermediate Bus Converters (IBC)?
<img alt="Block Diagram" src="/assets/IBC-Overview.png" />
IBCs can also be called DC/DC Transformers or sometimes Isolated/Non-Isolated Non Regulated Forward Converters. I really like the name DC/DC Transformers because that's how they act. Output Voltage = Input Voltage * Ratio.

Some example:
- 4:1 Transformer, Input Voltage = 24V, Output = 6V
- 10:1 Transformer, Input Voltage = 400V, Ouput = 40V

Also remember that these are switching converters so Power In = Power Out. So if we were to add current to the above Scenarios ( and assume unity efficiency) 
- 4:1 Transformer, Input Voltage = 24V/2A, Output = 6V/8A
- 10:1 Transformer, Input Voltage = 400V/1A, Ouput = 40V/10A

That's basically it. They are straightforward devices and for some applications they are very helpful

## Why Use IBCs
- High Efficiency, up to 98%
- Low EMI
- Extermely Robust and Stable
- Fast

Let's talk about each bullet
### High Efficiency


Most engineers who design electronics are quite comfortable using buck and boost converters for their designs. The ICs are typically easy to use and the manufactures provide lots of help to the get your project off the ground. 

An example is a device that accepts 48Vin +/- 2.5V and has output rails of 12V/5A, 5V/5A, 3.3V/10A

