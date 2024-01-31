echo "Welcome to MeTTa-Motto + MeTTa-NARS + MeTTa-Morph, please make sure to export OPENAI_API_KEY=..."
cd metta-motto || (git clone https://github.com/trueagi-io/metta-motto && cd metta-motto)
metta ./../nars_reason.metta 2>&1 | grep "^(" | sed 's/^/!/' > INPUT.metta
cd ../../
cat ./motto/metta-motto/INPUT.metta | sh run_scheme_repl_compiled.sh
