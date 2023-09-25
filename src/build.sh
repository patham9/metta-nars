cd control
sh build.sh
cd ..

cd logic
sh build.sh
cd ..

cd memory
sh build.sh
cd ..

python3 helper.py > HELP.metta
cat utils.metta HELP.metta ./logic/LOGIC.metta ./memory/MEMORY.metta ./control/CONTROL.metta > NARS.metta
#echo "!(BuildTupleCounts (1) 0 100)" >> NARS.metta #utils configuration
