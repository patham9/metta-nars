#export OPENAI_API_KEY=...
echo "Welcome to MeTTa-Motto + MeTTa-NARS + MeTTa-Morph, please make sure to export OPENAI_API_KEY=..."
cd ..
sh build.sh
cat ./motto/ALREADY_COMPILED || (cp ./src/NARS.metta ../extend/ && echo "COMPILING...")
cd motto
(cd metta-motto && cd ..) || git clone https://github.com/trueagi-io/metta-motto
cd metta-motto
cp -r ./motto ../../../extend/
cp ./../nars_reason_repl.metta ../../../extend/nars_reason_repl.metta
cp ./../nars_reason.msa ../../../extend/nars_reason.msa
echo "ALREADY_COMPILED" > ../ALREADY_COMPILED
cd ../../../extend/
python3 ./../repl/run_metta_repl.py file=nars_reason_repl.metta suggestion1='!(Sentence "sam is a cat")' suggestion2='!(Question "sam is a cat?")'
