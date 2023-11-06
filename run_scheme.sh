sh build.sh && cat ./src/NARS.metta $1 > RUN.metta
cd ..
sh run_scheme.sh ./metta-nars/RUN.metta $2
