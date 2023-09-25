for i in range(100+1):
	L = str([1 for j in range(i)]).replace("[", "(").replace("]",")").replace(",", "")
	print(f"(= (TupleCount {L}) {i})")
