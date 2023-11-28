;;NAL-2
;;!Rules for Similarity:
(= (|- (($S <-> $P) $T)) (($P <-> $S) (Truth_StructuralIntersection $T)))
(= (|- (($M <-> $P) $T1) (($S <-> $M) $T2)) (($S <-> $P) (Truth_Resemblance $T1 $T2)))
(= (|- (($P --> $M) $T1) (($S --> $M) $T2)) (($S <-> $P) (Truth_Comparison $T1 $T2)))
(= (|- (($M --> $P) $T1) (($M --> $S) $T2)) (($S <-> $P) (Truth_Comparison $T1 $T2)))
(= (|- (($M --> $P) $T1) (($S <-> $M) $T2)) (($S --> $P) (Truth_Analogy $T1 $T2)))
(= (|- (($P --> $M) $T1) (($S <-> $M) $T2)) (($P --> $S) (Truth_Analogy $T1 $T2)))
;;!Dealing with properties and instances:
(= (|- (($S --> (ExtSet $P)) $T)) (($S <-> (ExtSet $P)) (Truth_StructuralIntersection $T)))
(= (|- (((IntSet $S) --> $P) $T)) (((IntSet $S) <-> $P) (Truth_StructuralIntersection $T)))
(= (|- (((ExtSet $M) --> $P) $T1) (($S <-> $M) $T2)) (((ExtSet $S) --> $P) (Truth_Analogy $T1 $T2)))
(= (|- (($P --> (IntSet $M)) $T1) (($S <-> $M) $T2)) (($P --> (IntSet $S)) (Truth_Analogy $T1 $T2)))
(= (|- (((ExtSet $A) <-> (ExtSet $B)))) (($A <-> $B) (Truth_StructuralIntersection $T)))
(= (|- (((IntSet $A) <-> (IntSet $B)))) (($A <-> $B) (Truth_StructuralIntersection $T)))
