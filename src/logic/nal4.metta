;; NAL-4
;;!Transformation rules between product and image:
(= (|- ((($A x $B) --> $R) $T)) (($A --> ($R /1 $B)) (Truth_StructuralIntersection $T)))
(= (|- ((($A x $B) --> $R) $T)) (($B --> ($R /2 $A)) (Truth_StructuralIntersection $T)))
(= (|- (($R --> ($A x $B)) $T)) ((($R \1 $B) --> $A) (Truth_StructuralIntersection $T)))
(= (|- (($R --> ($A x $B)) $T)) ((($R \2 $A) --> $B) (Truth_StructuralIntersection $T)))
;;other direction of same rules (as these are bi-directional)
;(= (|- (($A --> ($R /1 $B)) $T)) ((($A x $B) --> $R) (Truth_StructuralIntersection $T)))
;(= (|- (($B --> ($R /2 $A)) $T)) ((($A x $B) --> $R) (Truth_StructuralIntersection $T)))
;(= (|- ((($R \1 $B) --> $A) $T)) (($R --> ($A x $B)) (Truth_StructuralIntersection $T)))
;(= (|- ((($R \2 $A) --> $B) $T)) (($R --> ($A x $B)) (Truth_StructuralIntersection $T)))
;;!Comparative relations
;(= (|- ((({ $R }) |-> ([ $P ])) $T1) ((({ $S }) |-> ([ $P ])) $T2)) (((({ $R }) x ({ $S })) --> (>>> $P )) (Truth_FrequencyGreater $T1 $T2)))
;(= (|- ((($A x $B) --> (>>> $P)) $T1) ((($B x $C) --> (>>> $P)) $T2)) ((($A x $C) --> (>>> $P)) (Truth_Deduction $T1 $T2)))
;(= (|- ((({ $R }) |-> ([ $P ])) $T1) ((({ $S }) |-> ([ $P ])) $T2)) (((({ $R }) x ({ $S })) --> (=== $P)) (Truth_FrequencyEqual $T1 $T2)))
;(= (|- ((($A x $B) --> (=== $P)) $T1) ((($B x $C) --> (=== $P)) $T2)) ((($A x $C) --> (=== $P)) (Truth_Deduction $T1 $T2)))
;(= (|- ((($A x $B) --> (=== $P)) $T)) ((($B x $A) --> (=== $P)) (Truth_StructuralIntersection $T)))
;;!Optional rules for more efficient reasoning about relation components:
(= (|- ((($A x $B) --> $R) $T1) ((($C x $B) --> $R) $T2)) (($C --> $A) (Truth_Abduction $T1 $T2)))
(= (|- ((($A x $B) --> $R) $T1) ((($A x $C) --> $R) $T2)) (($C --> $B) (Truth_Abduction $T1 $T2)))
(= (|- (($R --> ($A x $B)) $T1) (($R --> ($C x $B)) $T2)) (($C --> $A) (Truth_Induction $T1 $T2)))
(= (|- (($R --> ($A x $B)) $T1) (($R --> ($A x $C)) $T2)) (($C --> $B) (Truth_Induction $T1 $T2)))
(= (|- ((($A x $B) --> $R) $T1) (($C --> $A) $T2)) ((($C x $B) --> $R) (Truth_Deduction $T1 $T2)))
(= (|- ((($A x $B) --> $R) $T1) (($A --> $C) $T2)) ((($C x $B) --> $R) (Truth_Induction $T1 $T2)))
(= (|- ((($A x $B) --> $R) $T1) (($C <-> $A) $T2)) ((($C x $B) --> $R) (Truth_Analogy $T1 $T2)))
(= (|- ((($A x $B) --> $R) $T1) (($C --> $B) $T2)) ((($A x $C) --> $R) (Truth_Deduction $T1 $T2)))
(= (|- ((($A x $B) --> $R) $T1) (($B --> $C) $T2)) ((($A x $C) --> $R) (Truth_Induction $T1 $T2)))
(= (|- ((($A x $B) --> $R) $T1) (($C <-> $B) $T2)) ((($A x $C) --> $R) (Truth_Analogy $T1 $T2)))
(= (|- (($R --> ($A x $B)) $T1) (($A --> $C) $T2)) (($R --> ($C x $B)) (Truth_Deduction $T1 $T2)))
(= (|- (($R --> ($A x $B)) $T1) (($C --> $A) $T2)) (($R --> ($C x $B)) (Truth_Abduction $T1 $T2)))
(= (|- (($R --> ($A x $B)) $T1) (($C <-> $A) $T2)) (($R --> ($C x $B)) (Truth_Analogy $T1 $T2)))
(= (|- (($R --> ($A x $B)) $T1) (($B --> $C) $T2)) (($R --> ($A x $C)) (Truth_Deduction $T1 $T2)))
(= (|- (($R --> ($A x $B)) $T1) (($C --> $B) $T2)) (($R --> ($A x $C)) (Truth_Abduction $T1 $T2)))
(= (|- (($R --> ($A x $B)) $T1) (($C <-> $B) $T2)) (($R --> ($A x $C)) (Truth_Analogy $T1 $T2)))
(= (|- ((($A x $B) --> $R) $T1) ((($C x $B) --> $R) $T2)) (($A <-> $C) (Truth_Comparison $T1 $T2)))
(= (|- ((($A x $B) --> $R) $T1) ((($A x $C) --> $R) $T2)) (($B <-> $C) (Truth_Comparison $T1 $T2)))
(= (|- (($R --> ($A x $B)) $T1) (($R --> ($C x $B)) $T2)) (($A <-> $C) (Truth_Comparison $T1 $T2)))
(= (|- (($R --> ($A x $B)) $T1) (($R --> ($A x $C)) $T2)) (($B <-> $C) (Truth_Comparison $T1 $T2)))
