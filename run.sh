sh build.sh && cat ./src/NARS.metta $1 > RUN.metta
cd ..
sh runmetta.sh ./metta-nars/RUN.metta
