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
        (superpose ($belief
                    (let (AddBeliefEvent ($term $tv)) $belief ;AddBeliefEvent call for MeTTa-NARS
                         (add-atom &self (encoded ($sentence INPUT_TERM: $term)))))))) ;Keep track of what sentence was encoded as which term

; And we can transform natural language questions into question evaluations based on previous statements:
!(let (AddQuestion ($question $tv)) (llm (Agent nars_reason.msa)
      (system "Question")
      (user ("a cat likes the fish?" (collapse (match &self (encoded $1) $1)))))
      (trace! (Question ($question $tv)) (EternalQuestion $question)))
