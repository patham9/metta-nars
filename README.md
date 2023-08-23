# metta-nars
ONA-style NARS implementation in MeTTa

**The structure**

The reasoning system consists of
- [Logic]: Non-Axiomatic Logic
- [Memory]: Spaces for belief&goal events, and concept space
- [Control]:
    - Declarative (deriving events and knowledge from events)
    - Temporal (sequence and implication formation)
    - Procedural (decision making with subgoaling)

**The tests**

- tests0.metta: NAL inference rule application examples
- tests1.metta: Multistep declarative inference example
- tests2.metta: Pong-like procedure learning example
- tests3.metta: Multi-step decision making (planning) example
