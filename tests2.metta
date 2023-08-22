!(AddBeliefEvent (ballleft (1.0 0.9)))
!(AddBeliefEvent ((^ left) (1.0 0.9)))
!(AddBeliefEvent (ballhit (1.0 0.9)))

!(AddBeliefEvent (ballleft (1.0 0.9)))
!(AddBeliefEvent ((^ left) (1.0 0.9)))

!(AddBeliefEvent (ballright (1.0 0.9)))
!(AddBeliefEvent ((^ left) (1.0 0.9)))
!(AddBeliefEvent (ballhit (1.0 0.9)))

!(AddBeliefEvent (ballright (1.0 0.9)))
!(AddBeliefEvent ((^ right) (1.0 0.9)))
!(AddBeliefEvent (ballhit (1.0 0.9)))

!(AddBeliefEvent (ballright (1.0 0.9)))
!(AddBeliefEvent ((^ right) (1.0 0.9)))
!(AddBeliefEvent (ballhit (1.0 0.9)))

!(AddBeliefEvent (ballleft (1.0 0.9)))

!(EternalQuestion ((ballleft &/ (^ $Op)) =/> ballhit))
!(EternalQuestion ((ballright &/ (^ $Op)) =/> ballhit))
!(AddGoalEvent (ballhit (1.0 0.9)))
