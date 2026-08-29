#!/bin/bash
# family_verify_clean.sh <listfile> <witness_dir> <outdir> [lanes]   (r11, GPT hw 54-55, 63, 65-66, 84-85)
# Clean, final-only verification of a witness family with the READ-ONLY verifier family_verify.sage.
# No generation lanes are awaited; the witness directory is taken as given (release layout:
# certificates/family/KY1000/). Writes <outdir>/VERIFY_LEDGER.txt with lines
#   l | verdict | ncert/ncomp | sha256(witness) | sha256(verifier log)
# and a SUMMARY block (counts, max T, median T, T-only components) computed from the witness files.
# Portable: sha256 via python3 hashlib; no md5 -q, no Mac absolute-path fallback.
set -u
if [ -z "${SAGE_BIN:-}" ]; then SAGE="$(command -v sage || true)"; else SAGE="$SAGE_BIN"; fi
[ -x "$SAGE" ] || { echo "family_verify_clean: sage not found (set SAGE_BIN)"; exit 2; }
LIST="$1"; WDIR="$2"; OUT="$3"; LANES="${4:-4}"
HERE="$(cd "$(dirname "$0")" && pwd)"; VL="$OUT/verify_logs"; mkdir -p "$VL"
export OPENBLAS_NUM_THREADS=1 OMP_NUM_THREADS=1
sha() { python3 -c 'import sys,hashlib; print(hashlib.sha256(open(sys.argv[1],"rb").read()).hexdigest())' "$1"; }
export -f sha
echo "# family_verify_clean started $(date -u +%Y-%m-%dT%H:%M:%SZ) ; verifier sha256 $(sha "$HERE/family_verify.sage") ; sage $("$SAGE" --version 2>/dev/null | head -1)" > "$OUT/VERIFY_LEDGER.txt"
verify_one() {
  l="$1"; W="$WDIR/witness_n7_l$l.txt"; LOG="$VL/verify_n7_l$l.log"
  if [ ! -f "$W" ]; then echo "$l | MISSING_WITNESS | - | - | -"; return; fi
  "$SAGE" "$HERE/family_verify.sage" "$W" > "$LOG" 2>&1
  v="$(grep 'FAMILY VERIFY n=' "$LOG" | sed -E 's/.* : ([A-Z_]+) \(components certified ([0-9]+) \/ ([0-9]+).*/\1 | \2\/\3/')"
  echo "$l | ${v:-NO_VERDICT} | $(sha "$W") | $(sha "$LOG")"
}
export -f verify_one; export SAGE HERE VL WDIR
tr -s ' \n' '\n\n' < "$LIST" | grep -E '^[0-9]+$' | xargs -P "$LANES" -I{} bash -c 'verify_one {}' >> "$OUT/VERIFY_LEDGER.txt"
NEXC=$(grep -c '| EXCLUDED |' "$OUT/VERIFY_LEDGER.txt"); NTOT=$(tr -s ' \n' '\n\n' < "$LIST" | grep -cE '^[0-9]+$')
python3 - "$LIST" "$WDIR" >> "$OUT/VERIFY_LEDGER.txt" <<'PY'
import sys,re,statistics
tl=[int(x) for x in open(sys.argv[1]).read().split() if x.isdigit()]
T=[];rho=0;tn=0;tonly=0;margin=None
for l in tl:
    comps={}
    for line in open(f"{sys.argv[2]}/witness_n7_l{l}.txt"):
        m=re.match(r'f = ([^|]+)\| route (\w+) \| claimed ([0-9.eE+-]+)',line)
        if m: comps.setdefault(m.group(1).strip(),{})[m.group(2)]=float(m.group(3))
    for d in comps.values():
        if 'T' in d: tn+=1; T.append(d['T'])
        if 'RHO' in d: rho+=1
        if 'T' in d and 'RHO' not in d: tonly+=1
print("# SUMMARY primes %d ; T certificates %d ; RHO certificates %d ; T-only components %d ; max T %.9f ; min margin 4224-maxT %.9f ; median T %.9f" % (len(tl),tn,rho,tonly,max(T),4224-max(T),statistics.median(T)))
PY
echo "# family_verify_clean finished $(date -u +%Y-%m-%dT%H:%M:%SZ) ; EXCLUDED $NEXC / $NTOT" >> "$OUT/VERIFY_LEDGER.txt"
[ "$NEXC" -eq "$NTOT" ] && echo "FAMILY VERIFY CLEAN PASS $NEXC/$NTOT" || echo "FAMILY VERIFY CLEAN FAIL $NEXC/$NTOT"
