!(AddBeliefEvent (((corridorIn &/ (^ forward)) =/> doorAt) (1.0 0.9)))
!(AddBeliefEvent (((doorAt &/ (^ open)) =/> Outside) (1.0 0.9)))

!(AddBeliefEvent (corridorIn (1.0 0.9)))
!(AddGoalEvent (Outside (1.0 0.9)))
!(get-state &execution)
;expected: [None]

;needs one more goal cycle for planning 2 steps
!(GoalCycle (get-state &currentTime))
!(get-state &execution)
;expected: [(^ forward)]

!(AddBeliefEvent (doorAt (1.0 0.9)))
!(AddGoalEvent (Outside (1.0 0.9)))
!(get-state &execution)
;expected: [(^ open)]
