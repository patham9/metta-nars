cd control
sh build.sh
cd ..

cd logic
sh build.sh
cd ..

cd memory
sh build.sh
cd ..

cat utils.metta ./logic/LOGIC.metta ./memory/MEMORY.metta ./control/CONTROL.metta > NARS.metta
