echo "Welcome to MeTTa-Motto + MeTTa-NARS + MeTTa-Morph, please make sure to export OPENAI_API_KEY=..."
git clone https://github.com/trueagi-io/metta-motto
cd metta-motto
cat ./../nars_reason.metta > RUN.metta
metta RUN.metta 2>&1 | grep "^(" | sed 's/^/!/' > INPUT.metta
cd ../../
cat ./motto/metta-motto/INPUT.metta | sh run_scheme_repl_compiled.sh
