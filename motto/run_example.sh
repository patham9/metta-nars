echo "Welcome to MeTTa-Motto + MeTTa-NARS + MeTTa-Morph, please make sure to export OPENAI_API_KEY=..."
cd ..
sh build.sh
cat ./motto/ALREADY_COMPILED || (cp ./src/NARS.metta ../extend/ && echo "COMPILING...")
cd motto
(cd metta-motto && cd ..) || git clone https://github.com/trueagi-io/metta-motto
cd metta-motto
cp -r ./motto ../../../extend/
cp ./../nars_reason_example.metta ../../../extend/nars_reason_example.metta
cp ./../nars_reason.msa ../../../extend/nars_reason.msa
cp ./../nars_query.msa ../../../extend/nars_query.msa
echo "ALREADY_COMPILED" > ../ALREADY_COMPILED
cd ../../../extend/
metta nars_reason_example.metta
