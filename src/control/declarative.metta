;;Declarative inference (deriving events and knowledge from observed events)

;Derived belief event priority
(= (ConclusionPriority $EPrio $CPrio $ConcTV) (* (* $EPrio $CPrio) (Truth_Expectation $ConcTV)))

;making declarative inferences on two events (task from PQ and belief from concept)
(= (Conclude ('Event $S1 ($time1 $ev1 $prio1)) ('Event $S2 ($time2 $ev2 $prio2)) $CPrio $t)
   (let $ConclusionStamp (TupleConcat $ev1 $ev2)
        (If (StampDisjoint $ConclusionStamp)
            (let ($ConcTerm $ConcTV) (superpose ((|- $S1 $S2) (|- $S2 $S1)))
                 ('Event ($ConcTerm $ConcTV)
                         ($time1 $ConclusionStamp
                                 ($t (ConclusionPriority (EventPriorityNow $prio1 $t)
                                                         (ConceptPriorityNow $CPrio $t)
                                                         $ConcTV))))))))

;find a belief for the task to generate conclusions with
(= (ReasonWithTask ('Event $S1 ($time1 $ev1 $prio1)) $t) 
   (let ($Belief $CPrio) (case (get-atoms '&attentional_focus)
                               ((('Concept $Term ('Event $SE2 ($timeE2 $evE2 $prioE2)) ('Event $S2 ($time2 $ev2 $prio2)) $CPrio)
                                 (If (and (not (== $time1 eternal)) (> (abs (- $time1 $time2)) 20))
                                     (('Event $SE2 ($timeE2 $evE2 $prioE2)) $Cprio)
                                     (('Event $S2 ($time2 $ev2 $prio2)) $CPrio)))))
        (case (Conclude ('Event $S1 ($time1 $ev1 $prio1)) (TemporallyAlignedBelief $time1 $Belief) $CPrio $t)
              ((('Event $1 $2) (ProcessBeliefEvent ('Event (trace! ('pt $1) $1) $2) $t))))))

;select the highest priority belief event from the PQ and use it for reasoning
(= (BeliefCycle $t) (do (sequential ((let $Ev (SelectHighestPriorityEvent '&belief_events $t)
                                          (sequential ((remove-atom '&belief_events $Ev)
                                                       (ReasonWithTask $Ev $t))))
                                     (UpdateReasonerState)
                                     (BoundEvents '&belief_events 0.0 0.1 (BeliefEventsMax 'dummy) $t)
                                     (BoundAttention 0.0 0.1 (AttentionalFocusConceptsMax) $t)))))
