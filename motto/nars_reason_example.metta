!(extend-py! motto)
!(extend-py! mettamorph.py)
!(compile! NARS.metta)

; This is a PoC example of MeTTa-motto-MeTTa-NARS interoperability

; Here, we have a set of statements in natural language
(Sentence "sam is a cat")
(Sentence "sam likes the fish")
(Sentence "fish are animals")

; And we process them with the use of ChatGPT-based MeTTa-agent
; to put parsed statements into MeTTa-NARS
!(match &self (Sentence $sentence)
   (let $belief (llm (Agent nars_reason.msa) (user $sentence))
        (let (AddBeliefEvent ($term $tv)) $belief ;AddBeliefEvent call for MeTTa-NARS
             (superpose ((add-atom &self (encoded (index (get-state &idx) $term)))))))) ;Keep track of encoded terms

; And we can transform natural language questions into question evaluations based on previous statements:
!(let $res (llm (Agent nars_query.msa)
      (system "Question")
      (user ("sam likes animals?" (collapse (memory: (get-concept-terms-of-positive-beliefs))))))
      (trace! (fromLLM $res) $res))
