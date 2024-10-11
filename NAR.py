import subprocess
import time
import random

def spawnNAR():
    return subprocess.Popen(["./NAR.sh"], stdin=subprocess.PIPE, stdout=subprocess.PIPE, universal_newlines=True, shell=True)
usedNAR = spawnNAR()

for i in range(13):
    print(usedNAR.stdout.readline())

BLUE = "\x1B[34m"
GREEN = "\x1B[32m"
YELLOW = "\x1B[33m"
CYAN = "\x1B[36m"
MAGENTA = "\x1B[35m"
RED = "\x1B[31m"
RESET = "\x1B[0m"
BOLD = "\x1B[1m"

currentTime = 1 #in case occurrence time needs to be accessed from somewhere it is available
def trackTime(outp):
    global currentTime
    if "time := " in outp:
        currentTime = int(outp.split("time := ")[1].split(")")[0])
        return CYAN + outp + RESET
    return outp

def NAR_Cycle(cycles):
    Ms = {"input": [], "derivations": [], "answers": [], "executions": []}
    for i in range(cycles):
        M = NAR_AddInput(f'!(BeliefCycle {currentTime})')
        Ms["input"] += M["input"]
        Ms["derivations"] += M["derivations"]
        Ms["answers"] += M["answers"]
        Ms["executions"] += M["executions"]
    for i in range(cycles):
        M = NAR_AddInput(f'!(GoalCycle {currentTime})')
        Ms["input"] += M["input"]
        Ms["derivations"] += M["derivations"]
        Ms["answers"] += M["answers"]
        Ms["executions"] += M["executions"]
    return Ms

def NAR_AddInput(metta):
    M = {"input": [], "derivations": [], "answers": [], "executions": []}
    usedNAR.stdin.write(metta+'\n')
    usedNAR.stdin.flush()
    ret = trackTime(usedNAR.stdout.readline())
    if "metta> metta> [" in ret:
        M["answers"].append({"metta": ret})
        ret = MAGENTA + ret.replace("metta> metta> [", "ANS: ")
    elif "metta> metta>" in ret:
        M["input"].append({"metta": ret})
        ret = GREEN + ret.replace("metta> metta>", "IN: ")
    print(ret + RESET, end="")
    usedNAR.stdin.write('!(+ 41 1)\n') #just for synch
    while True:
        usedNAR.stdin.flush()
        LINE = trackTime(usedNAR.stdout.readline())
        if LINE.startswith("[(^ "):
            execdict = {'operator': '^'+LINE.split("[(^ ")[1].split(")")[0], 'arguments': [], 'metta': LINE}
            M["executions"].append(execdict)
            print(RED + "EXE:", LINE + RESET, end="")
        elif "unspecified" not in LINE and not LINE.startswith("[]") and not LINE.startswith("metta> metta> [42]"):
            M["derivations"].append({"metta": LINE})
            print(YELLOW + "OUT:", LINE + RESET, end="")
        if "metta> metta> [42]" in LINE:
            usedNAR.stdout.readline()
            break
    return M
