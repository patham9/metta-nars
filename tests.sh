sh build.sh
cat ./src/NARS.metta ./tests/tests0.metta > RUN.metta && cd .. && sh run.sh ./metta-nars/RUN.metta > OUTPUT_tests0.txt && cd ./metta-nars/
cat ./src/NARS.metta ./tests/tests1.metta > RUN.metta && cd .. && sh run.sh ./metta-nars/RUN.metta > OUTPUT_tests1.txt && cd ./metta-nars/
cat ./src/NARS.metta ./tests/tests2.metta > RUN.metta && cd .. && sh run.sh ./metta-nars/RUN.metta > OUTPUT_tests2.txt && cd ./metta-nars/
cat ./src/NARS.metta ./tests/tests3.metta > RUN.metta && cd .. && sh run.sh ./metta-nars/RUN.metta > OUTPUT_tests3.txt && cd ./metta-nars/
cat ./src/NARS.metta ./tests/tests4.metta > RUN.metta && cd .. && sh run.sh ./metta-nars/RUN.metta > OUTPUT_tests4.txt && cd ./metta-nars/
cat ./src/NARS.metta ./tests/tests5.metta > RUN.metta && cd .. && sh run.sh ./metta-nars/RUN.metta > OUTPUT_tests5.txt && cd ./metta-nars/
rm RUN.metta
