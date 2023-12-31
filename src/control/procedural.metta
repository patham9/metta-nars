;;Procedural inference (decision making with operation execution and subgoaling)

;Derived goal event priority
(= (SubgoalPriority $EPrio $ConcTV) (* $EPrio (Truth_Expectation $ConcTV)))

;Expectation of an operation is the truth expectation of its desire value
(= (OpExpectation (Decision ($Opname $DVOp) $Subgoal) $t) (Truth_Expectation $DVOp))

;Inject executed operation as an event and return its name
(= (Execute $Opname) (superpose ((AddBeliefEvent ($Opname (1.0 0.9))) $Opname)))

;Add subgoals to the PQ
(= (DeriveSubgoals $Options)
   (do (let (Decision $Op (Event $S $Metadata)) (superpose $Options)
            (let $Subgoal (Event (trace! (!: $S) $S) $Metadata)
                 (add-atom &goal_events $Subgoal)))))

;execute the operation which most likely gets the goal achieved in current contexts, and if contexts are not yet fulfilled, derive them as subgoals
(= (BestDecision $t (Event ($Term $DV) ($GoalTime $GoalEvBase $GoalPrio)))
   (let $Options (collapse (let* (((Event ((($Prec &/ (^ $Op)) =/> $Term) $ImpTV) ($ImpTime $ImpEvBase $ImpPrio))
                                   (HowAchieveQuestion $Term))
                                  ($DVPrecOp (Truth_Deduction $DV $ImpTV))
                                  ((Event ($PrecTerm $PrecTV) $PrecMetadata)
                                   (Projection (EventQuestion $Prec) $t))
                                  ($DVOp (Truth_Deduction $PrecTV $DVPrecOp))
                                  ($DVPrec (Truth_StructuralDeduction $DVPrecOp))
                                  ($SubgoalStamp (TupleConcat $GoalEvBase $ImpEvBase))
                                  ($SubgoalPrio (SubgoalPriority (EventPriorityNow $GoalPrio $t) $DVPrec)))
                                 (If (StampDisjoint $GoalEvBase $ImpEvBase)
                                     (Decision ((^ $Op) $DVOp) (Event ($Prec $DVPrec)
                                                                      ($t $SubgoalStamp ($t $SubgoalPrio)))))))
        (let (Decision ($Opname $DVOp) $Subgoal) (BestCandidate $Options OpExpectation $t)
             (If (> (Truth_Expectation $DVOp) 0.5)
                 (Execute $Opname)
                 (DeriveSubgoals $Options)))))

;select the highest priority goal event from the PQ and use it for decision making
(= (GoalCycle $t) (sequential ((let $Ev (SelectHighestPriorityEvent &goal_events $t)
                                    (sequential ((do (remove-atom &goal_events $Ev))
                                                 (BestDecision $t $Ev))))
                               (do (UpdateReasonerState))
                               (do (BoundEvents &goal_events 0.0 0.1 (GoalEventsMax) $t)))))

;Input procedure
(= (AddGoalEvent $Sentence)
   (let* ((($t $evidentialBase) (GetReasonerState))
          ($InputEvent (Event (trace! (!: $Sentence) $Sentence) ($t $evidentialBase ($t 1.0)))))
         (sequential ((do (add-atom &goal_events $InputEvent))
                      (GoalCycle $t)))))
