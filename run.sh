cd src
sh build.sh
cd ..
cat ./src/NARS.metta ./tests/tests0.metta > RUN.metta && metta RUN.metta > OUTPUT_tests0.txt
cat ./src/NARS.metta ./tests/tests1.metta > RUN.metta && metta RUN.metta > OUTPUT_tests1.txt
cat ./src/NARS.metta ./tests/tests2.metta > RUN.metta && metta RUN.metta > OUTPUT_tests2.txt
cat ./src/NARS.metta ./tests/tests3.metta > RUN.metta && metta RUN.metta > OUTPUT_tests3.txt
rm RUN.metta
