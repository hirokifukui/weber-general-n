#!/bin/bash
# verify_all_portable.sh — reviewer-environment package verification, ROUND 14 (2026-08-26).
# r21 changes (GPT r20 review sect 4, P0 items 1-9 = hw 1060-1068): the ROUND is no longer a literal in this script -- it is read from the
# `version:` line of CITATION.cff (single source of the package round); SUMMARY.json round and the FULL line are derived from it; new step
# 00f ci_round_sync (tools/check_ci_round_sync.py + --negctl) audits the workflow aggregator / this script / claims / release metadata.
# Step 12 now scans docs/ERRATA_R*.md (r17-r20 listed docs/ERRATA_R16.md twice and never the current errata -- Claude-found hw 1126).
# r20 changes (GPT r19 review, ERRATA_R20 E20-1/E20-2): new steps 13c statement_sync (+negctl) and 00e release_metadata; the p = 3 certificate
# family (04e/04e2/04f/04g/04h) is UNCHANGED and keeps its r19 file names -- certificate round != package round by design (check_release_metadata r20).
# r19 changes (GPT r18 review, ERRATA_R19 E19-1): 04e/04f read the v3 certificate certificates/p3/D3_cert_r19.json; the p3 coverage gate is CONTAINMENT (120/120), never overlap; new steps 04e2, 04g, 04h (+ _fresh twins); the p3 negative-control count is read from a structured JSON, not from a log.
# r18 changes (GPT r16 review, Track B repair): 09 lean gate now TWELVE files (WeberP3Rel 13 decl: relative norm, DFT vanishing, twisted-sum shift algebra, primitive-root polynomial step); 04e p3 cert gate reads D3_cert_r18.json (two covolume routes, MO2016 comparator).
# r16 changes (GPT r15 review, Track A + P3 + Track B): 09 lean gate now ELEVEN files (WeberHatC 3, WeberSH 7, WeberLemmaB 4, WeberRoots 4, WeberP3 3 decl added r16).
# r16 changes (GPT r14 review, E15-1..E15-3): 09 lean gate now six files (WeberOddTransfer, 5 decl); round names r15; the CI attestation is a
#   release asset, never committed (E15-3); everything else as r14.
# r14 changes (GPT r13 review, E14-1..E14-4):
#   * VERIFY_PROFILE=full|sage|lean (default full). PROFILE full: every step is mandatory; ANY skip (SKIP_SAGE=1, no sage, no
#     LEAN_WORKSPACE, SKIP_PAPER=1, no pdflatex) is a FAIL, decided in a PRECHECK before any step runs, and again by skip() if a
#     step degrades to SKIP at run time. PROFILE sage: python + Sage steps mandatory, Lean and PDF builds may be skipped.
#     PROFILE lean: python + Lean steps mandatory, Sage and PDF builds may be skipped. A partial profile NEVER prints the FULL
#     line: it ends with "SAGE_PROFILE: PASS|FAIL" or "LEAN_PROFILE: PASS|FAIL"; only profile full ends with
#     "VERIFY_ALL_PORTABLE <round> FULL: PASS|FAIL" (round = CITATION.cff version). Skip / fail counts are in verify_out/SUMMARY.json (structured; the CI
#     aggregator reads it and issues "FULL VERIFICATION: PASS" only from one sage-profile and one lean-profile PASS on the same commit).
#     VERIFY_PRECHECK_ONLY=1 stops after the precheck (used by tools/verifier_profile_tests.sh).
#   * 00c constant_sync (tools/check_constant_sync.py): C_7 display / negative-control counts / KY1000 numbers in every medium
#     come from certificates/constants/Cn_interval_r14.json, certificates/negctl/negctl_ledger_r14.json and the KY1000 ledger.
#   * 00d tools_negctl (tools/negctl_tools_r14.py): 13 planted defects in the certificate / ledger / prose must be caught.
#   * 04b cn_certs now reads the r14 interval certificate (not the r11 log); 04c cn_interval re-runs sage/r14_cn_interval.sage into
#     verify_out/ and requires the fresh certificate == shipped (all fields); 04d cross_cas re-runs sage/r14_cross_cas_audit.sage
#     (interval inclusion / intersection per route; the r11 "inside ball" line is no longer a gate).
#   * 08 negctl: the fresh negative-control counts are compared with the shipped ledger (tools/gen_negctl_ledger.py --counts-only).
#   * paper main_1.0.1, CLAIMS_1.0.1, STATEMENT_FREEZE_1.0.1, ERRATA_R16, BLUEPRINT_MAP_1.0.1.
# r13: 00b floor_sync, 08 negctl 9+1, 09 five Lean files. r12/r11 history in the previous headers (archive/rounds/).
# Repository-relative paths only; all hashes via python3 hashlib.
#
# Environment:
#   VERIFY_PROFILE  full (default) | sage | lean   (see above)
#   SAGE_BIN        sage executable (default: `command -v sage`). Required for the Sage steps.
#   LEAN_WORKSPACE  a lake project whose lake-manifest pins mathlib d568c8c0 (toolchain v4.31.0-rc1) in which `lake env lean` works.
#   SKIP_SAGE=1     skip every Sage step (allowed ONLY in profile lean).
#   SKIP_PAPER=1    skip the LaTeX builds (allowed ONLY in the partial profiles).
#   LANES           parallel lanes for the KY1000 verification (default 4).
# Outputs: verify_out/ (logs + SUMMARY.json; excluded from MANIFEST_SHA256.txt). Exit 0 iff the profile's status is PASS.
#
# Steps, in order (hw 70: manifest first):
#   01 manifest        python3 tools/gen_manifest.py --check
#   00b floor_sync     tools/check_floor_sync.py (E13-1: bar_T_n piecewise, same in verifier / Lean / Blueprint / paper)
#   00c constant_sync  tools/check_constant_sync.py (E14-1/E14-2: single-source numbers in every medium; stale forms forbidden)
#   00d tools_negctl   tools/negctl_tools_r14.py (13 planted defects caught; tree untouched)
#   02 environment     recorded environment/*.txt ASSERTED against the running tools
#   04b cn_certs       tools/gen_cn_certs.py --check (certificate re-validated; Table tab:Cn rows verbatim)
#   04e p3_cert        tools/check_p3_cert.py (r19 v3: ROLE 1 producer-record consistency; certified = widen_x2(hull(producer, readonly)); printed p = 3 numbers)
#   04e2 p3_cert_gen   tools/gen_p3_cert_r19.py --check (certificate regenerates from its two shipped inputs)
#   04f p3_readonly    scripts/verify_p3_readonly.sage --negctl (ROLE 2 semantic recomputation; CONTAINMENT 120/120; 12 planted rejections)
#   04g p3_containment tools/check_p3_containment.py (ROLE 3 coverage on the shipped recomputation; 04g_fresh: on this run's recomputation)
#   04h p3_negctl_ledger tools/gen_p3_negctl_ledger.py --check (single-JSON ledger; 04h_fresh: this run's JSON renders the shipped ledger)
#   03b ky1000_target  scripts/verify_ky1000_target.py ; 03c: its 5 planted corruptions REJECTED
#   03 twoadic_rank    python-only verifier of the depth-2/3/4 rank certificates (Cor S1)
#   04 propD           sage/r11_propD_audit.sage parts (a)-(d) (Gram/character/L-route agreement; prod|1-chi(3)|=2); part (e) superseded
#   04c cn_interval    sage/r14_cn_interval.sage -> verify_out/Cn_interval_fresh.json == certificates/constants/Cn_interval_r14.json
#   04d cross_cas      sage/r14_cross_cas_audit.sage -> CROSS-CAS AUDIT: PASS (fresh JSON routes == shipped)
#   05 c7              sage/r7_blichfeldt_dualroute.sage (C_7 interval, thresholds) + flagship verifier
#   06 ky1000          scripts/family_verify_clean.sh on certificates/family/KY1000 (all 1000 primes)
#   07 ky1000_numbers  fresh SUMMARY == shipped ledger SUMMARY == paper table numbers
#   07b ky1000_normalized  tools/ledger_summary.py --compare (normalized per-prime hard gate; raw-log sha forensic)
#   08 negctl          scripts/family_negctl.sh: 9 planted corruptions REJECTED + n=2 positive control EXCLUDED; counts == shipped ledger
#   09 lean            the twelve load-bearing files: exit 0, #print axioms within std-3 for EVERY declaration (3/5/4/6/6/5/3/7/4/4/3/13; WeberP3Rel added r18; WeberOddTransfer added r15, WeberHatC + WeberSH + WeberLemmaB + WeberRoots + WeberP3 added r16), no forbidden tokens
#   10 blueprint       blueprint/check_graph.py: dangling / leanok-without-lean / EVIDENCE-PRESENCE + HUMAN-PROOF gate
#   10b blueprint_pdf  pdflatex blueprint/src/print.tex twice; no errors, no undefined refs, >= 10 pages
#   11 paper           pdflatex main_1.0.1.tex twice into verify_out/paper; no errors, no undefined refs
#   12 placeholders    stale-placeholder grep over the shipped prose
#   13b blueprint_map  tools/gen_blueprint_map.py --check: docs/BLUEPRINT_MAP_1.0.1.md == regenerated
#   13c statement_sync tools/check_statement_sync.py (r20: Theorem P3 statement byte-identical in paper and Blueprint; claims `conditions` phrases present in claims / paper / Blueprint) + --negctl (3 planted variants rejected)
#   13d novelty_matrix tools/gen_novelty_matrix.py --check (docs/NOVELTY_MATRIX.md == regenerated)
#   13e human_review   tools/gen_human_review.py --check (sign-off ledger + JSON == regenerated from the node list; r21)
#   00f ci_round_sync  tools/check_ci_round_sync.py (r21: no literal round in the workflow aggregator / this script; sage round == lean round == package round) + --negctl (4 planted)
#   00e release_metadata tools/check_release_metadata.py (r20: package round vs certificate round; forbidden notation a = 4^{N/3} etc.; current-facing pointers)
#   13 claims          docs/CLAIMS_1.0.1.yaml loads; verifier sha256 matches; evidence paths exist; Lean decls present; CORRESPONDENCE.csv == regenerated
set -u
ROOT="$(cd "$(dirname "$0")/.." && pwd)"; cd "$ROOT"
ROUND=$(sed -n 's/^version: "\{0,1\}\([A-Za-z0-9.][A-Za-z0-9.]*\)"\{0,1\}$/\1/p' CITATION.cff)   # r21: the package round, single source = CITATION.cff (never a literal here)
if [ -z "$ROUND" ]; then echo "verify_all_portable: CITATION.cff has no version: rNN line"; exit 2; fi
OUT="${VERIFY_OUT:-$ROOT/verify_out}"; mkdir -p "$OUT"   # VERIFY_OUT: tools/verifier_profile_tests.sh writes to a temp dir
SUMMARY="$OUT/VERIFY_ALL_PORTABLE.log"; : > "$SUMMARY"
LANES="${LANES:-4}"
if [ -z "${SAGE_BIN:-}" ]; then SAGE="$(command -v sage || true)"; else SAGE="$SAGE_BIN"; fi
FAIL=0; SKIPS=0; STEPLOG=""
PROFILE="${VERIFY_PROFILE:-full}"
case "$PROFILE" in full|sage|lean) ;; *) echo "VERIFY_PROFILE must be full|sage|lean (got '$PROFILE')"; exit 2 ;; esac
sha() { python3 -c 'import sys,hashlib; print(hashlib.sha256(open(sys.argv[1],"rb").read()).hexdigest())' "$1"; }
say() { echo "$*" | tee -a "$SUMMARY"; }
mark() { STEPLOG="$STEPLOG$1=$2;"; }
step() {  # step <name> <log> <cmd...> ; passes iff exit 0
  local name="$1" log="$2"; shift 2
  "$@" > "$log" 2>&1; local rc=$?; echo "EXIT=$rc" >> "$log"
  if [ $rc -ne 0 ]; then say "== [$name] FAIL (exit $rc, log $log)"; FAIL=1; mark "$name" FAIL; else say "== [$name] OK"; mark "$name" OK; fi
  return $rc
}
need() {  # need <name> <log> <pattern> : the log must contain the pattern
  if grep -q -- "$3" "$2"; then :; else say "== [$1] FAIL (pattern not found: $3)"; FAIL=1; mark "$1" FAIL; fi
}
skip() {  # skip <name> <reason> : counted; a FAIL in profile full, and in a partial profile when the step belongs to that profile
  local name="$1" reason="$2" kind="${3:-other}"   # kind: sage | lean | pdf | other
  SKIPS=$((SKIPS+1)); mark "$name" SKIP
  if [ "$PROFILE" = full ] || { [ "$PROFILE" = sage ] && [ "$kind" = sage ]; } || { [ "$PROFILE" = lean ] && [ "$kind" = lean ]; }; then
    say "== [$name] SKIP ($reason) -> FAIL in profile $PROFILE"; FAIL=1
  else
    say "== [$name] SKIP ($reason) (allowed in profile $PROFILE)"
  fi
}
finish() {  # writes SUMMARY.json and the profile's final line; never prints the FULL line in a partial profile
  python3 - "$OUT/SUMMARY.json" "$PROFILE" "$FAIL" "$SKIPS" "$STEPLOG" "$ROUND" <<'PY'
import sys,json,datetime
out,prof,fail,skips,steplog,rnd=sys.argv[1],sys.argv[2],int(sys.argv[3]),int(sys.argv[4]),sys.argv[5],sys.argv[6]
steps=dict(x.split('=',1) for x in steplog.split(';') if x)
status='PASS' if fail==0 else 'FAIL'
json.dump(dict(round=rnd,profile=prof,status=status,fails=sum(v=='FAIL' for v in steps.values()),skips=skips,steps=steps,
               full_line_printed=(prof=='full'),finished=datetime.datetime.now(datetime.timezone.utc).strftime('%Y-%m-%dT%H:%M:%SZ')),open(out,'w'),indent=1)
PY
  say "=================================================="
  say "profile $PROFILE ; skips $SKIPS ; summary $OUT/SUMMARY.json"
  case "$PROFILE" in
    full) if [ $FAIL -eq 0 ]; then say "VERIFY_ALL_PORTABLE $ROUND FULL: PASS ($(date -u +%Y-%m-%dT%H:%M:%SZ))"; else say "VERIFY_ALL_PORTABLE $ROUND FULL: FAIL ($(date -u +%Y-%m-%dT%H:%M:%SZ))"; fi ;;
    sage) if [ $FAIL -eq 0 ]; then say "SAGE_PROFILE: PASS ($(date -u +%Y-%m-%dT%H:%M:%SZ)) [partial profile; not a full verification]"; else say "SAGE_PROFILE: FAIL ($(date -u +%Y-%m-%dT%H:%M:%SZ))"; fi ;;
    lean) if [ $FAIL -eq 0 ]; then say "LEAN_PROFILE: PASS ($(date -u +%Y-%m-%dT%H:%M:%SZ)) [partial profile; not a full verification]"; else say "LEAN_PROFILE: FAIL ($(date -u +%Y-%m-%dT%H:%M:%SZ))"; fi ;;
  esac
  exit $FAIL
}
say "verify_all_portable $ROUND started $(date -u +%Y-%m-%dT%H:%M:%SZ) ; root $ROOT ; profile $PROFILE ; sage ${SAGE:-none} ; lean_workspace ${LEAN_WORKSPACE:-unset}"
# ---- PRECHECK: what this profile requires must be present BEFORE any step runs ----
PRE=0
sage_avail=1; if [ "${SKIP_SAGE:-0}" = "1" ] || [ -z "${SAGE:-}" ] || [ ! -x "${SAGE:-/nonexistent}" ]; then sage_avail=0; fi
lean_avail=1; if [ -z "${LEAN_WORKSPACE:-}" ] || [ ! -d "${LEAN_WORKSPACE:-/nonexistent}" ]; then lean_avail=0; fi
pdf_avail=1;  if [ "${SKIP_PAPER:-0}" = "1" ] || ! command -v pdflatex >/dev/null 2>&1; then pdf_avail=0; fi
if [ "$PROFILE" = full ]; then
  [ $sage_avail -eq 1 ] || { say "== [precheck] FAIL: profile full requires Sage (SKIP_SAGE=${SKIP_SAGE:-0}, sage=${SAGE:-none})"; PRE=1; }
  [ $lean_avail -eq 1 ] || { say "== [precheck] FAIL: profile full requires LEAN_WORKSPACE (got '${LEAN_WORKSPACE:-}')"; PRE=1; }
  [ $pdf_avail -eq 1 ]  || { say "== [precheck] FAIL: profile full requires pdflatex and SKIP_PAPER!=1"; PRE=1; }
elif [ "$PROFILE" = sage ]; then
  [ $sage_avail -eq 1 ] || { say "== [precheck] FAIL: profile sage requires Sage (SKIP_SAGE=${SKIP_SAGE:-0}, sage=${SAGE:-none})"; PRE=1; }
else
  [ $lean_avail -eq 1 ] || { say "== [precheck] FAIL: profile lean requires LEAN_WORKSPACE (got '${LEAN_WORKSPACE:-}')"; PRE=1; }
fi
if [ $PRE -ne 0 ]; then FAIL=1; mark precheck FAIL; say "== [precheck] FAIL: nothing executed"; finish; fi
say "== [precheck] OK (profile $PROFILE: sage_avail=$sage_avail lean_avail=$lean_avail pdf_avail=$pdf_avail)"; mark precheck OK
if [ "${VERIFY_PRECHECK_ONLY:-0}" = "1" ]; then say "PRECHECK_ONLY: stopping after the precheck"; finish; fi

# 01 manifest
step manifest "$OUT/01_manifest.log" python3 tools/gen_manifest.py --check

# 00b E13-1 constant synchronisation (python only; r13)
step floor_sync "$OUT/00b_floor_sync.log" python3 tools/check_floor_sync.py
need floor_sync "$OUT/00b_floor_sync.log" "FLOOR SYNC: PASS"

# 00c E14-1/E14-2 single-source numbers in every medium (python only; r14)
step constant_sync "$OUT/00c_constant_sync.log" python3 tools/check_constant_sync.py
need constant_sync "$OUT/00c_constant_sync.log" "CONSTANT SYNC: PASS"
# 00d the gates themselves: 13 planted defects must be caught (python only; tree untouched; r14)
step tools_negctl "$OUT/00d_tools_negctl.log" python3 tools/negctl_tools_r14.py
need tools_negctl "$OUT/00d_tools_negctl.log" "TOOLS NEGCTL: PASS"

# 02 environment: recorded versions asserted against the running tools (r12 hw 156-158)
step environment "$OUT/02_environment.log" env SAGE_BIN="${SAGE:-}" SKIP_SAGE="${SKIP_SAGE:-0}" LEAN_WORKSPACE="${LEAN_WORKSPACE:-}" python3 - <<'PY'
import os,re,subprocess,sys,json
bad=0
def rec(f): return open('environment/'+f).read()
print('--- recorded'); [print(rec(f).strip()) for f in ('sage_version.txt','pari_version.txt','arb_version.txt','lean_version.txt')]
print('--- asserted')
sage=os.environ.get('SAGE_BIN','')
if os.environ.get('SKIP_SAGE','0')!='1' and sage:
    out=subprocess.run([sage,'-c','import sage.version; print(sage.version.version); print(pari.version()); import sage.env; print(sage.env.SAGE_LOCAL)'],capture_output=True,text=True,timeout=600).stdout.split('\n')
    sv,pv,local=out[0].strip(),out[1].strip(),out[2].strip()
    want_s=re.search(r'SageMath version ([0-9.]+)',rec('sage_version.txt')).group(1)
    want_p=re.search(r'PARI/GP[^:]*: ([0-9.]+)',rec('pari_version.txt')).group(1)
    ok=(sv==want_s); print('sage version: running %s recorded %s -> %s'%(sv,want_s,'OK' if ok else 'FAIL')); bad+=not ok
    pv_dot='.'.join(re.findall(r'\d+',pv)); ok=(pv_dot==want_p); print('pari version: running %s recorded %s -> %s'%(pv_dot,want_p,'OK' if ok else 'FAIL')); bad+=not ok
    want_f=re.search(r'FLINT exact version: ([0-9.]+)',rec('arb_version.txt')).group(1)
    hdr=os.path.join(local,'include','flint','flint.h')
    if os.path.exists(hdr):
        h=open(hdr).read(); m=re.search(r'__FLINT_VERSION (\d+)',h); n=re.search(r'__FLINT_VERSION_MINOR (\d+)',h); q=re.search(r'__FLINT_VERSION_PATCHLEVEL (\d+)',h)
        fv='%s.%s.%s'%(m.group(1),n.group(1),q.group(1)); ok=(fv==want_f); print('flint version (header): running %s recorded %s -> %s'%(fv,want_f,'OK' if ok else 'FAIL')); bad+=not ok
    else:
        print('flint version: header %s absent in this Sage installation -> WARN (not asserted; recorded %s)'%(hdr,want_f))
else:
    print('sage asserts: SKIP (SKIP_SAGE=1 or no sage)')
ws=os.environ.get('LEAN_WORKSPACE','')
if ws and os.path.isdir(ws):
    tc=open(os.path.join(ws,'lean-toolchain')).read().strip(); want_t=re.search(r'Lean toolchain : (\S+)',rec('lean_version.txt')).group(1)
    ok=(tc==want_t); print('lean toolchain: workspace %s recorded %s -> %s'%(tc,want_t,'OK' if ok else 'FAIL')); bad+=not ok
    man=json.load(open(os.path.join(ws,'lake-manifest.json'))); revs=[pk.get('rev','') for pk in man.get('packages',[]) if pk.get('name')=='mathlib']
    want_m=re.search(r'mathlib commit : ([0-9a-f]+)',rec('lean_version.txt')).group(1)
    ok=(revs and revs[0]==want_m); print('mathlib pin: workspace %s recorded %s -> %s'%(revs,want_m,'OK' if ok else 'FAIL')); bad+=not ok
else:
    print('lean asserts: SKIP (LEAN_WORKSPACE unset)')
print('ENVIRONMENT ASSERT: %s'%('PASS' if not bad else 'FAIL %d'%bad)); sys.exit(1 if bad else 0)
PY
need environment "$OUT/02_environment.log" "ENVIRONMENT ASSERT: PASS"

# 03 twoadic rank (python only)
step twoadic_rank "$OUT/03_twoadic_rank.log" python3 scripts/verify_twoadic_rank.py
need twoadic_rank "$OUT/03_twoadic_rank.log" "VERIFY_TWOADIC_RANK: PASS"

# 13b blueprint map: paper / Blueprint / Lean / certificate table regenerated == shipped (r12 hw 190)
step blueprint_map "$OUT/13b_blueprint_map.log" python3 tools/gen_blueprint_map.py --check
need blueprint_map "$OUT/13b_blueprint_map.log" "BLUEPRINT MAP CHECK: PASS"

# 13c statement sync (r20, GPT r19 items 14, 25-31): the Theorem P3 statement is byte-identical in paper and Blueprint; every claim with
# a `conditions` block has each true condition's phrase in the claims statement and in both statement texts; three planted variants rejected
step statement_sync "$OUT/13c_statement_sync.log" python3 tools/check_statement_sync.py
need statement_sync "$OUT/13c_statement_sync.log" "STATEMENT SYNC: PASS"
step statement_sync_negctl "$OUT/13c_statement_sync_negctl.log" python3 tools/check_statement_sync.py --negctl
need statement_sync_negctl "$OUT/13c_statement_sync_negctl.log" "STATEMENT SYNC NEGCTL: PASS"

# 13d novelty matrix (r20, LETTER question (10) default): docs/NOVELTY_MATRIX.md == regenerated from the claims
step novelty_matrix "$OUT/13d_novelty_matrix.log" python3 tools/gen_novelty_matrix.py --check
need novelty_matrix "$OUT/13d_novelty_matrix.log" "NOVELTY MATRIX CHECK: PASS"

# 13e human-review ledger (r21, GPT r20 items 37-40): docs/BLUEPRINT_HUMAN_REVIEW_1.0.1.md + docs/human_review_1.0.1.json == regenerated from the current node list
step human_review "$OUT/13e_human_review.log" python3 tools/gen_human_review.py --check
need human_review "$OUT/13e_human_review.log" "HUMAN REVIEW LEDGER CHECK: PASS"

# 00e release metadata (r20, GPT r19 items 22-23): package-round vs certificate-round pointers; forbidden notation in the active proof source
step release_metadata "$OUT/00e_release_metadata.log" python3 tools/check_release_metadata.py
need release_metadata "$OUT/00e_release_metadata.log" "RELEASE METADATA SYNC: PASS"

# 00f CI round sync (r21, GPT r20 sect 4 / P0): the workflow aggregator carries no literal round and reads the package round from CITATION.cff;
# this script derives its round from the same line; claims and release metadata agree; four planted stale rounds rejected
step ci_round_sync "$OUT/00f_ci_round_sync.log" python3 tools/check_ci_round_sync.py
need ci_round_sync "$OUT/00f_ci_round_sync.log" "CI ROUND SYNC: PASS"
step ci_round_sync_negctl "$OUT/00f_ci_round_sync_negctl.log" python3 tools/check_ci_round_sync.py --negctl
need ci_round_sync_negctl "$OUT/00f_ci_round_sync_negctl.log" "CI ROUND SYNC NEGCTL: PASS"

# 04b C_n constants: JSON certificate from the digamma-route log == Table tab:Cn rows (python only; r12 hw 206-207)
step cn_certs "$OUT/04b_cn_certs.log" python3 tools/gen_cn_certs.py --check
need cn_certs "$OUT/04b_cn_certs.log" "CN CERT CHECK: PASS"
# 04e p = 3 covolume certificate (r19, format v3): ROLE 1 = producer-record consistency (inputs' sha256, certified = widen_x2(hull(producer, readonly)) recomputed, two routes agree, improvement over MO2016 in both classes, displayed numbers of Cor P3n4 / Table tab:p3)
step p3_cert "$OUT/04e_p3_cert.log" python3 tools/check_p3_cert.py
need p3_cert "$OUT/04e_p3_cert.log" "P3 CERT CHECK: PASS"
# 04e2 the certificate regenerates byte-identically (modulo timestamp) from its two shipped inputs (tools/gen_p3_cert_r19.py --check)
step p3_cert_gen "$OUT/04e2_p3_cert_gen.log" python3 tools/gen_p3_cert_r19.py --check
need p3_cert_gen "$OUT/04e2_p3_cert_gen.log" "P3 CERT R19 GEN CHECK: PASS"
# 04g ROLE 3 = certificate COVERAGE on the shipped read-only recomputation: 120/120 shipped intervals CONTAIN the recomputed ones (python only)
step p3_containment "$OUT/04g_p3_containment.log" python3 tools/check_p3_containment.py
need p3_containment "$OUT/04g_p3_containment.log" "P3 CONTAINMENT: PASS (120/120"
# 04h the p = 3 negative-control ledger (docs/P3_NEGCTL_LEDGER_R19.md) regenerates from its single JSON; planted == rejected; summary agrees
step p3_negctl_ledger "$OUT/04h_p3_negctl_ledger.log" python3 tools/gen_p3_negctl_ledger.py --check
need p3_negctl_ledger "$OUT/04h_p3_negctl_ledger.log" "P3 NEGCTL LEDGER: PASS"

# 03b KY1000 target list = the first 1000 primes > 10^9 in class 65 mod 128 (python only; r12 hw 159-170)
step ky1000_target "$OUT/03b_ky1000_target.log" python3 scripts/verify_ky1000_target.py
need ky1000_target "$OUT/03b_ky1000_target.log" "KY1000 TARGET VERIFY: PASS"
# 03c its negative controls: 5 planted corruptions of the list must be REJECTED (r12 hw 216-219)
step ky1000_target_negctl "$OUT/03c_ky1000_target_negctl.log" python3 scripts/verify_ky1000_target.py --negctl
need ky1000_target_negctl "$OUT/03c_ky1000_target_negctl.log" "KY1000 TARGET NEGCTL: ALL_REJECTED 5/5"

if [ $sage_avail -eq 1 ]; then
  {
    say "== sage: $("$SAGE" --version 2>/dev/null | head -1)"
    # 04 Prop D audit + rigorous C_7 ball
    step propD "$OUT/04_propD.log" "$SAGE" sage/r11_propD_audit.sage
    need propD "$OUT/04_propD.log" "R11 PROPD AUDIT DONE"
    need propD "$OUT/04_propD.log" "n= 7  prod(1-chi(3)) = 2  ; Phi_{2^n}(1) = 2"
    need propD "$OUT/04_propD.log" "deg-2 threshold 1314283897427173^2 > C_7.upper(): True"
    need propD "$OUT/04_propD.log" "deg-1 threshold 1727342163036353095979941756929 > C_7.upper(): True"
    # 04c the interval certificate is regenerated into verify_out/ and must equal the shipped one field by field (r14, E14-1)
    step cn_interval "$OUT/04c_cn_interval.log" env CN_OUT="$OUT/Cn_interval_fresh.json" "$SAGE" sage/r14_cn_interval.sage
    need cn_interval "$OUT/04c_cn_interval.log" "R14 CN INTERVAL DONE PASS"
    step cn_interval_compare "$OUT/04c_cn_interval_compare.log" python3 - "$OUT/Cn_interval_fresh.json" <<'PY'
import sys,json
a=json.load(open(sys.argv[1])); b=json.load(open('certificates/constants/Cn_interval_r14.json'))
for k in ('log',): a.pop(k,None); b.pop(k,None)
diff=[k for k in set(a)|set(b) if a.get(k)!=b.get(k)]
print('fresh interval certificate vs shipped: %s'%('IDENTICAL' if not diff else 'DIFF in '+', '.join(sorted(diff))))
sys.exit(1 if diff else 0)
PY
    need cn_interval_compare "$OUT/04c_cn_interval_compare.log" "IDENTICAL"
    # 04d cross-CAS routes as intervals (r14, E14-3)
    step cross_cas "$OUT/04d_cross_cas.log" env XCAS_OUT="$OUT/C7_cross_cas_fresh.json" "$SAGE" sage/r14_cross_cas_audit.sage
    need cross_cas "$OUT/04d_cross_cas.log" "CROSS-CAS AUDIT: PASS"
    step cross_cas_compare "$OUT/04d_cross_cas_compare.log" python3 - "$OUT/C7_cross_cas_fresh.json" <<'PY'
import sys,json
a=json.load(open(sys.argv[1])); b=json.load(open('certificates/constants/C7_cross_cas_r14.json'))
diff=[k for k in set(a)|set(b) if a.get(k)!=b.get(k)]
print('fresh cross-CAS audit vs shipped: %s'%('IDENTICAL' if not diff else 'DIFF in '+', '.join(sorted(diff))))
sys.exit(1 if diff else 0)
PY
    need cross_cas_compare "$OUT/04d_cross_cas_compare.log" "IDENTICAL"
    # 04f p = 3 certificate READ-ONLY REPLAY (r18 GPT r17 items 12-31; r19 GPT r18 items 1-24): ROLE 2 = semantic recomputation: every quantity
    #     rebuilt from the definitions in Arb at 4000 bits (eta_n, all conjugate logs, Gram route by Gram-Schmidt, DFT/character-product route,
    #     intersection, floor, C3rel, MO2016 G); the shipped exact dyadic intervals must CONTAIN the recomputed ones (120/120; overlap is
    #     not accepted); then twelve planted certificates must be REJECTED. Writes only to verify_out/.
    rm -rf "$OUT/p3_readonly"; mkdir -p "$OUT/p3_readonly"
    step p3_readonly "$OUT/04f_p3_readonly.log" "$SAGE" scripts/verify_p3_readonly.sage --out "$OUT/p3_readonly" --negctl
    need p3_readonly "$OUT/04f_p3_readonly.log" "P3 READONLY VERIFY: PASS (rows 15, prec 4000, containment 120/120"
    need p3_readonly "$OUT/04f_p3_readonly.log" "P3 READONLY NEGCTL: PASS (12/12 rejected)"
    # 04g_fresh coverage re-decided on the FRESH recomputation of this run (ROLE 3 on fresh input); 04h_fresh the fresh negative-control JSON
    #     must render the same ledger as the shipped docs/P3_NEGCTL_LEDGER_R19.md (counts, verdicts, reasons, sha256)
    step p3_containment_fresh "$OUT/04g_p3_containment_fresh.log" python3 tools/check_p3_containment.py --recomputed "$OUT/p3_readonly/p3_readonly_recomputed.json"
    need p3_containment_fresh "$OUT/04g_p3_containment_fresh.log" "P3 CONTAINMENT: PASS (120/120"
    step p3_negctl_ledger_fresh "$OUT/04h_p3_negctl_ledger_fresh.log" env P3_NEGCTL_JSON="$OUT/p3_readonly/p3_negctl_ledger.json" P3_SUMMARY_JSON="$OUT/p3_readonly/p3_readonly_summary.json" python3 tools/gen_p3_negctl_ledger.py --check
    need p3_negctl_ledger_fresh "$OUT/04h_p3_negctl_ledger_fresh.log" "P3 NEGCTL LEDGER: PASS"
    # 05 C_7 interval (r7 dual route) + flagship 1000000321 (r7 verifier, 64 certificates)
    step c7 "$OUT/05_c7_dualroute.log" "$SAGE" sage/r7_blichfeldt_dualroute.sage
    need c7 "$OUT/05_c7_dualroute.log" "R7 DUALROUTE CERT DONE"
    need c7 "$OUT/05_c7_dualroute.log" "threshold sanity: minimal <= in-use : True"
    step flagship "$OUT/05_flagship.log" "$SAGE" scripts/verify_flagship.sage
    need flagship "$OUT/05_flagship.log" "R7 FLAGSHIP VERIFY PASS"
    # 06 KY1000: every one of the 1000 witness files through the read-only verifier
    rm -rf "$OUT/family_ky1000"; mkdir -p "$OUT/family_ky1000"
    step ky1000 "$OUT/06_ky1000.log" env SAGE_BIN="$SAGE" bash scripts/family_verify_clean.sh \
      sage/family_ky1000/KY1000_primes.txt certificates/family/KY1000 "$OUT/family_ky1000" "$LANES"
    need ky1000 "$OUT/06_ky1000.log" "FAMILY VERIFY CLEAN PASS 1000/1000"
    # 07 numbers: fresh SUMMARY vs shipped ledger SUMMARY vs paper Table (sect 6.3)
    step ky1000_numbers "$OUT/07_ky1000_numbers.log" python3 - "$OUT/family_ky1000/VERIFY_LEDGER.txt" <<'PY'
import sys,re
fresh=[l for l in open(sys.argv[1]) if l.startswith('# SUMMARY')][0]
ship=[l for l in open('sage/family_ky1000_r11_clean/VERIFY_LEDGER.txt') if l.startswith('# SUMMARY')][0]
def parse(s):
    m=re.search(r'primes (\d+) ; T certificates (\d+) ; RHO certificates (\d+) ; T-only components (\d+) ; max T ([0-9.]+) ; min margin 4224-maxT ([0-9.]+) ; median T ([0-9.]+)',s)
    return m.groups()
f,s=parse(fresh),parse(ship)
print('fresh  :',f); print('shipped:',s)
assert f==s, 'fresh ledger SUMMARY differs from the shipped ledger SUMMARY'
# per-prime comparison keyed by prime (parallel lanes may reorder lines): verdict, ncert/ncomp, witness sha256, verifier-log sha256
rows=lambda path:{l.split(' | ')[0].strip():[x.strip() for x in l.split(' | ')] for l in open(path) if ' | ' in l and not l.startswith('#')}
A,B=rows(sys.argv[1]),rows('sage/family_ky1000_r11_clean/VERIFY_LEDGER.txt')
assert set(A)==set(B) and len(A)==1000, 'prime sets differ or count != 1000 (%d / %d)'%(len(A),len(B))
d4=[k for k in A if A[k][:4]!=B[k][:4]]; d5=[k for k in A if A[k][4]!=B[k][4]]
assert not d4, 'per-prime verdict/components/witness-sha differ for %d primes, e.g. %s'%(len(d4),d4[:3])
print('per-prime rows (verdict, components, witness sha256): 1000/1000 equal')
print('per-prime raw verifier-log sha256: %d/1000 equal (FORENSIC only from r13; not a gate — raw logs may differ across platforms)'%(1000-len(d5)))
tex=open('paper/draft/main_1.0.1.tex').read()
want=[f[1],f[2],f[3],'%.4f'%float(f[4]),'%.4f'%float(f[5]),'%.4f'%float(f[6]),'4224']
for w in want:
    assert w in tex, 'paper does not contain %s'%w
    print('paper contains',w)
nexc=sum(1 for l in open(sys.argv[1]) if '| EXCLUDED |' in l)
assert nexc==1000==int(f[0]), 'EXCLUDED count %d'%nexc
print('KY1000 NUMBERS CONSISTENT')
PY
    need ky1000_numbers "$OUT/07_ky1000_numbers.log" "KY1000 NUMBERS CONSISTENT"
    # 07b normalized per-prime comparison (r13, GPT r12 hw 27-30): verdict / components / witness sha / line counts /
    #     accepted RHO and T counts / max T upper / min rho upper, parsed from the verifier logs; raw-log sha256 demoted to forensic
    step ky1000_normalized "$OUT/07b_ky1000_normalized.log" python3 tools/ledger_summary.py --compare sage/family_ky1000_r11_clean "$OUT/family_ky1000"
    need ky1000_normalized "$OUT/07b_ky1000_normalized.log" "LEDGER NORMALIZED COMPARE: PASS"
    # 08 negative controls (9 planted corruptions of passing witnesses + the n=2 positive control; r13)
    step negctl "$OUT/08_negctl.log" env SAGE_BIN="$SAGE" bash scripts/family_negctl.sh certificates/family/KY1000/witness_n7_l1000000321.txt
    need negctl "$OUT/08_negctl.log" "NEGATIVE CONTROLS ALL_REJECTED"
    if [ "$(grep -c 'REJECTED (correct)' "$OUT/08_negctl.log")" != "9" ]; then say "== [negctl] FAIL (expected 9 REJECTED lines)"; FAIL=1; fi
    need negctl "$OUT/08_negctl.log" "n2 positive control (bar_T = 68): EXCLUDED (correct)"
    # fresh counts == shipped ledger (the single source of every "9/9" in the prose; r14 E14-2)
    step negctl_ledger "$OUT/08b_negctl_ledger.log" env NEGCTL_LOG="$OUT/08_negctl.log" python3 tools/gen_negctl_ledger.py --check --counts-only
    need negctl_ledger "$OUT/08b_negctl_ledger.log" "NEGCTL LEDGER: PASS"
  }
else
  skip "sage steps 04-08" "SKIP_SAGE=${SKIP_SAGE:-0} sage=${SAGE:-none}" sage
fi

# 09 Lean: the twelve load-bearing files (one lake call per file; WeberCertFloor added r13; WeberOddTransfer added r15, E15-1; WeberHatC + WeberSH + WeberLemmaB + WeberRoots + WeberP3 added r16; WeberP3Rel (13 decl) added r18)
if [ $lean_avail -eq 1 ]; then
  mkdir -p "${LEAN_WORKSPACE}/weber_pv"
  LEAN_OK=1
  for f in WeberExternalResults WeberScalingNoGo WeberCertChainDirect WeberScalingS0 WeberCertFloor WeberOddTransfer WeberHatC WeberSH WeberLemmaB WeberRoots WeberP3 WeberP3Rel; do
    cp "lean/$f.lean" "${LEAN_WORKSPACE}/weber_pv/$f.lean"
    ( cd "${LEAN_WORKSPACE}" && lake env lean "weber_pv/$f.lean" ) > "$OUT/09_lean_$f.log" 2>&1; rc=$?
    echo "EXIT=$rc" >> "$OUT/09_lean_$f.log"
    python3 - "$OUT/09_lean_$f.log" "$rc" <<'PY' >> "$OUT/09_lean_$f.log" 2>&1 || LEAN_OK=0
import sys,re
log=open(sys.argv[1]).read(); rc=int(sys.argv[2])
std={'propext','Classical.choice','Quot.sound'}
bad=[]
# names may contain primes (ineq_t2'): anchor at line start and match up to the LAST quote before " depends"
ax=re.findall(r"^'(.+)' depends on axioms: \[([^\]]*)\]",log,re.M)
noax=re.findall(r"^'(.+)' does not depend on any axioms",log,re.M)
expected={'WeberExternalResults':3,'WeberScalingNoGo':5,'WeberCertChainDirect':4,'WeberScalingS0':6,'WeberCertFloor':6,'WeberOddTransfer':5,'WeberHatC':3,'WeberSH':7,'WeberLemmaB':4,'WeberRoots':4,'WeberP3':3,'WeberP3Rel':13}.get(sys.argv[1].split('09_lean_')[-1].replace('.log',''))
if expected is not None and len(ax)+len(noax)!=expected: bad.append('declaration count %d != expected %d (regex or file drift)'%(len(ax)+len(noax),expected))
if rc!=0: bad.append('exit %d'%rc)
if not ax and not noax: bad.append('no #print axioms line')
for name,lst in ax:
    s={x.strip() for x in lst.split(',') if x.strip()}
    if not s<=std: bad.append('%s: %s'%(name,sorted(s-std)))
for tok in ('sorryAx','native_decide','ofReduceBool','trustCompiler','sorry'):
    if re.search(r'\b'+tok+r'\b',log): bad.append('forbidden token '+tok)
print('AXIOM GATE: %d declarations (%d axiom-free) ; %s'%(len(ax)+len(noax),len(noax),'PASS' if not bad else 'FAIL '+'; '.join(bad)))
sys.exit(0 if not bad else 1)
PY
    if grep -q 'AXIOM GATE: .* PASS' "$OUT/09_lean_$f.log"; then say "== [lean $f] OK"; mark "lean_$f" OK; else say "== [lean $f] FAIL (log $OUT/09_lean_$f.log)"; LEAN_OK=0; mark "lean_$f" FAIL; fi
  done
  [ $LEAN_OK -eq 1 ] || FAIL=1
else
  skip lean "LEAN_WORKSPACE unset; axiom footprints on record: lean/compile10_external.log, lean/compile11_*.log, lean/compile13_webercertfloor.log, lean/compile15_weberoddtransfer.log — CI runs this step in the lean job" lean
fi

# 10 blueprint dependency graph
step blueprint "$OUT/10_blueprint.log" python3 blueprint/check_graph.py
need blueprint "$OUT/10_blueprint.log" "EVIDENCE-PRESENCE + HUMAN-PROOF PASS"
if grep -q "NO PROOF / CITATION / CERTIFICATE / LOG\|DANGLING\|LEANOK WITHOUT LEAN" "$OUT/10_blueprint.log"; then say "== [blueprint] FAIL (gate line)"; FAIL=1; fi
# 10c proof report (r14): every F/M node with its prose length; SHORT is a warning; the shipped report must be the regenerated one
step blueprint_report "$OUT/10c_blueprint_report.log" bash -c 'cp docs/BLUEPRINT_PROOF_REPORT_1.0.1.md "$0/shipped_report.md" && python3 blueprint/check_graph.py --report && cmp -s docs/BLUEPRINT_PROOF_REPORT_1.0.1.md "$0/shipped_report.md" && echo "PROOF REPORT == shipped" || { echo "PROOF REPORT differs from shipped"; exit 1; }' "$OUT"
need blueprint_report "$OUT/10c_blueprint_report.log" "PROOF REPORT == shipped"
# 10b blueprint pdf (two passes, same pdflatex rules as the paper)
if [ $pdf_avail -eq 0 ]; then
  skip blueprint_pdf "pdflatex absent or SKIP_PAPER=1; shipped PDF: blueprint/blueprint_1.0.1.pdf" pdf
else
  mkdir -p "$OUT/blueprint"
  step blueprint_pdf "$OUT/10b_blueprint_pdf.log" bash -c "cd blueprint/src && pdflatex -interaction=nonstopmode -halt-on-error -output-directory '$OUT/blueprint' print.tex >/dev/null && pdflatex -interaction=nonstopmode -halt-on-error -output-directory '$OUT/blueprint' print.tex >/dev/null"
  if grep -q '^!' "$OUT/blueprint/print.log" 2>/dev/null; then say "== [blueprint_pdf] FAIL (LaTeX error line)"; FAIL=1; fi
  if grep -qi 'undefined references\|undefined citations\|Citation .* undefined' "$OUT/blueprint/print.log" 2>/dev/null; then say "== [blueprint_pdf] FAIL (undefined refs)"; FAIL=1; fi
  pages=$(python3 -c 'import re,sys;s=open(sys.argv[1],errors="replace").read().replace("\n","");m=re.search(r"Output written on .*?\((\d+) pages",s);print(m.group(1) if m else "")' "$OUT/blueprint/print.log" 2>/dev/null)
  if [ -z "$pages" ] || [ "$pages" -lt 10 ]; then say "== [blueprint_pdf] FAIL (page count ${pages:-none} < 10)"; FAIL=1; else say "== [blueprint_pdf] pages $pages"; fi
fi

# 11 paper build (two passes; inline bibliography, no bibtex)
if [ $pdf_avail -eq 0 ]; then
  skip paper "pdflatex absent or SKIP_PAPER=1; shipped PDF: paper/draft/main_1.0.1.pdf" pdf
else
  mkdir -p "$OUT/paper"
  step paper "$OUT/11_paper.log" bash -c "cd paper/draft && pdflatex -interaction=nonstopmode -halt-on-error -output-directory '$OUT/paper' main_1.0.1.tex >/dev/null && pdflatex -interaction=nonstopmode -halt-on-error -output-directory '$OUT/paper' main_1.0.1.tex >/dev/null && grep -c 'Output written' '$OUT/paper/main_1.0.1.log'"
  if grep -q '^!' "$OUT/paper/main_1.0.1.log" 2>/dev/null; then say "== [paper] FAIL (LaTeX error line)"; FAIL=1; fi
  if grep -qi 'undefined references\|undefined citations\|Citation .* undefined' "$OUT/paper/main_1.0.1.log" 2>/dev/null; then say "== [paper] FAIL (undefined refs/citations)"; FAIL=1; fi
fi

# 12 stale placeholders in the shipped prose
step placeholders "$OUT/12_placeholders.log" bash -c '
PAT="\[Table:\|PLACEHOLDER\|TODO\|TBD\|FIXME\|<FILL>\|\\\\todo\|XXX"
FILES="paper/draft/main_1.0.1.tex blueprint/src/content.tex proofs/statements/*.tex README.md TRUST.md RELEASE_STATUS.md lean/README_lean.md theory/STATEMENT_FREEZE_1.0.1.md docs/ERRATA_R*.md CORRESPONDENCE.csv"
hits=$(grep -n -- "$PAT" $FILES | grep -v "^paper/draft/main_1.0.1.tex:[0-9]*:%" || true)
if [ -n "$hits" ]; then echo "$hits"; echo "PLACEHOLDERS FOUND"; exit 1; fi
echo "no placeholders in: $FILES"'

# 13 claims ledger
step claims "$OUT/13_claims.log" python3 - "$ROUND" <<'PY'
import yaml,os,re,hashlib,csv,io,subprocess,sys
d=yaml.safe_load(open('docs/CLAIMS_1.0.1.yaml'))
assert d['round']==sys.argv[1], (d['round'], sys.argv[1])   # r21: the package round comes from CITATION.cff, not from a literal
v=d['verifier']; h=hashlib.sha256(open(v['file'],'rb').read()).hexdigest()
assert h==v['sha256'], 'verifier sha256 drift: %s != %s'%(h,v['sha256'])
print('verifier', v['file'], 'sha256 matches')
bad=0
for c in d['claims']:
    for e in c.get('evidence',[]):
        if not os.path.exists(e): print('MISSING evidence', c['id'], e); bad+=1
    if c.get('lean'):
        files=[x.strip() for x in c['lean_file'].split(';')]
        src=''.join(open(f).read() for f in files)
        for decl in c['lean']:
            short=decl.split('.')[-1]
            if not re.search(r'\b(theorem|lemma|def)\s+'+re.escape(short)+r'\b',src): print('MISSING lean decl',c['id'],decl); bad+=1
print('claims: %d ; missing: %d'%(len(d['claims']),bad))
# CORRESPONDENCE.csv must be exactly what the generator produces
buf=io.StringIO(); w=csv.writer(buf)
w.writerow(['claim_id','paper_location','statement_short','trust_label','lean_declaration','lean_file','certificate_or_log','literature_inputs','status_'+str(d['date']).split(' ')[0]+'_'+d['round']])
for c in d['claims']:
    w.writerow([c['id'],c.get('paper',''),c['statement'],c['label'],'; '.join(c.get('lean',[])) or '-',c.get('lean_file','-'),'; '.join(c.get('evidence',[])) or '-','; '.join(c.get('inputs',[])) or '-',c.get('status','')])
gen=buf.getvalue().replace('\r\n','\n'); ship=open('CORRESPONDENCE.csv').read().replace('\r\n','\n')
if gen!=ship: print('CORRESPONDENCE.csv is not the regenerated file'); bad+=1
else: print('CORRESPONDENCE.csv == regenerated')
sys.exit(1 if bad else 0)
PY

finish
