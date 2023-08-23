;;NAL-5
;;!Negation conjunction and disjunction decomposition:
(= (|- ((! $A) $T)) ($A (Truth_Negation $T)))
(= (|- (($A && $B) $T)) ($A (Truth_StructuralDeduction $T)))
(= (|- (($A && $B) $T)) ($B (Truth_StructuralDeduction $T)))
(= (|- (($A && $B) $T)) (($B && $A) (Truth_StructuralIntersection $T)))
(= (|- ($S $T1) (($S && $A) $T2)) ($A (Truth_DecomposePNN $T1 $T2)))
(= (|- ($S $T1) (($S || $A) $T2)) ($A (Truth_DecomposeNPP $T1 $T2)))
(= (|- ($S $T1) (((! $S) && $A) $T2)) ($A (Truth_DecomposeNNN $T1 $T2)))
(= (|- ($S $T1) (((! $S) || $A) $T2)) ($A (Truth_DecomposePPP $T1 $T2)))
;;!Syllogistic rules for Implication:
(= (|- (($A ==> $B) $T1) (($B ==> $C) $T2)) (($A ==> $C) (Truth_Deduction $T1 $T2)))
(= (|- (($A ==> $B) $T1) (($A ==> $C) $T2)) (($C ==> $B) (Truth_Induction $T1 $T2)))
(= (|- (($A ==> $C) $T1) (($B ==> $C) $T2)) (($B ==> $A) (Truth_Abduction $T1 $T2)))
(= (|- (($A ==> $B) $T1) (($B ==> $C) $T2)) (($C ==> $A) (Truth_Exemplification $T1 $T2)))
;;!Conditional composition for conjunction and disjunction:
(= (|- (($A ==> $C) $T1) (($B ==> $C) $T2)) ((($A && $B) ==> $C) (Truth_Union $T1 $T2)))
(= (|- (($A ==> $C) $T1) (($B ==> $C) $T2)) ((($A || $B) ==> $C) (Truth_Intersection $T1 $T2)))
(= (|- (($C ==> $A) $T1) (($C ==> $B) $T2)) (($C ==> ($A && $B)) (Truth_Intersection $T1 $T2)))
(= (|- (($C ==> $A) $T1) (($C ==> $B) $T2)) (($C ==> ($A || $B)) (Truth_Union $T1 $T2)))
;;!Multi-conditional inference:
(= (|- ((($S && $P) ==> $M) $T1) (($S ==> $M) $T2)) ($P (Truth_Abduction $T1 $T2)))
(= (|- ((($C && $M) ==> $P) $T1) (($S ==> $M) $T2)) ((($C && $S) ==> $P) (Truth_Deduction $T1 $T2)))
(= (|- ((($C && $P) ==> $M) $T1) ((($C && $S) ==> $M) $T2)) (($S ==> $P) (Truth_Abduction $T1 $T2)))
(= (|- ((($C && $M) ==> $P) $T1) (($M ==> $S) $T2)) ((($C && $S) ==> $P) (Truth_Induction $T1 $T2)))
;;!Rules for equivalence:
(= (|- (($S <=> $P) $T)) (($P <=> $S) (Truth_StructuralIntersection $T)))
(= (|- (($S ==> $P) $T1) (($P ==> $S) $T2)) (($S <=> $P) (Truth_Intersection $T1 $T2)))
(= (|- (($P ==> $M) $T1) (($S ==> $M) $T2)) (($S <=> $P) (Truth_Comparison $T1 $T2)))
(= (|- (($M ==> $P) $T1) (($M ==> $S) $T2)) (($S <=> $P) (Truth_Comparison $T1 $T2)))
(= (|- (($M ==> $P) $T1) (($S <=> $M) $T2)) (($S ==> $P) (Truth_Analogy $T1 $T2)))
(= (|- (($P ==> $M) $T1) (($S <=> $M) $T2)) (($P ==> $S) (Truth_Analogy $T1 $T2)))
(= (|- (($M <=> $P) $T1) (($S <=> $M) $T2)) (($S <=> $P) (Truth_Resemblance $T1 $T2)))
;;!Higher-order decomposition
(= (|- (($A $T1) ($A ==> $B) $T2)) ($B (Truth_Deduction $T1 $T2)))
(= (|- (($A $T1) (($A && $B) ==> $C) $T2)) (($B ==> $C) (Truth_Deduction $T1 $T2)))
(= (|- ($b $T1) (($a ==> $b) $T2)) ($a (Truth_Abduction $T1 $T2)))
(= (|- (($A $T1) ($A <=> $B) $T2)) ($B (Truth_Analogy $T1 $T2)))
