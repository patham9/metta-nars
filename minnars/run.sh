cd ..
cd src
sh build.sh
cd ..
cd minnars
cat ../src/logic/LOGIC.metta minnars.metta input.metta > RUN.metta && metta RUN.metta
