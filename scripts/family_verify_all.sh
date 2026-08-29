#!/bin/bash
# SUPERSEDED in r11 by family_verify_clean.sh (release layout certificates/family/KY1000/); kept as the r10 generation-time record.
# family_verify_all.sh <listfile> <lanes> - waits for all generation lanes (LEDGER_L*.txt contain LANE DONE),
# then runs the READ-ONLY verifier on every witness file of the list in parallel lanes and writes
# sage/family_ky1000/VERIFY_LEDGER.txt : "l | verdict | ncert/ncomp | sha256(witness) | sha256(verifier log)".
SAGE="${SAGE_BIN:-$(command -v sage || true)}"  # r11: no author-machine fallback (hw 85)
[ -x "$SAGE" ] || { echo "$0: sage not found (set SAGE_BIN)"; exit 2; }
HERE="$(cd "$(dirname "$0")" && pwd)"; LIST="$1"; LANES="${2:-4}"; OUT="$(dirname "$LIST")"; VL="$OUT/verify_logs"; mkdir -p "$VL"
NL=$(ls "$OUT"/lane_* 2>/dev/null | wc -l | tr -d ' ')
while [ "$(grep -l 'LANE .* DONE' "$OUT"/LEDGER_L*.txt 2>/dev/null | wc -l | tr -d ' ')" -lt "$NL" ]; do sleep 30; [ -f "$OUT/KILL" ] && exit 1; done
echo "# verification started $(date)" > "$OUT/VERIFY_LEDGER.txt"
sha() { python3 -c 'import sys,hashlib; print(hashlib.sha256(open(sys.argv[1],"rb").read()).hexdigest())' "$1"; }
export -f sha
verify_one() {
  l="$1"; W="$HERE/../certificates/family/witness_n7_l$l.txt"; LOG="$VL/verify_n7_l$l.log"
  if [ ! -f "$W" ]; then echo "$l | MISSING_WITNESS | - | - | -"; return; fi
  "$SAGE" "$HERE/family_verify.sage" "$W" > "$LOG" 2>&1
  v="$(grep 'FAMILY VERIFY n=' "$LOG" | sed -E 's/.* : ([A-Z_]+) \(components certified ([0-9]+) \/ ([0-9]+).*/\1 | \2\/\3/')"
  echo "$l | ${v:-NO_VERDICT} | $(sha "$W") | $(sha "$LOG")"
}
export -f verify_one; export SAGE HERE VL
cat "$LIST" | xargs -P "$LANES" -I{} bash -c 'verify_one {}' >> "$OUT/VERIFY_LEDGER.txt"
echo "# verification finished $(date) ; EXCLUDED $(grep -c '| EXCLUDED |' "$OUT/VERIFY_LEDGER.txt") / $(wc -l < "$LIST" | tr -d ' ')" >> "$OUT/VERIFY_LEDGER.txt"
echo "R10 FAMILY VERIFY ALL DONE" >> "$OUT/VERIFY_LEDGER.txt"
