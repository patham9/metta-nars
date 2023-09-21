;params
(= (AttentionalFocusConceptsMax) 10)

;spaces
!(bind! &concepts (new-space))
!(bind! &attentional_focus (new-space))

;priority of concepts
(= (ConceptPriorityNow ($T $P) $t) (* $P (/ 1 (+ 1 (- $t $T)))))

;whether evidence was just counted once
!(bind! &tempstate (new-state False))
!(bind! &tempset (new-space))
(= (StampDisjoint $x)
   (not (sequential ((do (change-state! &tempstate False))
                     (do (case (get-atoms &tempset)
                         (($y (remove-atom &tempset $y)))))
                     (do (let $z (superpose $x)
                              (case (match &tempset $z $z)
                                    (($w (change-state! &tempstate True))
                                     (%void% (add-atom &tempset $z))))))
                     (get-state &tempstate)))))
               
;revise if there is no evidential overlap, else use higher-confident candidate
(= (RevisionAndChoice (Event ($Term1 ($f1 $c1)) (eternal $ev1 $EPrio1)) (Event ($Term2 ($f2 $c2)) (eternal $ev2 $EPrio2)))
   (let $ConclusionStamp (TupleConcat $ev1 $ev2)
        (If (StampDisjoint $ConclusionStamp)
            (Event ($Term1 (Truth_Revision ($f1 $c1) ($f2 $c2))) (eternal $ConclusionStamp (0 0.0)))
            (If (> $c1 $c2)
                (Event ($Term1 ($f1 $c1)) (eternal $ev1 (0 0.0)))
                (Event ($Term2 ($f2 $c2)) (eternal $ev2 (0 0.0)))))))

;;update beliefs in existing concept with the new event or create new concept to enter the new evidence
(= (UpdateConcept $NewEvent $t)
   (let* (((Event ($Term $TV) ($Time $Evidence $EPrio)) $NewEvent)
          ($NewEventEternalized (Eternalize $NewEvent))
          ($MatchConcept (Concept $Term $Belief $BeliefEvent $CPrio)))
         (sequential ((case (match &attentional_focus $MatchConcept $MatchConcept)
                            (($MatchConcept (sequential ((remove-atom &attentional_focus $MatchConcept)
                                                         (let* (($RevisedBelief (RevisionAndChoice $Belief $NewEventEternalized))
                                                                ($MaxPrio (If (> (EventPriorityNow $EPrio $t) (ConceptPriorityNow $CPrio $t))
                                                                              $EPrio $CPrio)))
                                                         (add-atom &attentional_focus (Concept $Term $RevisedBelief $NewEvent $MaxPrio))))))
                             (%void% (case (match &concepts $MatchConcept $MatchConcept)
                                           (($MatchConcept (sequential ((remove-atom &concepts $MatchConcept)
                                                                        (add-atom &attentional_focus $MatchConcept)
                                                                        (UpdateConcept $NewEvent $t))))
                                            (%void% (add-atom &attentional_focus (Concept $Term $NewEventEternalized $NewEvent $EPrio))))))))))))

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
(: EternalQuestion (-> Expression $t))
(= (EternalQuestion $Term) (case (match (superpose (&attentional_focus &concepts)) (Concept $Term $Belief $BeliefEvent $CPrio) $Belief)
                                (($Ev $Ev) (%void% (Event (None (0.5 0.0)) (eternal Nil 0.0))))))

;get event belief of concept
(: EventQuestion (-> Expression $t))
(= (EventQuestion $Term) (case (match (superpose (&attentional_focus &concepts)) (Concept $Term $Belief $BeliefEvent $CPrio) $BeliefEvent)
                                (($Ev $Ev) (%void% (Event (None (0.5 0.0)) (0 Nil 0.0))))))
