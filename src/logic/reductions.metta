;;NAL term reductions
;;!Extensional intersection, union, conjunction reductions:
(= (reduce ($A & $A)) $A)
(= (reduce ($A | $A)) $A)
(= (reduce ($A && $A)) $A)
(= (reduce ($A || $A)) $A)
;;!Extensional set reductions:
(= (reduce ((ExtSet $A) | (ExtSet $B))) (ExtSet $A $B))
(= (reduce ((ExtSet $A $B) | (ExtSet $C))) (ExtSet ($A SetElement $B) $C))
(= (reduce ((ExtSet $C) | (ExtSet $A $B) )) (ExtSet $C ($A SetElement $B)))
;;!Intensional set reductions:
(= (reduce ((IntSet $A) & (IntSet $B))) (IntSet $A $B) )
(= (reduce ((IntSet $A $B) & (IntSet $C))) (IntSet ($A SetElement $B) $C))
(= (reduce ((IntSet $A) & (IntSet $B $C))) (IntSet $A ($B SetElement $C)))
;;!Reduction for set element copula:
(= (reduce (ExtSet ( $A SetElement $B ))) (ExtSet $A $B))
(= (reduce (IntSet ( $A SetElement $B ))) (IntSet $A $B))
