;params
(= (AttentionalFocusConceptsMax dummy) 10)

;spaces
!(bind! &concepts (new-space))
!(bind! &attentional_focus (new-space))

;priority of concepts
(= (ConceptPriorityNow ($T $P) $t) (* $P (/ 1 (+ 1 (- $t $T)))))

;Whether evidence was just counted once
(= (StampDisjoint $Ev1 $Ev2)
   (If (or (== $Ev1 ()) (== $Ev2 ())) ;check only needed due to a bug in the MeTTa interpreter
       True                           ;https://github.com/trueagi-io/hyperon-experimental/issues/481
       (== () (collapse (let* (($x (superpose $Ev1))
                               ($y (superpose $Ev2)))
                              (case (== $x $y) ((True overlap))))))))

;revise if there is no evidential overlap, else use higher-confident candidate
(= (RevisionAndChoice (Event ($Term1 ($f1 $c1)) (eternal $ev1 $EPrio1)) (Event ($Term2 ($f2 $c2)) (eternal $ev2 $EPrio2)))
   (let $ConclusionStamp (TupleConcat $ev1 $ev2)
        (If (StampDisjoint $ev1 $ev2)
            (Event ($Term1 (Truth_Revision ($f1 $c1) ($f2 $c2))) (eternal  $ConclusionStamp (0 0.0)))
            (If (> $c1 $c2)
                (Event ($Term1 ($f1 $c1)) (eternal $ev1 (0 0.0)))
                (Event ($Term2 ($f2 $c2)) (eternal $ev2 (0 0.0)))))))

;update beliefs in existing concept with the new event or create new concept to enter the new evidence
(= (UpdateConcept $NewEvent $t)
   (let* (((Event ($Term $TV) ($Time $Evidence $EPrio)) $NewEvent)
          ($NewEventEternalized (Eternalize $NewEvent)))
                      (case (match &attentional_focus (Concept $TermX $Belief $BeliefEvent $CPrio) 
                                                       (If (== $TermX $Term) (Concept $TermX $Belief $BeliefEvent $CPrio)))
                            (((Concept $TermX $Belief $BeliefEvent $CPrio) (sequential ((remove-atom &attentional_focus (Concept $TermX $Belief $BeliefEvent $CPrio))
                                                                                         (let* (((Event $RevSentence $Metadata) (RevisionAndChoice $Belief $NewEventEternalized))
                                                                                                ($RevisedBelief (Event (trace! (@ $RevSentence) $RevSentence) $Metadata))
                                                                                                ($MaxPrio (If (> (EventPriorityNow $EPrio $t) (ConceptPriorityNow $CPrio $t))
                                                                                                              $EPrio $CPrio)))
                                                                                               (add-atom &attentional_focus (Concept $Term $RevisedBelief $NewEvent $MaxPrio))))))
                             (%void% (case (match &concepts (Concept $TermX2 $Belief2 $BeliefEvent2 $CPrio2)
                                           (If (== $TermX2 $Term) (Concept $TermX2 $Belief2 $BeliefEvent2 $CPrio2)))
                                               (((Concept $TermX2 $Belief2 $BeliefEvent2 $CPrio2) (sequential ((remove-atom &concepts (Concept $TermX2 $Belief2 $BeliefEvent2 $CPrio2))
                                                                                                                (add-atom &attentional_focus (Concept $TermX2 $Belief2 $BeliefEvent2 $CPrio2))
                                                                                                                (UpdateConcept $NewEvent $t))))
                                               (%void% (sequential ((add-atom &attentional_focus (Concept $Term $NewEventEternalized $NewEvent $EPrio))))))))))))

;bound the size of attentional focus of concepts
(= (BoundAttention $Threshold $Increment $TargetAmount $t)
   (sequential ((do (let* (($C (get-atoms &attentional_focus))
                           ((Concept $Term (Event $Sentence $Metadata) $BeliefEvent $CPrio) $C))
                          (If (< (ConceptPriorityNow $CPrio $t) $Threshold) (sequential ((remove-atom &attentional_focus $C)
                                                                                         (add-atom &concepts $C))))))
                (let $CurrentAmount (CollapseCardinality (get-atoms &attentional_focus))
                     (If (> $CurrentAmount $TargetAmount)
                         (BoundAttention (+ $Threshold $Increment) $Increment $TargetAmount $t))))))

;get eternal belief of concept
(: EternalQuestion (-> Expression %Undefined%))
(= (EternalQuestion $Term) (case (match (superpose (&attentional_focus &concepts)) (Concept $TermX $Belief $BeliefEvent $CPrio) (If (== $Term $TermX) $Belief))
                                 (($Ev $Ev) (%void% (Event (None (0.5 0.0)) (eternal () 0.0))))))

(: HowAchieveQuestion (-> Expression %Undefined%))
(= (HowAchieveQuestion $Cons) (case (match (superpose (&attentional_focus &concepts)) (Concept (($Prec &/ (^ $Op)) =/> $ConsX) $Belief $BeliefEvent $CPrio) (If (== $Cons $ConsX) $Belief))
                                    (($Ev $Ev) (%void% (Event (None (0.5 0.0)) (eternal () 0.0))))))

(: WhatWillHappenQuestion (-> Expression %Undefined%))
(= (WhatWillHappenQuestion $Prec) (case (match (superpose (&attentional_focus &concepts)) (Concept ($PrecX =/> $Cons) $Belief $BeliefEvent $CPrio) (If (== $Prec $PrecX) $Belief))
                                    (($Ev $Ev) (%void% (Event (None (0.5 0.0)) (eternal () 0.0))))))


;get event belief of concept
(: EventQuestion (-> Expression %Undefined%))
(= (EventQuestion $Term) (case (match (superpose (&attentional_focus &concepts)) (Concept $TermX $Belief $BeliefEvent $CPrio) (If (== $TermX $Term) $BeliefEvent))
                               (($Ev $Ev) (%void% (Event (None (0.5 0.0)) (0 () 0.0))))))
