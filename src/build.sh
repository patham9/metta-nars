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
cat TUPLECOUNTS.metta > /dev/null || (cat utils.metta > BUILDTUPLECOUNTS.metta && echo "!(do (BuildTupleCounts (1) 0 100))" >> BUILDTUPLECOUNTS.metta && metta BUILDTUPLECOUNTS.metta 2> TUPLECOUNTS.metta)
cat utils.metta TUPLECOUNTS.metta ./logic/LOGIC.metta ./memory/MEMORY.metta ./control/CONTROL.metta > NARS.metta
echo "metta-nars build done."
