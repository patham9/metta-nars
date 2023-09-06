;; Alternate implication direct introduction formula assuming Boolean
;; evidence.  Base case, meaning there is only one piece of evidence.
(: direct-introduction-base-formula (-> Bool Bool TruthValue))
(= (direct-introduction-base-formula False $_) (STV 1 0))
(= (direct-introduction-base-formula True $qa)
   (STV (bool->number $qa) (count->confidence 1)))

;; Alternate implication direct introduction formula.  Inductive case,
;; meaning the piece of evidence gets aggregated to another truth
;; value.
(: direct-introduction-recursive-formula (-> Bool Bool TruthValue TruthValue))
(= (direct-introduction-recursive-formula False $_ (STV $PQs $PQc)) (STV $PQs $PQc))
(= (direct-introduction-recursive-formula True False (STV $PQs $PQc))
   (STV (inc-count-strength $PQs $PQc) (inc-confidence $PQc)))
(= (direct-introduction-recursive-formula True True (STV $PQs $PQc))
   (STV $PQs (inc-confidence $PQc)))

(= (modus-ponens-formula ($As $Ac)
                         ($ABs $ABc))
   (let*
       (($notABs 0.2)   ; temporary hack
        ($notABc 1))
       (
           (+ (* $ABs $As) (* $notABs (- 1 $As)))
           (min (min $ABc $notABc) $Ac))))


;; Define modus ponens rule
(: modus-ponens-rule (-> Atom))
(= (modus-ponens-rule)
   (: ModusPonens
      (-> (≞ $a $atv)
          (≞ (→ $a $b) $abtv)
          (≞ $b (modus-ponens-formula $atv $abtv)))))
