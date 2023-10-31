;; stdlib extension
(= (TupleConcat $Ev1 $Ev2) (collapse (superpose ((superpose $Ev1) (superpose $Ev2)))))
(= (TupleCount $tuple) (If (== $tuple ()) 0 (+ 1 (TupleCount (cdr-atom $tuple)))))
(: CountElement (-> Expression Number))
(= (CountElement $x) (case $x (($y 1))))
(: CollapseCardinality (-> Expression Number))
(= (CollapseCardinality $expression) (TupleCount (collapse (CountElement $expression))))
