sh build.sh && cat ./src/NARS.metta $1 > ./../RUN.metta
cd ..
time sh run_metta.sh ./RUN.metta $2
