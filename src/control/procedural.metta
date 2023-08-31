;;Procedural inference (decision making with operation execution and subgoaling)

;the last operation execution the system has performed
!(bind! &execution (new-state None))

;Derived goal event priority
(= (SubgoalPriority $EPrio $ConcTV) (* $EPrio (Truth_Expectation $ConcTV)))

;Expectation of an operation is the truth expectation of its desire value
(= (OpExpectation Nil $t) 0.0)
(= (OpExpectation (Decision ($Opname $DVOp) $Subgoal) $t) (Truth_Expectation $DVOp))

;Execute an operation, also injecting it as an event
(= (Execute $Opname)
    (sequential ((change-state! &execution $Opname)
                 (AddBeliefEvent ($Opname (1.0 0.9))))))

;Add subgoals to the PQ
(= (DeriveSubgoals $Options)
   (let (Decision $Op $Subgoal) (superpose $Options)
        (add-atom &goal_events $Subgoal)))

;execute the operation which most likely gets the goal achieved in current contexts, and if contexts are not yet fulfilled, derive them as subgoals
(= (BestDecision $t (Event ($Term $DV) ($GoalTime $GoalEvBase $GoalPrio)) $FIFO)
   (let $Options (collapse (let* (((Event ((($Prec &/ (^ $Op)) =/> $Term) $ImpTV) ($ImpTime $ImpEvBase $ImpPrio))
                                   (EternalQuestion (($Prec &/ (^ $Op)) =/> $Term)))
                                  ($DVPrecOp (Truth_Deduction $DV $ImpTV))
                                  ((Event ($PrecTerm $PrecTV) $PrecMetadata)
                                   (Projection (EventQuestion $Prec) $t))
                                  ($DVOp (Truth_Deduction $PrecTV $DVPrecOp))
                                  ($DVPrec (Truth_StructuralDeduction $DVPrecOp))
                                  ($SubgoalStamp (TupleConcat $GoalEvBase $ImpEvBase)))
                                 (if (StampDisjoint $SubgoalStamp)
                                     (Decision ((^ $Op) $DVOp) (Event ($Prec (Truth_StructuralDeduction $DVPrecOp))
                                                                      ($t $SubgoalStamp ($t (SubgoalPriority (EventPriorityNow $GoalPrio $t) $DVPrec)))))
                                     nop)))
        (let (Decision ($Opname $DVOp) $Subgoal) (BestCandidate $Options (Decision (NoDecision (1.0 0.0)) subgoal) OpExpectation $t)
             (if (> (Truth_Expectation $DVOp) 0.5)
                 (Execute $Opname)
                 (DeriveSubgoals $Options)))))

;;select the highest priority goal event from the PQ and use it for decision making
(= (GoalCycle $t) (sequential ((let $Ev (SelectHighestPriorityEvent &goal_events Nil $t)
                                    (sequential ((remove-atom &goal_events $Ev)
                                                 (BestDecision $t $Ev (get-state &FIFO)))))
                               (UpdateReasonerState)
                               (if (> $t 1) (BoundEvents &goal_events 0.0 0.1 (GoalEventsMax) $t) nop))))

;;Input procedure
(= (AddGoalEvent $Sentence)
   (let* ((($t $evidentialBase) (GetReasonerState))
          ($InputEvent (Event $Sentence ($t $evidentialBase ($t 1.0)))))
         (sequential ((change-state! &execution None)
                      (add-atom &goal_events $InputEvent)
                      (GoalCycle $t)))))
