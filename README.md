# Verilog-adders-with-synthesis-using-Oasys
Cell-based design techniques, such as standard-cells and FPGAs, together with versatile hardware 
synthesis are rudiments for a high productivity in ASIC design. In the majority of digital signal 
processing (DSP) applications the critical operations are the addition, multiplication and 
accumulation. Addition is an indispensable operation for any digital system, DSP or control 
system. Therefore a fast and accurate operation of a digital system is greatly influenced by 
the performance of the resident adders. Adders are also very significant component in 
digital systems because of their widespread use in other basic digital operations such as 
subtraction, multiplication and division. Hence, improving performance of the digital adder 
would extensively advance the execution of binary operations inside a circuit compromised of 
such blocks. Many different adder architectures for speeding up binary addition have been 
studied and proposed over the last decades. For cell-based design techniques they can be well 
characterized with respect to circuit area and speed as well as suitability for logic optimization 
and synthesis. 


This why in this mini project, we will explore different implementations of adders and
study their charachteristics.




In this repo, we implemented using verilog the following 32-bits signed integer adders:

**1- Verilog (‘+’) version of adders**

**2- Ripple Carry Adder**

**3- Carry Save Adder**

**4- Carry Look-Ahead Adder**

**5- Carry Increment adder**

**6- Carry Skip Adder**

**7- Carry Bypass Adder**

**8- Carry Select Adder**

## Ripple Carry Adder

The ripple carry adder is constructed by cascading full adders (FA) blocks in series. One full adder is responsible for the addition of two binary digits at any stage of the ripple carry. The carryout of one stage is fed directly to the carry-in of the next stage.


**One of the most serious drawbacks of this adder is that the delay increases linearly with the bit length.**

**The advantages of the RCA are lower power consumption as well as compact layout giving smaller chip area.**

**The design schematic of RCA: **

## Carary Save Adder

The carry-save adder reduces the addition of 3 numbers to the addition of 2 numbers. The 
propagation delay is 3 gates regardless of the number of bits. The carry-save unit consists of n full 
adders, each of which computes a single sum and carries bit based solely on the corresponding 
bits of the three input numbers. The entire sum can then be computed by shifting the carry 
sequence left by one place and appending a 0 to the front (most significant bit) of the partial sum 
sequence and adding this sequence with RCA produces the resulting n + 1-bit value.

**The main application of carry save algorithm is, well known for multiplier 
architecture is used for efficient CMOS implementation of much wider variety of algorithms for 
high speed digital signal processing **

**CSA applied in the partial product line of array multipliers will speed up the carry propagation in the array.**

**The design schematic of CSA: **

## Carry Look-Ahead Adder

 This adder is based on the principle of looking at the lower order bits of the augends and addend if a higher order carry is generated. This adder reduces the carry delay by 
reducing the number of gates through which a carry signal must propagate. Carry look 
ahead depends on two things: Calculating for each digit position, whether that position is going to 
propagate a carry if one comes in from the right and combining these calculated values to be able 
to deduce quickly whether, for each group of digits, that group is going to propagate a carry that 
comes in from the right. The net effect is that the carries start by propagating slowly through each 
4-bit group, just as in a ripple-carry system, but then moves 4 times faster, leaping from one 
look ahead carry unit to the next. Finally, within each group that receives a carry, the carry 
propagates slowly within the digits in that group

**his adder consists of three stages: a propagate block/ generate block, a sum generator and carry 
generator. The generate block can be realized using the expression 

 G<sub>i<sub>= A<sub>i<sub>.B<sub>i<sub>  for i=0,1,2,3 Eq (2) 
  
 Similarly the propagate block can be realized using the expression 
  
P<sub>i<sub>= A<sub>i<sub>⊕B<sub>i<sub>   for i=0,1,2,3 Eq (3) 
  
The carry output of the (i-1)th stage is obtained from 
  
 C<sub>i(Cout)<sub>= G<sub>i<sub> + P<sub>i<sub> C<sub>i-1<sub>  for i=0,1,2,3 Eq (4) 
  
 The sum output can be obtained using 
  
S<sub>i<sub>= A<sub>i<sub> ⊕ B<sub>i<sub>C<sub>i-1<sub>  for i=0,1,2,3 Eq (5) **

**Carry look-ahead adder is designed to overcome the latency introduced by the rippling effect of the carry bits**

**The propagation delay occurred in the parallel adders can be eliminated by carry look ahead adder.**

**The design schematic of 8 bit look ahead adder using two four bit look ahead block: **
