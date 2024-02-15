;; stdlib extension
(= (TupleConcat $Ev1 $Ev2) (collapse (superpose ((superpose $Ev1) (superpose $Ev2)))))
(= (TupleCount $tuple) (If (== $tuple ()) 0 (+ 1 (TupleCount (cdr-atom $tuple)))))
(: CountElement (-> Expression Number))
(= (CountElement $x) (case $x (($y 1))))
;; Useful interop functions for querying when MeTTa-NARS is compiled as a library to be used via Mettamorph
(= (add-morph-atom $space $entry) (add-atom $space $entry))
(= (get-morph-atoms $space) (get-atoms $space))
(= (get-concept-terms) (match (superpose (&attentional_focus &concepts)) (Concept $TermX $Belief $BeliefEvent $CPrio) $TermX))
(= (get-concept-beliefs) (match (superpose (&attentional_focus &concepts)) (Concept $TermX $Belief $BeliefEvent $CPrio) $Belief))
(= (get-concept-terms-of-positive-beliefs) (match (superpose (&attentional_focus &concepts)) (Concept $TermX (Event ($term ($f $c)) ($occT $Ev $Prio)) $BeliefEvent $CPrio) 
   (If (> $f 0.5) ($term (truth: ($f $c))))))
(= (get-concept-terms-of-positive-temporal-beliefs) (match (superpose (&attentional_focus &concepts)) (Concept $TermX $EternalEvent (Event ($term ($f $c)) ($occT $Ev $Prio)) $CPrio) 
   (If (> $f 0.5) ($term (time: $occT) (truth: ($f $c))))))
