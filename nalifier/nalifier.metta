(= (query $Term)
   (let ($A $B $f) (match &self (= (|- ($A $T1) ($B $T2)) ($Term ($f $T1 $T2))) ($A $B $f))
        (case (match &self (, (($A $T1) $Ev1) (($B $T2) $Ev2))
                     (If (StampDisjoint $Ev1 $Ev2)
                         (($Term ($f $T1 $T2)) (TupleConcat $Ev1 $Ev2))))
              (((($Term $T) $Ev) (($Term $T) $Ev))))))

;choice between two options of different term
(= (Choice (($Term1 $T1) $ev1) (($Term2 $T2) $ev2))
   (If (> (Truth_Expectation $T1) (Truth_Expectation $T2))
       (($Term1 $T1) $ev1)
       (($Term2 $T2) $ev2)))

;revise if there is no evidential overlap, else use higher-confident candidate
(= (RevisionAndChoice (($Term1 ($f1 $c1)) $ev1) (($Term2 ($f2 $c2)) $ev2))
   (let $ConclusionStamp (TupleConcat $ev1 $ev2)
    (If (StampDisjoint $ev1 $ev2)
        (($Term1 (Truth_Revision ($f1 $c1) ($f2 $c2))) $ConclusionStamp)
        (if (> $c1 $c2) 
            (($Term1 ($f1 $c1)) $ev1)
            (($Term2 ($f2 $c2)) $ev2)))))

(= (accumulateOptions $revChoiceOrBoth $option $options)
   (if (== $options ())
       $option
       (let* (($head (car-atom $options))
              ($rest (cdr-atom $options))
              ($revi ($revChoiceOrBoth $option $head)))
             (accumulateOptions $revChoiceOrBoth $revi $rest))))
             
(= (EmptyEvent) ((x (1.0 0.0)) ()))

(= (evidenceQuery $Term) (accumulateOptions RevisionAndChoice (EmptyEvent) (collapse (query $Term))))

(= (choiceQuery $Term)
   (let $options (collapse (evidenceQuery (superpose $Term)))
        (accumulateOptions Choice (EmptyEvent) $options)))

