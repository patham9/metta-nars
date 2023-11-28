cd control
sh build.sh
cd ..

cd logic
sh build.sh
cd ..

cd memory
sh build.sh
cd ..

echo "metta-nars build start."
cat utils.metta ./logic/LOGIC.metta ./memory/MEMORY.metta ./control/CONTROL.metta > NARS.metta
echo "metta-nars build done."
