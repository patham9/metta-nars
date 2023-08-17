;; stdlib extension
(= (ListConcat $L Nil) $L)
(= (ListConcat $C (Cons $LH $LT)) (ListConcat (Cons $LH $C) $LT))
(= (Included $element Nil) False)
(= (Included $element (Cons $head $tail)) (or (== $element $head) (Included $element $tail)))
(= (max $1 $2) (if (> $1 $2) $1 $2))
(= (min $1 $2) (if (< $1 $2) $1 $2))
(= (abs $x) (if (< $x 0) (- 0 $x) $x))
(: sequential (-> Expression %Undefined%))
(= (sequential $1) (superpose $1))
(= (BuildTupleCounts $C $T) 
   (superpose ((add-atom &self (= (TupleCount $T) $C))
               (if (> $C 0) (BuildTupleCounts (- $C 1) (cdr-atom $T)) nop))))
(= (CountElement $x) 1)
;;Build for count up to 100 (takes 2.5 sec but it is worth it if space or generally collapse counts are often needed)
!(BuildTupleCounts 100
 (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
(: CollapseCardinality (-> Expression Number))
(= (CollapseCardinality $expression) (TupleCount (collapse (CountElement $expression))))
