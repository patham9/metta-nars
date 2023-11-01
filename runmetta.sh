sh build.sh && cat ./src/NARS.metta $1 > ./../RUN.metta
cd ..
time sh runmetta.sh ./RUN.metta
