!(extend-py! metta-morph)
!(compile! NARS.metta)
!(extend-py! motto)

; This is a PoC example of MeTTa-motto-MeTTa-NARS interoperability

; Here, we have a set of statements in natural language
(Sentence "sam is a cat")
(Sentence "sam likes fish")
(Sentence "fish are animals")

; And we process them with the use of ChatGPT-based MeTTa-agent
; to put parsed statements into MeTTa-NARS
!(match &self (Sentence $sentence)
   (let $belief (llm (Agent ./../nars_reason.msa) (user $sentence))
        (superpose ((trace! $belief $belief)
                    (let (AddBeliefEvent ($term $tv)) $belief ;AddBeliefEvent call for MeTTa-NARS
                         (add-atom &self (encoded ($sentence INPUT_TERM: $term)))))))) ;Keep track of what sentence was encoded as which term

; And we can transform natural language questions into question evaluations based on previous statements:
!(let (EternalQuestion ($question $tv)) (llm (Agent ./../nars_reason.msa)
      (system "Question")
      (user ("Is Sam a cat?" (collapse (match &self (encoded $1) $1)))))
      (trace! (EternalQuestion $question) (EternalQuestion $question)))
