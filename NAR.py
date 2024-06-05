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
    for i in range(cycles):
        NAR_AddInput(f'!(BeliefCycle {currentTime})')
    for i in range(cycles):
        NAR_AddInput(f'!(GoalCycle {currentTime})')

def NAR_AddInput(metta):
    usedNAR.stdin.write(metta+'\n')
    usedNAR.stdin.flush()
    print(GREEN + trackTime(usedNAR.stdout.readline()).replace("metta> metta> [", MAGENTA + "ANS: ").replace("metta> metta>", "IN: ") + RESET, end="")
    usedNAR.stdin.write('!(+ 41 1)\n') #just for synch
    while True:
        usedNAR.stdin.flush()
        LINE = trackTime(usedNAR.stdout.readline())
        if LINE.startswith("[(^ "):
            print(RED + "EXE:", LINE + RESET, end="")
        elif "unspecified" not in LINE and not LINE.startswith("[]") and not LINE.startswith("metta> metta> [42]"):
            print(YELLOW + "OUT:", LINE + RESET, end="")
        if "metta> metta> [42]" in LINE:
            usedNAR.stdout.readline()
            break
