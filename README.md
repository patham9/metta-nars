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

**Install**
```
git clone https://github.com/trueagi-io/metta-morph
cd metta-morph
git clone https://github.com/patham9/metta-nars
```

**Run a reasoning example with the Scheme interpreter**
```
cd metta-nars
sh run_scheme.sh ./tests/test<X>.metta
```
This is very useful for developing, as it does not involve lengthy compilation and allows to automatically input information into NARS according to the contens of the MeTTa file.

**Run interactive NARS shell with Scheme compiler or interpreter**

To have an interactive shell to interact with NARS, the best way is to let MeTTa-Morph compile it to a binary and to then run that binary, which can be done with
```
cd metta-nars
sh run_scheme_repl_compiled.sh
```
This leads to a significantly faster system than interpreted, but can take minutes to compile on first invocation, next invocations will be fast since compiling the same code again is avoided. 

Due to the slow compile time after code changes, for developers who work on MeTTa-NARS code iteratively, the recommended option hence is to run the system with the Scheme interpreter after letting MeTTa-Morph translate it to Scheme, which can be done with:
```
cd metta-nars
sh run_scheme_repl_interpreted.sh
```

The input these repls allow is to call a function with arguments, such as to send events to the reasoning system as in the test files. These are not full MeTTa REPLs!

**Run with the MeTTa interpreter**

As indicated by the MeTTa version of the above scripts (run_metta.sh and run_metta_repl.sh), it is also still possible to run MeTTa-NARS with the MeTTa interpreter. However this is slow and thus, except for the purpose of checking for potential MeTTa compatibility issues between the MeTTa interpreter and MeTTa-morph, not recommended. The last version of MeTTa-NARS which was trimmed down to be reasonably fast with the MeTTa interpreter can be found in the before-metta-morph branch:
https://github.com/patham9/metta-nars/tree/before-metta-morph
