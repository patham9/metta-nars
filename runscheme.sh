sh build.sh && cat ./src/NARS.metta $1 > ./../RUN.metta
cd ..
time sh runscheme.sh ./RUN.metta
