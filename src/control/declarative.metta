;;Declarative inference (deriving events and knowledge from observed events)

;Derived belief event priority
(= (ConclusionPriority $EPrio $CPrio $ConcTV) (* (* $EPrio $CPrio) (Truth_Expectation $ConcTV)))

;making declarative inferences on two events (task from PQ and belief from concept)
(= (Conclude (Event $S1 ($time1 $ev1 $prio1)) (Event $S2 ($time2 $ev2 $prio2)) $CPrio $t)
   (let $ConclusionStamp (ListConcat $ev1 $ev2) 
        (if (and (not (== $S1 $S2)) (not (StampOverlap $ConclusionStamp)))
            (let ($ConcTerm $ConcTV) (superpose ((|- $S1 $S2) (|- $S2 $S1)))
                 (conclusion (Event ($ConcTerm $ConcTV) 
                                    ($time1 $ConclusionStamp ($t (ConclusionPriority (EventPriorityNow $prio1 $t) (ConceptPriorityNow $CPrio $t) $ConcTV))))))
            nop)))

;find a belief for the task to generate conclusions with
(= (ReasonWithTask (Event $S1 ($time1 $ev1 $prio1)) $t) 
   (let ($Belief $CPrio) (case (get-atoms &attentional_focus)
                               (((Concept $Term (Event $SE2 ($timeE2 $evE2 $prioE2)) (Event $S2 ($time2 $ev2 $prio2)) $CPrio)
                                 (if (and (not (== $time1 eternal)) (> (abs (- $time1 $time2)) 20))
                                     ((Event $SE2 ($timeE2 $evE2 $prioE2)) $Cprio)
                                     ((Event $S2 ($time2 $ev2 $prio2)) $CPrio)))))
        (case (Conclude (Event $S1 ($time1 $ev1 $prio1)) (TemporallyAlignedBelief $time1 $Belief) $CPrio $t)
              (((conclusion $1) (ProcessBeliefEvent $1 $t))))))

;select the highest priority belief event from the PQ and use it for reasoning
(= (BeliefCycle $t) (sequential ((let $Ev (SelectHighestPriorityEvent &belief_events Nil $t)
                                      (sequential ((remove-atom &belief_events $Ev)
                                      (ReasonWithTask $Ev $t))))
                                 (UpdateReasonerState)
                                 (if (> $t 1) (BoundEvents &belief_events 0.0 0.1 (BeliefEventsMax) $t) nop)
                                 (if (> $t 1) (BoundAttention 0.0 0.1 (AttentionalFocusConceptsMax) $t) nop))))