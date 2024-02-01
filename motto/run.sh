echo "Welcome to MeTTa-Motto + MeTTa-NARS + MeTTa-Morph, please make sure to export OPENAI_API_KEY=..."
cd ..
sh build.sh
cd motto
cd metta-motto || (git clone https://github.com/trueagi-io/metta-motto && cd metta-motto)
cp -r motto ../../../extend/
cd ../../../extend/
cp ../metta-nars/src/NARS.metta NARS.metta
cp ../metta-nars/motto/nars_reason.metta nars_reason.metta
cp ../metta-nars/motto/nars_reason.msa nars_reason.msa
metta example1.metta
#metta nars_reason.metta
