;params
(= (AttentionalFocusConceptsMax) 10)

;spaces
!(bind! '&concepts (new-space))
!(bind! '&attentional_focus (new-space))

;priority of concepts
(= (ConceptPriorityNow ($T $P) $t) (* $P (/ 1 (+ 1 (- $t $T)))))

;whether evidence was just counted once
;!(bind! '&tempstate (new-state False))
;!(bind! '&tempset (new-space))
;(= (StampDisjoint $x)
;   (sequential (not (sequential ((do (change-state! '&tempstate False))
;                     (do (case (get-atoms '&tempset)
;                         (($y (remove-atom '&tempset $y)))))
;                     (do (let $z (superpose $x)
;                              (case (match '&tempset $z $z)
;                                    (($w (change-state! '&tempstate True))
;                                     (%void% (add-atom '&tempset $z))))))
;                     (get-state '&tempstate))))))

;Whether evidence was just counted once
(= (StampDisjoint $Ev1 $Ev2)
   (== () (collapse (let* (($x (superpose $Ev1))
                           ($y (superpose $Ev2)))
                          (case (== $x $y) ((True 'overlap)))))))

;revise if there is no evidential overlap, else use higher-confident candidate
(= (RevisionAndChoice ('Event ($Term1 ($f1 $c1)) ('eternal $ev1 $EPrio1)) ('Event ($Term2 ($f2 $c2)) ('eternal $ev2 $EPrio2)))
   (let $ConclusionStamp (TupleConcat $ev1 $ev2)
        (If (StampDisjoint $ev1 $ev2) ;True ;(StampDisjoint $ConclusionStamp)
            ('Event ($Term1 (Truth_Revision ($f1 $c1) ($f2 $c2))) ('eternal  $ConclusionStamp (0 0.0)))
            (If (> $c1 $c2)
                ('Event ($Term1 ($f1 $c1)) ('eternal $ev1 (0 0.0)))
                ('Event ($Term2 ($f2 $c2)) ('eternal $ev2 (0 0.0)))))))

;update beliefs in existing concept with the new event or create new concept to enter the new evidence
(= (UpdateConcept $NewEvent $t)
   (let* ((('Event ($Term $TV) ($Time $Evidence $EPrio)) $NewEvent)
          ($NewEventEternalized (Eternalize (trace! $NewEvent $NewEvent))))
        ; (sequential (;(display $NewEvent)
                      (case (match '&attentional_focus ('Concept $TermX $Belief $BeliefEvent $CPrio) 
                                                       (If (== $TermX $Term) ('Concept $TermX $Belief $BeliefEvent $CPrio)))
                            ((('Concept $TermX $Belief $BeliefEvent $CPrio) (sequential ((display "CONCEPT MATCHED!")
                                                         (remove-atom '&attentional_focus ('Concept $TermX $Belief $BeliefEvent $CPrio))
                                                         (display "REVISED111") (display $BeliefEvent)
                                                         (let* ((('Event $RevSentence $Metadata) (RevisionAndChoice $Belief $NewEventEternalized))
                                                                ($RevisedBelief ('Event $RevSentence $Metadata))
                                                                ($MaxPrio (If (> (EventPriorityNow $EPrio $t) (ConceptPriorityNow $CPrio $t))
                                                                              $EPrio $CPrio)))
                                                         (sequential (
                                                          (display "REVISED!!!!") 
                                                          (add-atom '&attentional_focus ('Concept $Term $RevisedBelief $NewEvent $MaxPrio))))
                                                         ))
                                                         ))
                             (%void% (sequential ( ;(display "NO MATCH IN CONCEPTS")
                                            (case (match '&concepts ('Concept $TermX2 $Belief2 $BeliefEvent2 $CPrio2)
                                                             (If (== $TermX2 $Term) ('Concept $TermX2 $Belief2 $BeliefEvent2 $CPrio2)))
                                           ((('Concept $TermX2 $Belief2 $BeliefEvent2 $CPrio2) (sequential (;(display "LTM Match")
                                                                        (remove-atom '&concepts ('Concept $TermX2 $Belief2 $BeliefEvent2 $CPrio2))
                                                                        (add-atom '&attentional_focus ('Concept $TermX2 $Belief2 $BeliefEvent2 $CPrio2))
                                                                        (UpdateConcept $NewEvent $t))))
                                            (%void% (sequential (
                                                ;(display "added to AF;;;;")
                                                (add-atom '&attentional_focus ('Concept $Term $NewEventEternalized $NewEvent $EPrio))))))))))))));))

;bound the size of attentional focus of concepts
(= (BoundAttention $Threshold $Increment $TargetAmount $t)
   (sequential ((do (let* (($C (get-atoms '&attentional_focus))
                           (('Concept $Term ('Event $Sentence $Metadata) $BeliefEvent $CPrio) $C))
                          (If (< (ConceptPriorityNow $CPrio $t) $Threshold) (sequential ((remove-atom '&attentional_focus $C)
                                                                                         (add-atom '&concepts $C))))))
                (let $CurrentAmount (CollapseCardinality (get-atoms '&attentional_focus))
                     (If (> $CurrentAmount $TargetAmount)
                         (BoundAttention (+ $Threshold $Increment) $Increment $TargetAmount $t))))))

;get eternal belief of concept
(: EternalQuestion (-> Expression $t))
(= (EternalQuestion $Term) (case (match (superpose ('&attentional_focus '&concepts)) ('Concept $Term $Belief $BeliefEvent $CPrio) $Belief)
                                 (($Ev $Ev) (%void% ('Event (None (0.5 0.0)) ('eternal () 0.0))))))

;get event belief of concept
(: EventQuestion (-> Expression $t))
(= (EventQuestion $Term) (case (match (superpose ('&attentional_focus '&concepts)) ('Concept $Term $Belief $BeliefEvent $CPrio) $BeliefEvent)
                               (($Ev $Ev) (%void% ('Event (None (0.5 0.0)) (0 () 0.0))))))
