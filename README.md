# metta-nars
ONA-style NARS implementation in MeTTa

**The structure**

The reasoning system consists of
- [Logic]: Non-Axiomatic Logic
- [Memory]: Spaces for belief&goal events, and concepts
- [Control]:
    - Declarative (deriving events and knowledge from events)
    - Temporal (sequence and implication formation)
    - Procedural (decision making with subgoaling)
 
In terms of inference control flow, this implementation follows the same structure as ![ONA](https://github.com/opennars/OpenNARS-for-Applications):

![ONA v0.9.x overview diagram](https://user-images.githubusercontent.com/8284677/181041442-f497e4b6-5abe-43ac-8ba7-e75152a6b51f.png)


**The tests**

- tests0.metta: NAL inference rule application examples
- tests1.metta: Multistep declarative inference example
- tests2.metta: Pong-like procedure learning example
- tests3.metta: Multi-step decision making (planning) example
