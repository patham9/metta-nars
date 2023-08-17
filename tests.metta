;;NAL test
!(|- ((Garfield --> cat) (1.0 0.9)) ((cat --> animal) (1.0 0.9)))
!(|- ((Garfield --> carnivore) (1.0 0.9)) (((Garfield --> cat) ==> (Garfield --> carnivore)) (1.0 0.9)))
!(|- ((({ a b }) --> mwawa) (1.0 0.9)))
!(|- ((a --> b) (1.0 0.9)) ((c --> b) (1.0 0.9)))
!(|- (((a * b) --> R) (1.0 0.9)))
!(|- ((R --> (a * b)) (1.0 0.9)))
!(|- ((A --> cat) (1.0 0.9)) ((B --> cat) (1.0 0.9)))
!(|- (|- ((Garfield --> cat) (1.0 0.9)) ((cat --> animal) (1.0 0.9))) ((animal --> being) (1.0 0.9)))

;;NARS test
!(AddBeliefEvent ((({ garfield }) --> cat) (1.0 0.9)))
!(AddBeliefEvent (((cat * sky) --> like) (1.0 0.9)))
!(AddBeliefEvent ((sky --> ([ blue ])) (1.0 0.9)))
;The following question needs both a deduction and abduction step:
!(EternalQuestion ((({ garfield }) * ([ blue ])) --> like))
;[(Event (((({ garfield }) * ([ blue ])) --> like) (1.0 0.2965825874694874)) (eternal (Cons 2 (Cons 1 (Cons 3 Nil))) 0.643288027761712))]
;Lets stress the control mechanism as these type of events with common extension or intension causes dozens of derivations:
!(AddBeliefEvent ((A --> cat) (1.0 0.9)))
!(AddBeliefEvent ((B --> cat) (1.0 0.9)))
!(AddBeliefEvent ((C --> cat) (1.0 0.9)))
!(EternalQuestion ((A & B) --> cat))
;[(Event (((A & B) --> cat) (1.0 0.44751381215469616)) (eternal (Cons 4 (Cons 5 Nil)) (5 0.4525)))]
!(EternalQuestion ((B & C) --> cat))
;[(Event (((B & C) --> cat) (1.0 0.44751381215469616)) (eternal (Cons 5 (Cons 6 Nil)) (6 0.4525)))]
!(EternalQuestion (((A & B) & C) --> cat))
;[(Event ((((A & B) & C) --> cat) (1.0 0.42163100057836905)) (eternal (Cons 5 (Cons 4 (Cons 6 Nil))) (6 0.195593125)))
!(AddBeliefEvent (((({ garfield }) * ([ blue ])) --> like) (1.0 0.9)))
!(EternalQuestion ((({ garfield }) * ([ blue ])) --> like))
;Please notice that it has revised it with the prior derived result, as you can also see in the evidence trail 1,2,3 being included
;[(Event (((({ garfield }) * ([ blue ])) --> like) (1.0 0.5692683291397822)) (eternal (Cons 7 (Cons 2 (Cons 1 (Cons 3 Nil)))) 0.0))]
!(CollapseCardinality (get-atoms &belief_events))
;[8]
!(CollapseCardinality (get-atoms &attentional_focus))
;[7]
!(CollapseCardinality (get-atoms &concepts))
;[95]
