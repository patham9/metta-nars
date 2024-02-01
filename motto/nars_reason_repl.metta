!(extend-py! motto)
!(extend-py! mettamorph.py)
!(compile! NARS.metta)

; This is a PoC example of MeTTa-motto-MeTTa-NARS interoperability

; We process sentences with the use of ChatGPT-based MeTTa-agent
; to put parsed statements into MeTTa-NARS
(= (Sentence $sentence)
   (let $belief (llm (Agent nars_reason.msa) (user $sentence))
        (superpose ($belief
                    (let (AddBeliefEvent ($term $tv)) $belief ;AddBeliefEvent call for MeTTa-NARS
                         (add-atom &self (encoded ($sentence INPUT_TERM: $term)))))))) ;Keep track of what sentence was encoded as which term

; And we can transform natural language questions into question evaluations based on previous statements:
(= (Question $sentence)
   (let (AddQuestion ($question $tv)) (llm (Agent nars_reason.msa)
      (system "Question")
      (user ($sentence (collapse (match &self (encoded $1) $1)))))
      (trace! (AddQuestion ($question $tv)) (EternalQuestion $question))))
