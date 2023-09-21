sh build.sh
cat ./src/NARS.metta ./tests/tests0.metta > RUN.metta && metta RUN.metta > OUTPUT_tests0.txt
cat ./src/NARS.metta ./tests/tests1.metta > RUN.metta && metta RUN.metta > OUTPUT_tests1.txt
cat ./src/NARS.metta ./tests/tests2.metta > RUN.metta && metta RUN.metta > OUTPUT_tests2.txt
cat ./src/NARS.metta ./tests/tests3.metta > RUN.metta && metta RUN.metta > OUTPUT_tests3.txt
cat ./src/NARS.metta ./tests/tests4.metta > RUN.metta && metta RUN.metta > OUTPUT_tests4.txt
cat ./src/NARS.metta ./tests/tests5.metta > RUN.metta && metta RUN.metta > OUTPUT_tests5.txt
rm RUN.metta
