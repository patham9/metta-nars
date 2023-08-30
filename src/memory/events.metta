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
(= (GetReasonerState) ((get-state &currentTime) (Cons (get-state &evidentialBase) Nil)))

;priority of events
(= (EventPriorityNow ($T $P) $t) (* $P (/ 1 (+ 1 (- $t $T)))))

;retrieve the best candidate (allows to use tuples / collapse results / spaces as a PQ)
(= (BestCandidate $tuple $bestCandidate $evaluateCandidateFunction $t)
  (if (== $tuple ()) 
      $bestCandidate
      (let* (($head (car-atom $tuple))
             ($tail (cdr-atom $tuple)))
            (if (> ($evaluateCandidateFunction $head $t)
                   ($evaluateCandidateFunction $bestCandidate $t))
                (BestCandidate $tail $head $evaluateCandidateFunction $t)
                (BestCandidate $tail $bestCandidate $evaluateCandidateFunction $t)))))

;functions to select highest-priority events in belief and goal PQ
(= (PriorityOf Nil $t)  0.0)
(= (PriorityOf (Event $Sentence ($occT $Ev $Prio)) $t) (EventPriorityNow $Prio $t))
(= (SelectHighestPriorityEvent $collection $baseCandidate $t)
   (let $Evs (collapse (match $collection $1 $1)) (BestCandidate $Evs $baseCandidate PriorityOf $t)))

;a belief event to process, which demands adding it to the PQ and updating its concept
(= (ProcessBeliefEvent $Ev $t)
   (sequential ((add-atom &belief_events $Ev)
                (UpdateConcept $Ev $t))))

;bound the size of the attentional focus for tasks / events
(= (BoundEvents $collection $Threshold $Increment $TargetAmount $t)
   (sequential ((let* (($Ev (get-atoms $collection))
                       ((Event $Sentence ($Time $Evidence $EPrio)) $Ev))
                      (if (< (EventPriorityNow $EPrio $t) $Threshold)
                          (remove-atom $collection $Ev) nop))
                (let $CurrentAmount (TupleCount (collapse (get-atoms $collection)))
                     (if (and (> $CurrentAmount $TargetAmount) (< $Threshold 1.0))
                         (BoundEvents $collection (+ $Threshold $Increment) $Increment $TargetAmount $t) nop)))))
