;;Temporal inference (sequence and implication formation based on FIFO)

;use the event's evidence to induce a time-independent belief which can be used in the future
(= (Eternalize $Ev) (let (Event ($Term $TV) ($Time $Evidence $EPrio)) $Ev
                         (If (== $Time eternal) $Ev
                         (Event ($Term (Truth_Eternalize $TV)) (eternal $Evidence (0 0.0))))))

;use evidence of an event at a slightly different moment in time
(= (Projection (Event ($Term ($f $c)) ($Time $Evidence $EPrio)) $TargetTime)
   (Event ($Term ($f (* $c (min 1 (/ 1 (abs (- $Time $TargetTime))))))) ($TargetTime $Evidence $EPrio)))

;make the belief occurrence time compatible with the task's
(= (TemporallyAlignedBelief $TaskTime $Belief) (If (== $TaskTime eternal)
                                                   (Eternalize $Belief)
                                                   (Projection $Belief $TaskTime)))

;FIFO max. size bound
!(bind! &FIFO (new-state Nil))
(= (ListFirstK $C Nil) Nil)
(= (ListFirstK $C (Cons $LH $LT))
   (If (> $C 0)
       (Cons $LH (ListFirstK (- $C 1) $LT))
       Nil))

;Add event to FIFO
(= (EventToFIFO $Ev)
   (let $newlist (ListFirstK 3 (Cons $Ev (get-state &FIFO)))
        (change-state! &FIFO $newlist)))

;Form a sequence of two events
(= (TemporalSequence $Ev1 (Event ($Term2 $Truth2) ($Time2 $Evidence2 $EPrio2)))
   (let (Event ($Term1 $Truth1) ($Time1 $Evidence1 $EPrio1)) (Projection $Ev1 $Time2)
        (Event (($Term1 &/ $Term2) (Truth_Intersection $Truth1 $Truth2)) ($Time2 (TupleConcat $Evidence1 $Evidence2) (0 0.0)))))

;Form a temporal implication between two events
(= (TemporalImplication $Ev1 (Event ($Term2 $Truth2) ($Time2 $Evidence2 $EPrio2)))
   (let (Event ($Term1 $Truth1) ($Time1 $Evidence1 $EPrio1)) (Projection $Ev1 $Time2)
        (Event (($Term1 =/> $Term2) (Truth_Induction $Truth1 $Truth2)) ($Time2 (TupleConcat $Evidence1 $Evidence2) (0 0.0)))))

;Whether an event's term is an operation
(= (IsOp (Event ($Term $Truth) $Metadata))
   (case $Term (((^ $Opname) True)
                ($Otherwise False))))

;Find implications in the event FIFO:
;procedural implications
(= (TemporalImplicationInduction (Cons $Cons (Cons $Op (Cons $Prec $Tail))))
   (If (and (IsOp $Op) (and (not (IsOp $Cons)) (not (IsOp $Prec))))
       (let $PrecOp (TemporalSequence $Prec $Op)
            (TemporalImplication $PrecOp $Cons))))
;and temporal without operation
(= (TemporalImplicationInduction (Cons $Cons (Cons $Prec $Tail)))
   (If (and (not (IsOp $Prec)) (not (IsOp $Cons)))
       (TemporalImplication $Prec $Cons)))

;Add negative evidence for implications which predicted the input unsuccessfully
(= (NegConfirmation $PrecTerm $ObservedCons $t)
   (let (Event (($PrecTerm =/> $PredictedCons) $ImpTV) $ImpMetadata) (EternalQuestion ($PrecTerm =/> $PredictedCons))
        (If (not (== $ObservedCons $PredictedCons))
            (UpdateConcept (Event (($PrecTerm =/> $PredictedCons) (0.0 0.1)) ($t () (0 0.0))) $t))))

;Check if the implication's preconditions are met to anticipate the by the implication predicted outcome
(= (Anticipate (Cons $Pos Nil) $t))
(= (Anticipate (Cons $Pos (Cons $Pre Nil)) $t)
   (let* (((Event ($PreTerm $PreTV) $PreMetadata) $Pre)
          ((Event ($PosTerm $PosTV) $PosMetadata) $Pos))
         (If (not (IsOp $Pre))
             (NegConfirmation $PreTerm $PosTerm $t))))
(= (Anticipate (Cons $Pos (Cons $Op (Cons $Pre $Trail))) $t)
   (let* (((Event ($PreTerm $PreTV) $PreMetadata) $Pre)
          ((Event ($OpTerm $OpTV) $OpMetadata) $Op)
          ((Event ($PosTerm $PosTV) $PosMetadata) $Pos)
          ($Sequence ($Pre &/ Pos)))
         (If (and (IsOp $Op) (not (IsOp $Pre)))
             (NegConfirmation ($PreTerm &/ $OpTerm) $PosTerm $t))))

;;Input procedure
(= (AddBeliefEvent $Sentence)
   (let* ((($t $evidentialBase) (GetReasonerState))
          ($InputEvent (Event $Sentence ($t $evidentialBase ($t 1.0)))))
         (do (sequential ((EventToFIFO $InputEvent)
                         (let $InducedHypothesis (TemporalImplicationInduction (get-state &FIFO))
                              (UpdateConcept $InducedHypothesis $t))
                         (ProcessBeliefEvent $InputEvent $t)
                         (Anticipate (get-state &FIFO) $t)
                         (BeliefCycle $t))))))
