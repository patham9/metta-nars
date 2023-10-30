;;NAL-2
;;!Rules for Similarity:
;(= (|- (($S <-> $P) $T)) (($P <-> $S) (Truth_StructuralIntersection $T)))
;(= (|- (($M <-> $P) $T1) (($S <-> $M) $T2)) (($S <-> $P) (Truth_Resemblance $T1 $T2)))
;(= (|- (($P --> $M) $T1) (($S --> $M) $T2)) (($S <-> $P) (Truth_Comparison $T1 $T2)))
;(= (|- (($M --> $P) $T1) (($M --> $S) $T2)) (($S <-> $P) (Truth_Comparison $T1 $T2)))
;(= (|- (($M --> $P) $T1) (($S <-> $M) $T2)) (($S --> $P) (Truth_Analogy $T1 $T2)))
;(= (|- (($P --> $M) $T1) (($S <-> $M) $T2)) (($P --> $S) (Truth_Analogy $T1 $T2)))
;;!Dealing with properties and instances:
;(= (|- (($S --> ({ $P })) $T)) (($S <-> ({ $P })) (Truth_StructuralIntersection $T)))
;(= (|- ((([ $S ]) --> $P) $T)) ((([ $S ]) <-> $P) (Truth_StructuralIntersection $T)))
;(= (|- ((({ $M }) --> $P) $T1) (($S <-> $M) $T2)) ((({ $S }) --> $P) (Truth_Analogy $T1 $T2)))
;(= (|- (($P --> ([ $M ])) $T1) (($S <-> $M) $T2)) (($P --> ([ $S ])) (Truth_Analogy $T1 $T2)))
;(= (|- ((({ $A }) <-> ({ $B }))) ($A <-> $B) (Truth_StructuralIntersection $T)))
;(= (|- ((([ $A ]) <-> ([ $B ]))) ($A <-> $B) (Truth_StructuralIntersection $T)))
