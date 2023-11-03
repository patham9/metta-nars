;;NAL term reductions
;;!Extensional intersection, union, conjunction reductions:
(= (reduced ($A & $A)) $A)
(= (reduced ($A | $A)) $A)
(= (reduced ($A && $A)) $A)
(= (reduced ($A || $A)) $A)
;;!Extensional set reductions:
(= (reduced ((ExtSet $A) | (ExtSet $B))) (ExtSet $A $B))
(= (reduced ((ExtSet $A $B) | (ExtSet $C))) (ExtSet ($A SetElement $B) $C))
(= (reduced ((ExtSet $C) | (ExtSet $A $B) )) (ExtSet $C ($A SetElement $B)))
;;!Intensional set reductions:
(= (reduced ((IntSet $A) & (IntSet $B))) (IntSet $A $B) )
(= (reduced ((IntSet $A $B) & (IntSet $C))) (IntSet ($A SetElement $B) $C))
(= (reduced ((IntSet $A) & (IntSet $B $C))) (IntSet $A ($B SetElement $C)))
;;!Reduction for set element copula:
(= (reduced (ExtSet ( $A SetElement $B ))) (ExtSet $A $B))
(= (reduced (IntSet ( $A SetElement $B ))) (IntSet $A $B))
