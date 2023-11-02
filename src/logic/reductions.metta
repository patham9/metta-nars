;;NAL term reductions
;;!Extensional intersection, union, conjunction reductions:
;(= ($A & $A) $A)
;(= ($A | $A) $A)
;(= ($A && $A) $A)
;(= ($A || $A) $A)
;;!Extensional set reductions:
;(= ((ExtSet $A) | (ExtSet $B)) (ExtSet $A $B))
;(= ((ExtSet $A $B) | (ExtSet $C)) (ExtSet ($A SetElement $B) $C))
;(= ((ExtSet $C) | (ExtSet $A $B) ) (ExtSet $C ($A SetElement $B)))
;;!Intensional set reductions:
;(= ((IntSet $A) & (IntSet $B)) (IntSet $A $B) )
;(= ((IntSet $A $B) & (IntSet $C)) (IntSet ($A SetElement $B) $C))
;(= ((IntSet $A) & (IntSet $B $C)) (IntSet $A ($B SetElement $C)))
;;!Reduction for set element copula:
;(= (ExtSet ( $A SetElement $B )) (ExtSet $A $B))
;(= (IntSet ( $A SetElement $B )) (IntSet $A $B))
