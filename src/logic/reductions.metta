;;NAL term reductions
;;!Extensional intersection, union, conjunction reductions:
;(= ($A & $A) $A)
;(= ($A | $A) $A)
;(= ($A && $A) $A)
;(= ($A || $A) $A)
;;!Extensional set reductions:
;(= (({ $A }) | ({ $B })) ({ $A $B }))
;(= (({ $A $B }) | ({ $C })) ({ ($A . $B) $C }))
;(= (({ $C }) | ({ $A $B }) ) ({ $C ($A . $B) }))
;;!Intensional set reductions:
;(= (([ $A ]) & ([ $B ])) ([ $A $B ]) )
;(= (([ $A $B ]) & ([ $C ])) ([ ($A . $B) $C ]))
;(= (([ $A ]) & ([ $B $C ])) ([ $A ($B . $C) ]))
;;!Reduction for set element copula:
;(= ({ ( $A . $B ) }) ({ $A $B }))
;(= ([ ( $A . $B ) ]) ([ $A $B ]))
