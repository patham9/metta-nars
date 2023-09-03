;params
(= (BeliefEventsMax) 10)
(= (GoalEventsMax) 10)

;spaces
!(bind! &belief_events (new-space))
!(bind! &goal_events (new-space))

;states
!(bind! &currentTime (new-state 1))
!(bind! &evidentialBase (new-state 1))
(= (increment $atom) (change-state! $atom (+ 1 (get-state $atom))))
(= (UpdateReasonerState) ((increment &currentTime) (increment &evidentialBase)))
(= (GetReasonerState) ((get-state &currentTime) ((get-state &evidentialBase))))

;priority of events
(= (EventPriorityNow ($T $P) $t) (* $P (/ 1 (+ 1 (- $t $T)))))

;retrieve the best candidate (allows to use tuples / collapse results / spaces as a PQ)
!(bind! &tempbest (new-state nix))
!(bind! &tempbestscore (new-state 0))
(= (BestCandidate $tuple $evaluateCandidateFunction $t)
   (sequential ((case (change-state! &tempbestscore 0) ())
                (case (change-state! &tempbest nix) ())
                (case (let* (($x (superpose $tuple))
                             ($fx ($evaluateCandidateFunction $x $t)))
                            (superpose ((if (> $fx (get-state &tempbestscore))
                                            (sequential ((change-state! &tempbest $x)
                                                         (change-state! &tempbestscore $fx))) nop)))) ())
               (get-state &tempbest))))

;functions to select highest-priority events in belief and goal PQ
(= (PriorityOf Nil $t)  0.0)
(= (PriorityOf (Event $Sentence ($occT $Ev $Prio)) $t) (EventPriorityNow $Prio $t))
(= (SelectHighestPriorityEvent $collection $t)
   (let $Evs (collapse (match $collection $1 $1)) (BestCandidate $Evs PriorityOf $t)))

;a belief event to process, which demands adding it to the PQ and updating its concept
(= (ProcessBeliefEvent $Ev $t)
   (sequential ((add-atom &belief_events $Ev)
                (UpdateConcept $Ev $t))))

;bound the size of the attentional focus for tasks / events
(= (BoundEvents $collection $Threshold $Increment $TargetAmount $t)
   (sequential ((case (let* (($Ev (get-atoms $collection))
                       ((Event $Sentence ($Time $Evidence $EPrio)) $Ev))
                      (if (< (EventPriorityNow $EPrio $t) $Threshold)
                          (remove-atom $collection $Ev) nop)) ())
                (let $CurrentAmount (CollapseCardinality (get-atoms $collection))
                     (if (and (> $CurrentAmount $TargetAmount) (< $Threshold 1.0))
                         (BoundEvents $collection (+ $Threshold $Increment) $Increment $TargetAmount $t) nop)))))
