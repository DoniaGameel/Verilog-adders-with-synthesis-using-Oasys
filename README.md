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

## Ripple Carry Adder (RCA)

The ripple carry adder is constructed by cascading full adders (FA) blocks in series. One full adder is responsible for the addition of two binary digits at any stage of the ripple carry. The carryout of one stage is fed directly to the carry-in of the next stage.


**One of the most serious drawbacks of this adder is that the delay increases linearly with the bit length.**

**The advantages of the RCA are lower power consumption as well as compact layout giving smaller chip area.**

**The design schematic of RCA:**

## Carary Save Adder (CSA)

The carry-save adder reduces the addition of 3 numbers to the addition of 2 numbers. The 
propagation delay is 3 gates regardless of the number of bits. The carry-save unit consists of n full 
adders, each of which computes a single sum and carries bit based solely on the corresponding 
bits of the three input numbers. The entire sum can then be computed by shifting the carry 
sequence left by one place and appending a 0 to the front (most significant bit) of the partial sum 
sequence and adding this sequence with RCA produces the resulting n + 1-bit value.

**The main application of carry save algorithm is, well known for multiplier 
architecture is used for efficient CMOS implementation of much wider variety of algorithms for 
high speed digital signal processing**

**CSA applied in the partial product line of array multipliers will speed up the carry propagation in the array.**

**The design schematic of CSA:**

## Carry Look-Ahead Adder (CLA)

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
generator. The generate block can be realized using the expression** 

 G<sub>i</sub>= A<sub>i</sub>.B<sub>i</sub>  for i=0,1,2,3 Eq (2) 
  
 Similarly the propagate block can be realized using the expression 
  
P<sub>i</sub>= A<sub>i</sub>⊕B<sub>i</sub>   for i=0,1,2,3 Eq (3) 
  
The carry output of the (i-1)th stage is obtained from 
  
 C<sub>i(Cout)</sub>= G<sub>i</sub> + P<sub>i</sub> C<sub>i-1</sub>  for i=0,1,2,3 Eq (4) 
  
 The sum output can be obtained using 
  
S<sub>i</sub>= A<sub>i</sub> ⊕ B<sub>i</sub>C<sub>i-1</sub>  for i=0,1,2,3 Eq (5) **

**Carry look-ahead adder is designed to overcome the latency introduced by the rippling effect of the carry bits**

**The propagation delay occurred in the parallel adders can be eliminated by carry look ahead adder.**

**The design schematic of 8 bit look ahead adder using two four bit look ahead block:**

## Carry Increment Adder (CIA)

An 8-bit increment adder includes two RCA (Ripple carry adder) of four bit each. The first ripple 
carry adder adds a desired number of first 4-bit inputs generating a plurality of partitioned sum 
and partitioned carry. Now the carry out of the first block RCA is given to CIN of the conditional 
increment block. Thus the first four bit sum is directly taken from the ripple carry output. The 
second RCA block regardless of the first RCA output will carry out the addition operation and 
will give out results which are fed to the conditional increment block. The input CIN to the first 
RCA block is given always low value. The conditional increment block consists of half adders. 
Based on the value of cout of the 1st RCA block, the increment operation will take place. Here 
the half adder in carry increment block performs the increment operation. Hence the output sum 
of the second RCA is taken through the carry increment block.

**The design schematic of Carry Increment Adder:**

## Carry Skip Adder (CSkA)

A carry-skip adder consists of a simple ripple carry-adder with a special speed up carry chain called a skip chain. A carry-skip adder is 
designed to speed up a wide adder by aiding the propagation of a carry bit around a portion of the 
entire adder. Actually the ripple carry adder is faster for small values of N. The crossover point between the 
ripple-carry adder and the carry skip adder is dependent on technology considerations and is 
normally situated 4 to 8 bits. The carry-skip circuitry consists of two logic gates. The AND gate 
accepts the carry-in bit and compares it to the group propagate signal 

**Carry skip adder is a fast adder compared to ripple carry adder when addition of large number of bits take place**

**carry skip adder has O(√n) delay provides a good compromise in terms of delay, along with a simple and regular layout**

**p<sub>[i,i+3]</sub>=p<sub>i+3</sub>.p<sub>i+2</sub>.p<sub>i+1</sub>   Eq (6)** 

**using the individual propagate values. The output from the AND gate is ORed with cout of RCA 
to produce a stage output of**

**p<sub>[i,i+3]</sub>=p<sub>i+3</sub>.p<sub>i+2</sub>.p<sub>i+1</sub>   Eq (6)** 
**carry = c<sub>i+4</sub> + p<sub>[i,i+3]</sub>.c<sub>i</sub> Eq (7) 

**If p<sub>[i,i+3]</sub> =0, then the carry-out of the group is determined by the value of c<sub>i+4</sub>.**

**However, if 
p<sub>[i,i+3]</sub>=1 when the carry-in bit is c<sub>i</sub> =1, then the group carry-in is automatically sent to the next 
group of adders.**
