!(extend-py! motto)
!(extend-py! mettamorph.py)
!(compile! NARS.metta)

; This is a PoC example of MeTTa-motto-MeTTa-NARS interoperability

; We process sentences with the use of ChatGPT-based MeTTa-agent
; to put parsed statements into MeTTa-NARS
(= (Sentence $sentence)
   (let $belief (llm (Agent nars_reason.msa) (user $sentence))
        (let (AddBeliefEvent ($term $tv)) $belief ;AddBeliefEvent call for MeTTa-NARS
             (superpose ((add-atom &self (encoded (index (get-state &idx) $term)))))))) ;Keep track of what sentence was encoded as which term

; And we can transform natural language questions into question evaluations based on previous statements:
(= (Question $sentence)
   (let $res (llm (Agent nars_query.msa)
      (system "Question")
      (user (($sentence "? answer in full sentence in parenthesis using newest information?") (collapse (memory: (get-concept-terms-of-positive-temporal-beliefs))))))
      (trace! (fromLLM $res) $res)))
