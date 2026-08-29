#!/bin/bash
# verifier_profile_tests.sh - unit tests of the VERIFY_PROFILE semantics of scripts/verify_all_portable.sh (r14, E14-4; GPT r13 hw 452-454).
# Uses VERIFY_PRECHECK_ONLY=1 so that no verification step runs: only the precheck / final-line logic is exercised (seconds).
# Each case states the expected final line; the FULL line must never appear in a partial profile; exit 0 iff all cases behave.
cd "$(dirname "$0")/.." || exit 2
V=scripts/verify_all_portable.sh; T=$(mktemp -d); ok=0; n=0
run() {  # run <name> <expect-regex> <forbid-regex> <env...>
  local name="$1" exp="$2" forbid="$3"; shift 3; n=$((n+1))
  env -i PATH="$PATH" HOME="$HOME" VERIFY_PRECHECK_ONLY=1 VERIFY_OUT="$T/out" "$@" bash "$V" > "$T/$name.log" 2>&1; local rc=$?
  local last; last=$(tail -1 "$T/$name.log")
  if echo "$last" | grep -qE "$exp" && ! grep -qE "$forbid" "$T/$name.log"; then ok=$((ok+1)); echo "PT$n $name :: CAUGHT/EXPECTED (rc=$rc) :: $last"
  else echo "PT$n $name :: WRONG (rc=$rc) :: $last"; grep -E "$forbid" "$T/$name.log" | head -2; fi
}
FAKE_SAGE=$T/sage; printf '#!/bin/sh\necho SageMath 10.8\n' > "$FAKE_SAGE"; chmod +x "$FAKE_SAGE"; LW=$T/ws; mkdir -p "$LW"
# full profile: any missing prerequisite must FAIL before any step, and print the FULL FAIL line
run full_skip_sage   'VERIFY_ALL_PORTABLE 1.0.2 FULL: FAIL' 'FULL: PASS' VERIFY_PROFILE=full SKIP_SAGE=1 SAGE_BIN="$FAKE_SAGE" LEAN_WORKSPACE="$LW" SKIP_PAPER=0
run full_no_lean     'VERIFY_ALL_PORTABLE 1.0.2 FULL: FAIL' 'FULL: PASS' VERIFY_PROFILE=full SAGE_BIN="$FAKE_SAGE" SKIP_PAPER=0
run full_no_sage_bin 'VERIFY_ALL_PORTABLE 1.0.2 FULL: FAIL' 'FULL: PASS' VERIFY_PROFILE=full SAGE_BIN=/nonexistent/sage LEAN_WORKSPACE="$LW" SKIP_PAPER=0
run full_skip_paper  'VERIFY_ALL_PORTABLE 1.0.2 FULL: FAIL' 'FULL: PASS' VERIFY_PROFILE=full SAGE_BIN="$FAKE_SAGE" LEAN_WORKSPACE="$LW" SKIP_PAPER=1
# partial profiles: their own prerequisite is required; the other side may be absent; the FULL line must never be printed
run sage_skip_sage   'SAGE_PROFILE: FAIL' 'VERIFY_ALL_PORTABLE 1.0.2 FULL' VERIFY_PROFILE=sage SKIP_SAGE=1 SAGE_BIN="$FAKE_SAGE"
run sage_no_lean_ok  'SAGE_PROFILE: PASS' 'VERIFY_ALL_PORTABLE 1.0.2 FULL' VERIFY_PROFILE=sage SAGE_BIN="$FAKE_SAGE" SKIP_PAPER=1
run lean_no_ws       'LEAN_PROFILE: FAIL' 'VERIFY_ALL_PORTABLE 1.0.2 FULL' VERIFY_PROFILE=lean SKIP_SAGE=1
run lean_skip_sage_ok 'LEAN_PROFILE: PASS' 'VERIFY_ALL_PORTABLE 1.0.2 FULL' VERIFY_PROFILE=lean SKIP_SAGE=1 LEAN_WORKSPACE="$LW" SKIP_PAPER=1
run bad_profile      'must be full' 'PASS' VERIFY_PROFILE=nonsense
# the structured summary must record the profile and the skip decision
if python3 -c "import json,sys; d=json.load(open('$T/out/SUMMARY.json')); sys.exit(0 if d['profile']=='lean' and d['status']=='PASS' and d['full_line_printed'] is False else 1)"; then ok=$((ok+1)); echo "PT$((n+1)) summary_json :: OK (profile lean, PASS, full_line_printed false)"; else echo "PT$((n+1)) summary_json :: WRONG"; fi; n=$((n+1))
rm -rf "$T"
echo "VERIFIER PROFILE TESTS: $([ $ok -eq $n ] && echo PASS || echo FAIL) ($ok/$n)"
[ $ok -eq $n ]
