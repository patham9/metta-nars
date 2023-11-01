sh build.sh && cat ./src/NARS.metta $1 > RUN.metta
cd ..
#time sh runmetta.sh ./metta-nars/RUN.metta
time sh runscheme.sh ./metta-nars/RUN.metta
