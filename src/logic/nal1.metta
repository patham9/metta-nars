;;NAL-1
;;!Syllogistic rules for Inheritance:
(= (|- (($a --> $b) $T1) (($b --> $c) $T2)) (($a --> $c) (Truth_Deduction $T1 $T2)))
(= (|- (($a --> $b) $T1) (($a --> $c) $T2)) (($c --> $b) (Truth_Induction $T1 $T2)))
(= (|- (($a --> $c) $T1) (($b --> $c) $T2)) (($b --> $a) (Truth_Abduction $T1 $T2)))
(= (|- (($a --> $b) $T1) (($b --> $c) $T2)) (($c --> $a) (Truth_Exemplification $T1 $T2)))
